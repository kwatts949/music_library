require_relative './lib/database_connection'
require_relative './lib/album_repository'
require_relative './lib/artist_repository'

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts 'Welcome to the music library manager!'
    @io.puts "What would you like to do?"
    @io.puts '1 - List all albums'
    @io.puts '2 - List all artists'
    while true do
    @io.puts 'Please enter your choice'
    selection = @io.gets.chomp
      if selection == '1'
        return albums
      elsif selection == '2'
        return artists
      else
        @io.puts 'Please select 1 or 2'
      end
    end
  end

   def albums
    sql = 'SELECT id, title FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])
     result_set.each do |record|
      puts record.values.join(" - ")
    end
  end

  def artists
    sql = 'SELECT id, name FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])
     result_set.each do |record|
      puts record.values.join(" - ")
    end
  end
end


if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
