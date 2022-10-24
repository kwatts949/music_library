require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library') # connect to main database here

album_repository = AlbumRepository.new

album_repository.all.each do |album|
  p album
end