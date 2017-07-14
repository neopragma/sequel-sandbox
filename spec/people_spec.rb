require_relative "../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'people table:' do

    before do
      @dbtest.clear_people
    end

    it 'deletes all rows from the people table' do
      expect(@dbtest.find_all_people.count).to eq 0
    end

    it 'inserts one row into the people table' do
      add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      expect(@dbtest.find_all_people.count).to eq 1
    end
    it 'inserts the expected values into a single row in the people table' do
      add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      expect(@dbtest.find_all_people.first[:surname]).to eq 'Bach'
      expect(@dbtest.find_all_people.first[:given_name]).to eq 'Carl Philip Emmanuel'
      expect(@dbtest.find_all_people.first[:nickname]).to eq 'C.P.E. Bach'
    end

    it 'returns the data for the specified person' do
      add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      add_person 'Bach', 'Johann Sebastian', ''
      expect(@dbtest.find_person('Bach', 'Johann Sebastian')[:surname])
        .to eq 'Bach'
      expect(@dbtest.find_person('Bach', 'Johann Sebastian')[:given_name])
        .to eq 'Johann Sebastian'
    end

    it 'returns all people matching on surname only' do
      add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      add_person 'Bach', 'Johann Sebastian', ''
      add_person 'Jones', 'Philip', ''
      expect(@dbtest.find_person_by_surname('Bach').count).to eq 2      
    end


=begin
    it 'returns all role data in ascending order by role_name' do
      @dbtest.add_roles([ "Soloist", "Arranger", "Engineer", "Conductor" ])
      result = @dbtest.find_all_roles.all
      expect(result[0][:role_name]).to eq 'Arranger'
      expect(result[1][:role_name]).to eq 'Conductor'
      expect(result[2][:role_name]).to eq 'Engineer'
      expect(result[3][:role_name]).to eq 'Soloist'
    end
=end
  end # describe roles table

end # context sequel gem

private

def add_person surname, given_name, nickname
  @dbtest.add_person({
    :surname => "#{surname}",
    :given_name => "#{given_name}",
    :nickname => "#{nickname}"
  })
end
