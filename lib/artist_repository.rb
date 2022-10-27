require_relative './artist'
require_relative './album'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    sql_params = [artist.name, artist.genre]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def update(artist)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    sql_params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find_with_albums(artist_id)
    sql = 'SELECT artists.id AS "id",
	          artists.name AS "name",
	          artists.genre AS "genre",
            albums.id AS "album_id",
	          albums.title AS "title",
	          albums.release_year AS "release year"
	        FROM artists 
	          JOIN albums
	          ON albums.artist_id = artists.id
	         WHERE artist_id = $1;'
      sql_params = [artist_id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      first_record = result_set[0]
      artist = record_to_artist_object(first_record)

      result_set.each do |record|
        artist.albums << record_to_album_object(record)
      end

      return artist
  end

  private

  def record_to_artist_object(record)
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end

  def record_to_album_object(record)
    album = Album.new
    album.id = record["album_id"]
    album.title = record["title"]
    album.release_year = record['release_year']

    return album
  end
end