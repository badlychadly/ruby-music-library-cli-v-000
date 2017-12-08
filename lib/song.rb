require 'pry'
class Song
  extend Concerns::Findable

  attr_accessor :name, :artist
  attr_reader :genre
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

#CLASS METHODS
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
 self.new(name).tap {|song| song.save}
  end


  def self.new_from_filename(filename)
    artist, song, genre = filename.split(' - ')
    new_song = self.find_or_create_by_name(song)
    new_song.artist = Artist.find_or_create_by_name(artist)
    new_song.genre = Genre.find_or_create_by_name(genre.split(/.mp3/).join)
    new_
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

  #INSTANCE METHODS
  def save
    self.class.all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end


end
