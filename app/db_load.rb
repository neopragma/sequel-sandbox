require 'sequel'
require 'logger'
require_relative "./db_helpers"

class DbLoad
  include DbHelpers

  def run
    # table: people
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

    # table: roles
    add_roles([
      'Arranger',
      'Composer',
      'Conductor',
      'Engineer',
      'Lyricist',
      'Performer',
      'Soloist'
    ])

    # table: pieces
    [
      [ 'Christmas Oratorio', 'Ach, mein herzliches Jesulin' ],
      [ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
      [ 'Music for the Royal Fireworks', '' ],
      [ 'Sonata pian\'e forte', '' ],
      [ 'Trumpet Voluntary', '' ],
      [ 'The Batell', 'The Marche to the Fighte' ],
      [ 'The Batell', 'The Retraite' ],
      [ 'Trumpet Tune and Air', '' ],
      [ 'Galliard Battaglia', '' ],
      [ 'March', '(C.P.E. Bach)' ],
      [ 'Festmusik der Stadt Wien', 'Fanfare' ],
      [ 'Humoresque', 'Op. 101, No. 7' ],
      [ 'Sleeping Beauty', 'Waltz' ],
      [ 'Fanfare for the Common Man', '' ],
      [ 'Pictures at an Exhibition', 'Great Gate of Kiev' ]
    ].each do |piece|
      add_piece piece[0], piece[1]
    end
  end # run

end

DbLoad.new.run
