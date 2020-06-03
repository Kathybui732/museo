require './lib/photograph'
require './lib/artist'
require './lib/file_io'
require 'pry'

class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def photographs_by_artist
    @photographs.reduce({}) do |acc, photo|
      artist = find_artist_by_id(photo.artist_id)
      acc[artist] = [] if acc[artist].nil?
      acc[artist] << photo
      acc
    end
  end

  def artists_with_multiple_photographs
    artist_names = []
    photographs_by_artist.each do |artist, photos|
      artist_names << artist.name if photos.length > 1
    end
    artist_names
  end

  def photographs_taken_by_artist_from(country)
    @photographs.find_all do |photo|
      artist = find_artist_by_id(photo.artist_id)
      artist.country == country
    end
  end

  def load_photographs(file)
    photos = FileIO.load_photographs(file)
    photos.each do |photo|
      add_photograph(Photograph.new(photo))
    end
  end

  def load_artists(file)
    artists = FileIO.load_artists(file)
    artists.each do |artist|
      add_artist(Artist.new(artist))
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range.include? photo.year.to_i
    end
  end

  def artists_photographs_by_age(artist)
    photos = photographs_by_artist[artist]
    photos.inject({}) do |summary, photo|
      age = photo.year.to_i - artist.born.to_i
      summary[age] = photo.name
      summary
    end
  end
end
