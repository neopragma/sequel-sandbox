require_relative "../app/db_helpers"

# Expresses behaviors of the people_roles association.

class Db
  include DbHelpers
end

# Actual is a Sequel dataset queried from the person table
# Expected is the string value of the role_name
RSpec::Matchers.define :be_associated_with_role do |expected|
  match do |actual|
    result = $dbtest.person_as_role(
      { :surname => actual[:surname],
        :given_name => actual[:given_name],
        :role_name => expected
      })
    result[:role_name] == expected unless result.count < 1
  end
end

# Actual is a Sequel dataset queried from the person table
# Expected is an array of string values of the expected role_names
RSpec::Matchers.define :be_associated_with_roles do |expected|
  match do |actual|
    expected.each do |expected_role_name|
      result = $dbtest.person_as_role(
        { :surname => actual[:surname],
          :given_name => actual[:given_name],
          :role_name => expected_role_name
        })
      result[:role_name] == expected_role_name unless result.count < 1
    end
  end
end

# Actual is a Sequel dataset that includes columns :surname and :given_name
# Expected is an array of hashes containing expected :surnames and :given_names
RSpec::Matchers.define :include_people do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :surname => row[:surname], :given_name => row[:given_name]})
    end
  end
end

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'roles table:' do

    before do
      $dbtest.clear_table :people
      $dbtest.clear_table :roles
      $dbtest.add_person 'Wagner', 'Richard', ''
      $dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      $dbtest.add_person 'Jones', 'Philip', ''
      $dbtest.add_person 'Bach', 'Johann Sebastian', ''
      $dbtest.add_roles([ 'Soloist', 'Composer' ])
    end

    it 'creates an association between a person and a role' do
      $dbtest.associate_person_with_role(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer'
        })

      expect($dbtest.person_by_full_name( 'Bach', 'Johann Sebastian'))
        .to be_associated_with_role 'Composer'
    end

    it 'creates an association between a person and multiple roles' do
      $dbtest.associate_person_with_roles(
      { :surname => 'Bach',
        :given_name => 'Johann Sebastian',
        :role_names => [ 'Composer', 'Soloist' ]
      })

      expect($dbtest.person_by_full_name( 'Bach', 'Johann Sebastian'))
        .to be_associated_with_roles([ 'Composer', 'Soloist' ])
    end

    it 'finds all people associated with a given role' do
      $dbtest.associate_person_with_role(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer'
        })
      $dbtest.associate_person_with_role(
        { :surname => 'Jones',
          :given_name => 'Philip',
          :role_name => 'Composer'
        })
      $dbtest.associate_person_with_role(
        { :surname => 'Wagner',
          :given_name => 'Richard',
          :role_name => 'Composer'
        })

      expect($dbtest.people_in_role('Composer'))
        .to include_people([
          { :surname => 'Bach', :given_name => 'Johann Sebastian'},
          { :surname => 'Jones', :given_name => 'Philip'},
          { :surname => 'Wagner', :given_name => 'Richard' }
        ])
    end

  end # describe person_roles table

end # context sequel gem
