require_relative "../app/db_helpers"

# Expresses behaviors of the people_roles_pieces association.

class Db
  include DbHelpers
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

      $dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      $dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'

      $dbtest.associate_person_role_and_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen'
        })

        $dbtest.associate_person_role_and_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Ach, mein hertzliches Jesulein'
        })
    end

    it 'raises runtime error when the person is not in the people table' do
      expect{ $dbtest.associate_person_role_and_piece(
        { :surname => 'Neuman',
          :given_name => 'Alfred E.',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen'
        })
      }.to raise_error 'Alfred E. Neuman was not found in table: people'
    end

    it 'raises runtime error when the role is not in the roles table' do
      expect{ $dbtest.associate_person_role_and_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Necromancer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen'
        })
      }.to raise_error 'No role named Necromancer was found in table: roles'
    end

    it 'raises runtime error when the piece is not in the pieces table' do
      expect{ $dbtest.associate_person_role_and_piece(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :title => 'Christmas Oratorio',
          :subtitle => 'Das ist nicht mein schöner Untertitel'
        })
      }.to raise_error 'No piece was found in table pieces with title \'Christmas Oratorio\' and subtitle \'Das ist nicht mein schöner Untertitel\''
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
