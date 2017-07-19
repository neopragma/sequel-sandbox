require_relative "../app/db_helpers"

# Expresses behaviors related to the recordings table

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'collections table:' do

    before do
      @dbtest.clear_table :collections
    end

    it 'deletes all rows from the collections table' do
      expect(@dbtest.collections.count).to eq 0
    end

    it 'inserts one row into the collections table' do
      @dbtest.add_collection 'PJBE - Brass Splendour', '1984', 'Some great brass playing'
      expect(@dbtest.collections.count).to eq 1
    end

    it 'inserts the expected values into a single row in the collections table' do
      @dbtest.add_collection 'PJBE - Brass Splendour', '1984', 'Some great brass playing'
      expect(@dbtest.collections.where(:title => 'PJBE - Brass Splendour').first)
        .to have_attributes({
          :title => 'PJBE - Brass Splendour',
          :year_released => '1984',
          :remarks => 'Some great brass playing'
          })
    end

    it 'returns all collections in ascending order by title' do
      @dbtest.add_collection 'B collection', '2000', 'Should be second'
      @dbtest.add_collection 'C collection', '2000', 'Should be third'
      @dbtest.add_collection 'A collection', '2000', 'Should be first'

      expect(@dbtest.recordings.all).to be_sorted_by_title_as [
        'A collection', 'B collection', 'C collection'
      ]
    end

  end # describe collections table

end # context sequel gem
