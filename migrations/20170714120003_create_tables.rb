Sequel.migration do
  change do
    create_table?(:recordings) do
      primary_key :id
      String :filename, :null=>false
      String :description
      Date :recording_datedb
      Integer :duration_in_seconds
    end
  end
end
