require 'sequel'
require 'logger'
require_relative "./db_helpers"

class DbLoad
  include DbHelpers

  def run
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
  end

end

DbLoad.new.run
