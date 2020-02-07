USE albums_db;

DESCRIBE albums;

SELECT NAME FROM albums
WHERE artist = "Pink Floyd";

SELECT release_date FROM albums
WHERE NAME = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT genre FROM albums
WHERE NAME = "Nevermind";

SELECT NAME, RELEASE_date, artist
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

SELECT *
FROM albums
WHERE sales < 20;

SELECT *
FROM albums
WHERE genre = 'Rock';

# It isn't selecting the other albums with different Rocks becuase they are different strings


