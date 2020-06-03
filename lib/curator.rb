class Curator
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
    photographs_by_artist = Hash.new
    @artists.each do |artist|
      photographs_by_artist[artist] = photographs_by_id(artist.id)
    end
    photographs_by_artist
  end

  def photographs_taken_by_artist_from(location)
    photos_by_location = []
    photographs_by_artist.each do |artist, photos|
      photos_by_location << photos if artist.country == location
    end
    photos_by_location.flatten
  end
end
