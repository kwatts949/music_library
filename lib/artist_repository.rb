require_relative './artist'

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

  def create(album)
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
end