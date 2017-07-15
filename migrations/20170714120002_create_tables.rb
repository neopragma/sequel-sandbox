Sequel.migration do
  change do
    create_table?(:collections) do
      primary_key :id
      String :title, :null=>false
      String :year_released
      String :remarks
    end
    create_table?(:pieces) do
      primary_key :id
      String :title, :null=>false
      String :subtitle
    end
  end
end
