TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE artists RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO artists (name, genre) VALUES ('Placebo', 'Rock');

INSERT INTO albums (title, release_year, artist_id) VALUES ('Placebo', '1996');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Save Rock & Roll', '2013');
