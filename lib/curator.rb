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

  
end
