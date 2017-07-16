require_relative "../app/db_helpers"

# Expresses behaviors related to the pieces table

class Db
  include DbHelpers
end

RSpec::Matchers.define :be_sorted_as do |expected|
  match do |actual|
    actual.each_with_index do |row_values, index|
      (row_values[:title] == expected[index][0]) && (row_values[:subtitle] == expected[index][1])
    end
  end
end

RSpec::Matchers.define :have_title_and_subtitle do |expected|
  match do |actual|
    (actual[:title] == expected[0]) && (actual[:subtitle] == expected[1])
  end

  failure_message do |actual|
    "actual values were: title <#{actual[:title]}>, subtitle <#{actual[:subtitle]}}>"
  end
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'pieces table:' do

    before do
      @dbtest.clear_table :pieces
    end

    it 'deletes all rows from the people table' do
      expect(@dbtest.pieces.count).to eq 0
    end

    it 'inserts one row into the pieces table' do
      @dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      expect(@dbtest.pieces.count).to eq 1
    end

    it 'inserts the expected values into a single row in the pieces table' do
      @dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      expect(@dbtest.pieces_by_title('Christmas Oratorio', 'Nun seid Ihr wohl gerochen').first)
        .to have_title_and_subtitle([ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ])
    end

    it 'returns the data for the specified piece' do
      @dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      @dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'
      expect(@dbtest.pieces_by_title('Christmas Oratorio', 'Nun seid Ihr wohl gerochen').first[:subtitle])
        .to eq 'Nun seid Ihr wohl gerochen'
      expect(@dbtest.pieces_by_title('Christmas Oratorio', 'Ach, mein hertzliches Jesulein').first[:subtitle])
        .to eq 'Ach, mein hertzliches Jesulein'
    end

    it 'returns all pieces matching on title only' do
      @dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      @dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'
      expect(@dbtest.pieces_by_title('Christmas Oratorio', '').count).to eq 2
    end

    it 'returns all piece data in ascending order by title, subtitle' do
      @dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      @dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'
      @dbtest.add_piece 'Little Red Corvette', ''

      expect(@dbtest.pieces.all).to be_sorted_as [
        [ 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein' ],
        [ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
        [ 'Little Red Corvette', '' ]
      ]
    end

  end # describe people table

end # context sequel gem
