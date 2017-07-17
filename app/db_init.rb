require 'sequel'
require 'logger'
require_relative "./db_helpers"

class DbInit
  include DbHelpers

  def run
    drop_table :people_roles_pieces

    db.create_table! :collections  do
      primary_key :id
      String :title, :null=>false
      String :year_released
      String :remarks
    end

    db.create_table! :labels  do
      primary_key :id
      String :label_name, :null=>false
    end

    db.create_table! :people  do
      primary_key :id
      String :surname, :null=>false
      String :given_name
      String :nickname

    end

    db.create_table! :pieces do
      primary_key :id
      String :title, :null=>false
      String :subtitle
    end

    db.create_table! :recordings  do
      primary_key :id
      String :filename, :null=>false
      String :description
      Date :recording_date
      Integer :duration_in_seconds
    end

    db.create_table! :roles  do
      primary_key :id
      String :role_name, :null=>false
    end

    db.create_table! :people_roles_pieces do
      foreign_key :piece_id, :pieces, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :person_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :role_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      primary_key [ :piece_id, :person_id, :role_id ]
    end

    db.create_table! :people_roles_recordings do
      foreign_key :recording_id, :recordings, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :person_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :role_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      primary_key [ :recording_id, :person_id, :role_id ]
    end

  end

end

DbInit.new.run
