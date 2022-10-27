require 'artist_repository'

RSpec.describe ArtistRepository do

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_albums_table 
end

  it 'returns the list of artists' do
    repo = ArtistRepository.new

    artists = repo.all 

    expect(artists.length).to eq 3
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq "Placebo"
  end

  it 'returns a single record' do
    repo = ArtistRepository.new

    artists = repo.find(2)
    expect(artists.id).to eq '2'
    expect(artists.name).to eq "Fallout Boy"
  end

  it 'creates a new artist record' do
    repo = ArtistRepository.new

    new_artist= Artist.new
    new_artist.name = 'Capdown'
    new_artist.genre = 'Ska'

    repo.create(new_artist)

    all_artists = repo.all

    expect(repo.all).to include (
      have_attributes(
        name: new_artist.name,
        genre: "Ska"
      )
    )
  end

  it 'deletes an artist record' do
    repo = ArtistRepository.new

    repo.delete(1)

    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums.first.name).to eq "Fallout Boy"
  end

  it 'finds artist 1 with related albums' do
    repo = ArtistRepository.new

    artist = repo.find_with_albums(1)

    expect(artist.name).to eq('Placebo')
    expect(artist.albums.length).to eq(2)
  end
end