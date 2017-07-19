
RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
    expected.each do |key, value|
      return false unless actual[key] == value
    end
  end

  failure_message do |actual|
    "\nactual: => #{actual}\nexpected: => #{expected}"
  end
end

RSpec::Matchers.define :be_sorted_by_filename do |expected|
  match do |actual|
    actual_filenames = []
    actual.each do |recording|
      actual_filenames << recording[:filename]
    end
    actual_filenames == expected
  end

  failure_message do |actual|
    "Expected result set to be sorted ascending by filename, but it was not."
  end
end

RSpec::Matchers.define :be_sorted_by_title_as do |expected|
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

RSpec::Matchers.define :be_sorted_by_name_as do |expected|
  match do |actual|
    actual.each_with_index do |row_values, index|
      (row_values[:surname] == expected[index][0]) && (row_values[:given_name] == expected[index][1])
    end
  end
end

RSpec::Matchers.define :include_people do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :surname => row[:surname], :given_name => row[:given_name]})
    end
  end
end

RSpec::Matchers.define :include_pieces do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :title => row[:title], :subtitle => row[:subtitle]})
    end
  end
end

RSpec::Matchers.define :include_recordings do |expected|
  match do |actual|
    actual.each do |row|
      expected.include?({ :filename => row[:filename]})
    end
  end
end
