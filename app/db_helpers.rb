require 'sequel'
require 'logger'

module DbHelpers

  # pass through to get a dataset
  def dataset name
    db[name.to_sym]
  end

  # drops a table if it exists
  def drop_table table_name
    db.drop_table table_name if db.table_exists? table_name
  end

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

  # insert one row into the pieces table
  # title and subtitle arguments are strings
  def add_piece title, subtitle
    db.transaction do
      insert_into(db[:pieces], {:title => title, :subtitle => subtitle})
    end
  end

  # retrieve all rows from pieces sorted ascending by title, subtitle
  def pieces
    db[:pieces].order(:title, :subtitle)
  end

  # retrieve all rows from pieces table that match on title alone or both
  # title and subtitle.
  # title and subtitle arguments are strings. subtitle can be an empty string.
  def pieces_by_title title, subtitle
    where_values = (subtitle == nil || subtitle == '') ? { :title => title } : { :title => title, :subtitle => subtitle }
    pieces.where(where_values)
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

  # associate a person, role, and piece
  def associate_person_role_with_piece values_hash
    person = person_by_full_name(values_hash[:surname], values_hash[:given_name])
    role = role(values_hash[:role_name])
    piece = pieces_by_title(values_hash[:title], values_hash[:subtitle]).first
    db.transaction do
      db[:people_roles_pieces].insert({
        :person_id => person[:id],
        :role_id => role[:id],
        :piece_id => piece[:id]
      })
    end
  end

  def composers_of values_hash
    #TODO needs refactoring
    piece_id = pieces_by_title(values_hash[:title], values_hash[:subtitle]).first[:id]
    role_id = db[:roles].where(:role_name => 'Composer').first[:id]
    composers = db[:people_roles_pieces].where(:piece_id => piece_id, :role_id => role_id).all
    db[:people].where(:id => composers.first[:person_id]).all
  end

  def composed_by values_hash
    #TODO needs refactoring
    person_id = person_by_full_name(values_hash[:surname], values_hash[:given_name])[:id]
    role_id = db[:roles].where(:role_name => 'Composer').first[:id]
    associated_pieces = db[:people_roles_pieces].where(:person_id => person_id, :role_id => role_id).all
    db[:pieces].where(:id => associated_pieces.first[:piece_id]).all
  end

#  private

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
