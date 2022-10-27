require 'album_repository'

RSpec.describe AlbumRepository do

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_albums_table 
end

  it 'returns the list of artists' do
    repo = AlbumRepository.new

    albums = repo.all 

    expect(albums.length).to eq 3
    expect(albums.first.id).to eq '1'
    expect(albums.first.title).to eq "Placebo"
  end

  it 'returns a single record' do
    repo = AlbumRepository.new

    albums = repo.find(2)
    expect(albums.id).to eq '2'
    expect(albums.title).to eq "Save Rock & Roll"
  end

  it 'creates a new album record' do
    repo = AlbumRepository.new

    new_album = Album.new
    new_album.title = 'Mania'
    new_album.release_year = 2018

    repo.create(new_album)

    all_albums = repo.all

    expect(repo.all).to include (
      have_attributes(
        title: new_album.title,
        release_year: "2018"
      )
    )
  end

  it 'deletes an album record' do
    repo = AlbumRepository.new

    repo.delete(1)

    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums.first.title).to eq "Save Rock & Roll"
  end
end