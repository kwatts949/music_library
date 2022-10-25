require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library') # connect to main database here

album_repository = AlbumRepository.new

album_repository.all.each do |album| # all method in action
  p album
end

album = album_repository.find(3) # find method in action
  puts album.title

album_1 = Album.new # create method in action
album_1.title = 'Mania'
album_1.release_year = "2018"

album = album_repository.create(album_1)
  puts album_1.title