require 'sequel'
require 'logger'

module DbHelpers

  # eliminate all defined people
  def clear_people
    db.transaction do
      find_all_people.delete
    end
  end

  # insert one row into the people table
  # key_values is expected to be a hash with keys corresponding to
  # column names and values specifying the value of each column
  def add_person key_values
    db.transaction do
      insert_into(find_all_people, key_values)
    end
  end

  def find_all_people
    db[:people].order(:surname, :given_name)
  end

  # return the row for the specified role name
  def find_person surname, given_name
    find_all_people.where({ :surname => surname, :given_name => given_name }).first
  end

  # return all matches from people table when only the surname is known
  def find_person_by_surname surname
    find_all_people.where(:surname => surname)
  end

  # eliminate all defined roles
  def clear_roles
    db.transaction do
      find_all_roles.delete
    end
  end

  # insert one row into the roles table
  # role_name is expected to be a string
  def add_role role_name
    db.transaction do
      insert_into(find_all_roles, {:role_name => role_name})
#      ds = find_all_roles
#      ds.insert(:role_name => role_name)
    end
  end

  # insert multiple rows into the roles table
  # role_names is expected to be an array of strings
  def add_roles role_names
    role_names.each do |role_name|
      add_role role_name
    end
  end

  # return the row for the specified role name
  def find_role role_name
    find_all_roles.where(:role_name => role_name).first
  end

  # return a sequel dataset containing all rows from the roles table
  def find_all_roles
    db[:roles].order(:role_name)
  end

  private

  def insert_into dataset, key_values
    dataset.insert(key_values)
  end


  # connect to DATABASE_URL using default logger
  def connect
    @db = Sequel.connect(
      ENV['DATABASE_URL'],
      :loggers => [Logger.new(ENV['SEQUEL_LOG'])])
  end

  def db
    @db = connect unless @db
    @db
  end

end
