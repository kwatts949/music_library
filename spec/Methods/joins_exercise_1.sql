SELECT albums.id AS album_id,
       albums.title
  FROM artists
    JOIN albums
    ON albums.artist_id = artists.id
  WHERE artists.name = 'Taylor Swift';

/*Use the database music_library for the following exercises.

--Use a JOIN query to select the id and title of all the albums from Taylor Swift.

--You should get the following result set:

-- id |  title   
----+----------
  6 | Lover
  7 | Folklore
*/