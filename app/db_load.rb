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
    add_person 'Dvorak', 'Antonin', ''
    add_person 'Gabrieli', 'Giovanni', ''
    add_person 'Handel', 'Georg Fridric', ''
    add_person 'Howarth', 'Elgar', ''
    add_person 'Jones', 'Philip', ''
    add_person 'Mussorgsky', 'Modest', ''
    add_person 'Purcell', 'Henry', ''
    add_person 'Scheidt', 'Samuel', ''
    add_person 'Strauss', 'Richard', ''
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
      [ 'Christmas Oratorio', 'Ach, mein herzliches Jesulein' ],
      [ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
      [ 'Music for the Royal Fireworks', '' ],
      [ 'Sonata pian\'e forte', '' ],
      [ 'Trumpet Voluntary', '' ],
      [ 'The Battell', 'The Marche to the Fighte' ],
      [ 'The Battell', 'The Retraite' ],
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

    # table: people_roles_pieces
    [
      [ 'Bach', 'Carl Philip Emmanuel', 'Composer', 'March', '(C.P.E. Bach)' ],
      [ 'Bach', 'Johann Sebastian', 'Composer', 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
      [ 'Bach', 'Johann Sebastian', 'Composer', 'Christmas Oratorio', 'Ach, mein herzliches Jesulein' ],
      [ 'Byrd', 'William', 'Composer', 'The Battell', 'The Marche to the Fighte'],
      [ 'Byrd', 'William', 'Composer', 'The Battell', 'The Retraite' ],
      [ 'Copland', 'Aaron', 'Composer', 'Fanfare for the Common Man', '' ],
      [ 'Dvorak', 'Antonin', 'Composer', 'Humoresque', 'Op. 101, No. 7' ],
      [ 'Gabrieli', 'Giovanni', 'Composer', 'Sonata pian\'e forte', '' ],
      [ 'Handel', 'Georg Fridric', 'Composer', 'Music for the Royal Fireworks', '' ],
      [ 'Purcell', 'Henry', 'Composer', 'Trumpet Tune and Air' ],
      [ 'Scheidt', 'Samuel', 'Composer', 'Galliard Battaglia', '' ],
      [ 'Strauss', 'Richard', 'Composer', 'Festmusik der Stadt Wien', 'Fanfare' ],
      [ 'Tchaikovsky', 'Pyotr Ilyich', 'Composer', 'Sleeping Beauty', 'Waltz' ]
    ].each do |assoc|
      associate_person_role_and_piece({
        :surname => assoc[0], :given_name => assoc[1], :role_name => assoc[2], :title => assoc[3], :subtitle => assoc[4]
      })
    end

  end # run

end

DbLoad.new.run
