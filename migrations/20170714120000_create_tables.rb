Sequel.migration do
  change do
    create_table?(:people) do
      primary_key :id
      String :surname, :null=>false
      String :given_name
      String :nickname
    end
    create_table?(:roles) do
      primary_key :id
      String :role_name, :null=>false
    end
  end
end
