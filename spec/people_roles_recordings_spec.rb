require_relative "../app/db_helpers"

# Expresses behaviors of the people_roles_recordings association.

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'people_roles_recordings table:' do

    before do
      $dbtest.clear_table :people
      $dbtest.clear_table :recordings
      $dbtest.clear_table :roles
      $dbtest.add_person 'Bach', 'Johann Sebastian', ''
      $dbtest.add_person 'Byrd', 'William', ''
      $dbtest.add_person 'Clarke', 'Jeremiah', ''
      $dbtest.add_person 'Howarth', 'Elgar', ''
      $dbtest.add_person 'Iveson', 'John', ''
      $dbtest.add_person 'Jones', 'Philip', ''

      $dbtest.add_roles([ 'Arranger', 'Composer', 'Performer', 'Soloist' ])

      $dbtest.add_recording 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 5.wav', 163, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 6.wav', 243, '1984-01-01', ''
  end

  it 'associates a person and role with a recording' do
      expect($dbtest.associate_person_role_and_recording(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })).to include_people([
          { :surname => 'Bach', :given_name => 'Johann Sebastian' }
        ])
  end

    it 'raises runtime error when the person is not in the people table' do
      expect{ $dbtest.associate_person_role_and_recording(
        { :surname => 'Neuman',
          :given_name => 'Alfred E.',
          :role_name => 'Composer',
          :filename => 'PJBE - Brass Splendour/Track 6.wav'
        })
      }.to raise_error 'Alfred E. Neuman was not found in table: people'
    end
    it 'raises runtime error when the role is not in the roles table' do
      expect{ $dbtest.associate_person_role_and_recording(
        { :surname => 'Jones',
          :given_name => 'Philip',
          :role_name => 'Necromancer',
          :filename => 'PJBE - Brass Splendour/Track 6.wav'
        })
      }.to raise_error 'No role named Necromancer was found in table: roles'
    end

    it 'raises runtime error when the recording is not in the recordings table' do
      expect{ $dbtest.associate_person_role_and_recording(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :filename => 'no such filename'
        })
      }.to raise_error 'No recording was found in table recordings with filename \'no such filename\''
    end

  end # describe people_roles_recordings table

end # context sequel gem
