require_relative "../app/db_helpers"

# Expresses behaviors related to the recordings table

class Db
  include DbHelpers
end

RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
    actual[:filename] == expected[:filename] &&
    actual[:duration_in_seconds] == expected[:duration_in_seconds] &&
    actual[:recording_date].to_s == expected[:recording_date] &&
    actual[:description] == expected[:description]
  end

  failure_message do |actual|
    "\nactual[:filename] => #{actual[:filename]}, expected => #{expected[:filename]}\n" \
    "actual[:duration_in_seconds] => #{actual[:duration_in_seconds]}, expected => #{expected[:duration_in_seconds]}\n" \
    "actual[:recording_date] => #{actual[:recording_date]}, expected => #{expected[:recording_date]}\n" \
    "actual[:description] => #{actual[:description]}, expected => #{expected[:description]}\n"
  end
end

RSpec::Matchers.define :be_sorted_by_filename do |expected|
  match do |actual|
    actual_filenames = []
    actual.each do |recording|
      actual_filenames << recording[:filename]
    end
puts "actual: #{actual_filenames}, expected: #{expected}"

    actual_filenames == expected
  end

  failure_message do |actual|
    "Expected result set to be sorted ascending by filename, but it was not."
  end
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
          :recording_date => '1984-01-01',
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
