require_relative "./file_io"

class Curator < FileIO
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def photographs_by_id(id)
    @photographs.select do |photo|
      photo.artist_id == id
    end
  end

  def photographs_by_artist
    @artists.reduce({}) do |acc, artist|
      acc[artist] ||= []
      acc[artist] = photographs_by_id(artist.id)
      acc
    end
  end

  def photographs_taken_by_artist_from(location)
    # photos_by_location = []
    # photographs_by_artist.each do |artist, photos|
    #   photos_by_location << photos if artist.country == location
    # end
    # photos_by_location.flatten

    @photographs.select do |photo|
      artist = find_artist_by_id(photo.artist_id)
      artist.country == location
    end
  end

  def artists_with_multiple_photographs
    # x = photographs_by_artist.select do |artist, photos|
    #   photos.count > 1
    # end
    # x.map do |artist, photo|
    #   artist.name
    # end

    photographs_by_artist.reduce([]) do |acc, (artist, photos)|
      acc << artist.name if photos.count > 1
      acc
    end
  end

  def load_photographs(file)
    x = FileIO.load_photographs(file)
    x.each do |file|
      @photographs << Photograph.new(file)
    end
  end

  def load_artists(file)
    x = FileIO.load_artists(file)
    x.each do |file|
      @artists << Artist.new(file)
    end
  end

  def photographs_taken_between(years_range)
    years = years_range.to_a
    @photographs.select do |photo|
      years.include?(photo.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    age = artist.born.to_i
    hash = Hash.new
    photographs_by_artist[artist].each do |photo|
      hash[photo.year.to_i - age] = photo.name
    end
    hash
  end
end
