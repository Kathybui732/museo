require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'

class ArtistTest < Minitest::Test
  def test_it_exists
    artist = Artist.new({id: "2", name: "Ansel Adams", born: "1902", died: "1984", country: "United States"})

    assert_instance_of Artist, artist
  end

  def test_it_has_a_name
    artist = Artist.new({id: "3", name: "Diane Arbus", born: "1923", died: "1971", country: "United States"})

    assert_equal "Diane Arbus", artist.name
  end

  def test_it_has_an_id
    artist = Artist.new({id: "1", name: "Henri Cartier-Bresson", born: "1908", died: "2004", country: "France"})

    assert_equal "1", artist.id
  end

  def test_it_has_a_date_of_birth
    artist = Artist.new({id: "4", name: "Walker Evans", born: "1903", died: "1975", country: "United States"})

    assert_equal "1903", artist.born
  end

  def test_it_has_a_year_died
    artist = Artist.new({id: "5", name: "Manuel Alvarez Bravo", born: "1902", died: "2002", country: "Mexico"})

    assert_equal "2002", artist.died
  end

  def test_it_has_a_country_of_origin
    artist = Artist.new({id: "6", name: "Bill Cunningham", born: "1929", died: "2016", country: "United States"})

    assert_equal "United States", artist.country
  end
end
