require 'sequel'
require 'logger'

module DbHelpers

  # deletes all rows in the specified table
  def clear_table table_name
    db[table_name].delete
  end

  # insert one row into the labels table
  # label_name is expected to be a string
  def add_label label_name
    db.transaction do
      insert_into(db[:labels], {:label_name => label_name})
    end
  end

  # insert multiple rows into the labels table
  # label_names is expected to be an array of strings
  def add_labels label_names
    label_names.each do |label_name|
      add_label label_name
    end
  end

  # return the row for the specified label name
  def label label_name
    db[:labels].where(:label_name => label_name).first
  end

  # return a sequel dataset containing all rows from the labels table, sorted
  def labels
    db[:labels].order(:label_name)
  end

  # insert one row into the people table
  def add_person surname, given_name, nickname
    db.transaction do
      insert_into(db[:people],
        { :surname => surname,
          :given_name => given_name,
          :nickname => nickname
        })
    end
  end

  def people
    db[:people].order(:surname, :given_name)
  end

  # return the row for the specified role name
  def person_by_full_name surname, given_name
    people.where({ :surname => surname, :given_name => given_name }).first
  end

  # return all matches from people table when only the surname is known
  def person_by_surname surname
    people.where(:surname => surname)
  end

  # insert one row into the roles table
  # role_name is expected to be a string
  def add_role role_name
    db.transaction do
      insert_into(db[:roles], {:role_name => role_name})
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
  def role role_name
    roles.where(:role_name => role_name).first
  end

  # return a sequel dataset containing all rows from the roles table
  def roles
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
