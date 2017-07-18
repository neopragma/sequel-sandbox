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
      @dbtest.clear_table :people
    end

    it 'deletes all rows from the people table' do
      expect(@dbtest.people.count).to eq 0
    end

    it 'inserts one row into the people table' do
      @dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      expect(@dbtest.people.count).to eq 1
    end
    it 'inserts the expected values into a single row in the people table' do
      @dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      expect(@dbtest.people.first[:surname]).to eq 'Bach'
      expect(@dbtest.people.first[:given_name]).to eq 'Carl Philip Emmanuel'
      expect(@dbtest.people.first[:nickname]).to eq 'C.P.E. Bach'
    end

    it 'returns the data for the specified person' do
      @dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      @dbtest.add_person 'Bach', 'Johann Sebastian', ''
      expect(@dbtest.person_by_full_name('Bach', 'Johann Sebastian')[:surname])
        .to eq 'Bach'
      expect(@dbtest.person_by_full_name('Bach', 'Johann Sebastian')[:given_name])
        .to eq 'Johann Sebastian'
    end

    it 'returns all people matching on surname only' do
      @dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      @dbtest.add_person 'Bach', 'Johann Sebastian', ''
      @dbtest.add_person 'Jones', 'Philip', ''
      expect(@dbtest.person_by_surname('Bach').count).to eq 2
    end

    it 'returns all person data in ascending order by surname, given_name' do
      @dbtest.add_person 'Wagner', 'Richard', ''
      @dbtest.add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
      @dbtest.add_person 'Jones', 'Philip', ''
      @dbtest.add_person 'Bach', 'Johann Sebastian', ''

      expect(@dbtest.people.all).to be_sorted_by_name_as [
        [ 'Bach', 'Carl Philip Emmanuel' ],
        [ 'Bach', 'Johann Sebastian' ],
        [ 'Jones', 'Philip' ],
        [ 'Wagner', 'Richard' ]
      ]
    end

  end # describe people table

end # context sequel gem
