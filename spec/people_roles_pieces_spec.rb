require_relative "../app/db_helpers"

# Expresses behaviors of the people_roles_pieces association.

class Db
  include DbHelpers
end

RSpec::Matchers.define :include_people do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :surname => row[:surname], :given_name => row[:given_name]})
    end
  end
end

RSpec::Matchers.define :include_pieces do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :title => row[:title], :subtitle => row[:subtitle]})
    end
  end
end

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'people_roles_pieces table:' do

    before do
      $dbtest.clear_table :people
      $dbtest.clear_table :pieces
      $dbtest.clear_table :roles
      $dbtest.add_person 'Bach', 'Johann Sebastian', ''
      $dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      $dbtest.add_person 'Byrd', 'William', ''
      $dbtest.add_person 'Jones', 'Philip', ''
      $dbtest.add_person 'Prince', '', 'Prince'
      $dbtest.add_person 'Wagner', 'Richard', ''

      $dbtest.add_roles([ 'Arranger', 'Composer', 'Performer', 'Soloist' ])

      $dbtest.associate_person_with_role(
        { :surname => 'Bach', :given_name => 'Carl Philip Emmanuel', :role_name => 'Composer' })
      $dbtest.associate_person_with_role(
        { :surname => 'Bach', :given_name => 'Johann Sebastian', :role_name => 'Composer' })
      $dbtest.associate_person_with_role(
        { :surname => 'Byrd', :given_name => 'William', :role_name => 'Composer' })
      $dbtest.associate_person_with_roles(
        { :surname => 'Prince', :given_name => '', :role_names => [ 'Composer', 'Performer' ] })
      $dbtest.associate_person_with_role(
        { :surname => 'Wagner', :given_name => 'Richard', :role_name => 'Composer' })
      $dbtest.associate_person_with_roles(
        { :surname => 'Jones', :given_name => 'Philip', :role_names => [ 'Arranger', 'Soloist' ]})

        $dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
        $dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'

      $dbtest.associate_person_role_with_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen'
        })

        $dbtest.associate_person_role_with_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Ach, mein hertzliches Jesulein'
        })
    end

    it 'identifies the composers of a given piece' do
      expect($dbtest.composers_of({
        :title => 'Christmas Oratorio',
        :subtitle => 'Nun seid Ihr wohl gerochen'
      })).to include_people([
        { :surname => 'Bach', :given_name => 'Johann Sebastian' }
      ])
    end

    it 'identifies the pieces written by a given composer' do
      expect($dbtest.composed_by({
        :surname => 'Bach', :given_name => 'Johann Sebastian'
      })).to include_pieces([
        { :title => 'Christmas Oratorio', :subtitle => 'Ach, mein hertzliches Jesulein' },
        { :title => 'Christmas Oratorio', :subtitle => 'Nun seid Ihr wohl gerochen' }
      ])
    end


  end # describe people_roles_pieces table

end # context sequel gem
