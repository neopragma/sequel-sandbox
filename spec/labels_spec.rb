require_relative "../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'labels table:' do

    before do
      @dbtest.clear_table :labels
    end

    it 'deletes all rows from the labels table' do
      expect(@dbtest.labels.count).to eq 0
    end

    it 'inserts one row into the labels table' do
      @dbtest.add_label("London")
      expect(@dbtest.labels.count).to eq 1
    end

    it 'inserts the expected values into a single row of the labels table' do
      @dbtest.add_label("London")
      expect(@dbtest.labels.first[:label_name]).to eq 'London'
    end

    it 'inserts multiple rows into the label table' do
      @dbtest.add_labels([ "EMI", "Nonesuch" ])
      expect(@dbtest.labels.count).to eq 2
    end

    it 'returns the data for the specified label' do
      @dbtest.add_labels([ "EMI", "Nonesuch" ])
      expect(@dbtest.label('Nonesuch')[:label_name]).to eq 'Nonesuch'
    end

    it 'returns all label data in ascending order by label_name' do
      @dbtest.add_labels([ "London", "EMI", "Nonesuch", "Apple" ])
      result = @dbtest.labels.all
      expect(result[0][:label_name]).to eq 'Apple'
      expect(result[1][:label_name]).to eq 'EMI'
      expect(result[2][:label_name]).to eq 'London'
      expect(result[3][:label_name]).to eq 'Nonesuch'
    end

  end # describe labels table

end # context sequel gem
