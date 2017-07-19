require_relative "../app/db_helpers"

# Expresses behaviors related to the recordings table

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'recordings table:' do

    before do
      @dbtest.clear_table :recordings
    end

    it 'deletes all rows from the recordings table' do
      expect(@dbtest.recordings.count).to eq 0
    end

    it 'inserts one row into the recordings table' do
      @dbtest.add_recording 'PJBE - Brass Splendour/track1.wav', 537, '1984-01-01', 'Some great brass playing'
      expect(@dbtest.recordings.count).to eq 1
    end

    it 'inserts the expected values into a single row in the recordings table' do
      @dbtest.add_recording 'PJBE - Brass Splendour/track1.wav', 537, '1984-01-01', 'Some great brass playing'
      expect(@dbtest.recordings.where(:filename => 'PJBE - Brass Splendour/track1.wav').first)
        .to have_attributes({
          :filename => 'PJBE - Brass Splendour/track1.wav',
          :duration_in_seconds => 537,
          :recording_date => Date.strptime("{ 1984, 1, 1 }", "{ %Y, %m, %d }"),
          :description => 'Some great brass playing'
          })
    end

    it 'returns all recordings in ascending order by filename' do
      @dbtest.add_recording 'filename 3', 69, '1984-01-01', ''
      @dbtest.add_recording 'filename 1', 69, '1984-01-01', ''
      @dbtest.add_recording 'filename 2', 69, '1984-01-01', ''

      expect(@dbtest.recordings.all).to be_sorted_by_filename [
        'filename 1', 'filename 2', 'filename 3'
      ]
    end
  end # describe recordings table

end # context sequel gem
