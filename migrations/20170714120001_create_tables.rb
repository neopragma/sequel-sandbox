Sequel.migration do
  change do
    create_table?(:labels) do
      primary_key :id
      String :label_name, :null=>false
    end
  end
end
