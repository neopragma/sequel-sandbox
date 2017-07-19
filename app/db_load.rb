require 'sequel'
require 'logger'
require_relative "./db_helpers"

class DbLoad
  include DbHelpers

  def run
    # table: labels
    #TODO load the labels table

    
    # table: people
    [
      [ 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach' ],
      [ 'Bach', 'Johann Sebastian', '' ],
      [ 'Byrd', 'William', '' ],
      [ 'Clarke', 'Jeremiah', '' ],
      [ 'Copland', 'Aaron', '' ],
      [ 'Dvorak', 'Antonin', '' ],
      [ 'Gabrieli', 'Giovanni', '' ],
      [ 'Handel', 'Georg Fridric', '' ],
      [ 'Howarth', 'Elgar', '' ],
      [ 'Jones', 'Philip', '' ],
      [ 'Mussorgsky', 'Modest', '' ],
      [ 'Purcell', 'Henry', '' ],
      [ 'Scheidt', 'Samuel', '' ],
      [ 'Strauss', 'Richard', '' ],
      [ 'Tchaikovsky', 'Pyotr Ilyich', '' ],
      [ 'Wagner', 'Richard', '' ],
    ].each do |person|
      add_person person[0], person[1], person[2]
    end

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

    # table: recordings
    [
      [ 'PJBE - Brass Splendour/Track 1.wav', 537, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 3.wav', 77, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 4.wav', 277, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 5.wav', 163, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 6.wav', 243, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 7.wav', 173, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 8.wav', 110, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 9.wav', 177, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 10.wav', 132, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 11.wav', 155, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 12.wav', 186, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 13.wav', 182, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 14.wav', 529, '1984-01-01', '' ],
    ].each do |recording|
      add_recording recording[0], recording[1], recording[2], recording[3]
    end

  end # run

end

DbLoad.new.run
