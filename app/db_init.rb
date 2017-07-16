require 'sequel'
require 'logger'
require_relative "./db_helpers"

class DbInit
  include DbHelpers

  def create_tables
    drop_table :people_roles
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
      Date :recording_datedb
      Integer :duration_in_seconds
    end

    db.create_table! :roles  do
      primary_key :id
      String :role_name, :null=>false
    end

    db.create_table! :people_roles do
      foreign_key :person_id, :people, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :role_id, :roles, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      primary_key [ :person_id, :role_id ]
    end

    db.create_table! :people_roles_pieces do
      foreign_key :piece_id, :pieces, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :person_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      foreign_key :role_id, { :deferrable => true, :on_delete => :cascade, :on_update => :set_null }
      primary_key [ :piece_id, :person_id, :role_id ]
    end

  end

  def load_data
    add_person 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach'
    add_person 'Bach', 'Johann Sebastian', ''
    add_person 'Byrd', 'William', ''
    add_person 'Clarke', 'Jeremiah', ''
    add_person 'Copland', 'Aaron', ''
    add_person 'Gabrieli', 'Andrea', ''
    add_person 'Handel', 'Georg Fridric', ''
    add_person 'Howarth', 'Elgar', ''
    add_person 'Jones', 'Philip', ''
    add_person 'Mussorgsky', 'Modest', ''
    add_person 'Purcell', 'Henry', ''
    add_person 'Scheidt', 'Samuel', ''
    add_person 'Tchaikovsky', 'Pyotr Ilyich', ''
    add_person 'Wagner', 'Richard', ''

    add_roles([
      'Arranger',
      'Composer',
      'Conductor',
      'Engineer',
      'Lyricist',
      'Performer',
      'Soloist'
    ])

    [
      [ 'Bach', 'Carl Philip Emmanuel', 'Composer' ],
      [ 'Bach', 'Johann Sebastian', 'Composer' ],
      [ 'Byrd', 'William', 'Composer' ],
      [ 'Clarke', 'Jeremiah', 'Composer' ],
      [ 'Copland', 'Aaron', 'Composer' ],
      [ 'Gabrieli', 'Andrea', 'Composer' ],
      [ 'Handel', 'Georg Fridric', 'Composer' ],
      [ 'Howarth', 'Elgar', 'Arranger' ],
      [ 'Howarth', 'Elgar', 'Performer' ],
      [ 'Howarth', 'Elgar', 'Soloist' ],
      [ 'Jones', 'Philip', 'Arranger' ],
      [ 'Jones', 'Philip', 'Performer' ],
      [ 'Jones', 'Philip', 'Soloist' ],
      [ 'Mussorgsky', 'Modest', 'Composer' ],
      [ 'Purcell', 'Henry', 'Composer' ],
      [ 'Scheidt', 'Samuel', 'Composer' ],
      [ 'Tchaikovsky', 'Pyotr Ilyich', 'Composer' ],
      [ 'Wagner', 'Richard', 'Composer' ]

    ].each do |data|
      person_to_role data
    end
  end

private

  def person_to_role data
    associate_person_with_role({
      :surname => data[0],
      :given_name => data[1],
      :role_name => data[2]
    })
  end


end

dbinit = DbInit.new
dbinit.create_tables
dbinit.load_data
