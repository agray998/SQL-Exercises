USE movielens;
-- 1) List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies WHERE release_date BETWEEN '1983-01-01' AND '1993-12-31' ORDER BY release_date DESC;

-- 2) Without using LIMIT, list the titles of the movies with the lowest average rating.
CREATE VIEW movieratings AS (SELECT r.id, r.user_id, r.movie_id, r.rating, r.rated_at, m.title, m.release_date FROM movies m JOIN ratings r ON m.id = r.movie_id);
CREATE VIEW avgs AS (SELECT movie_id, title, AVG(rating) AS average_rating FROM movieratings GROUP BY movie_id);
SELECT movie_id, title, average_rating FROM avgs WHERE average_rating=(SELECT MIN(average_rating) FROM avgs);

-- 3) List the unique records for Sci-Fi movies where male 40-year-old students have given 5-star ratings.
CREATE VIEW usersratings AS (SELECT r.id, r.user_id, r.movie_id, r.rating, r.rated_at, u.age, u.gender, u.occupation_id, u.zip_code FROM ratings r JOIN users u ON r.user_id=u.id);
CREATE VIEW usersratingsocc AS (SELECT ur.id, ur.user_id, ur.movie_id, ur.rating, ur.rated_at, ur.age, ur.gender, ur.occupation_id, ur.zip_code, o.name FROM usersratings ur JOIN occupations o ON ur.user_id=o.id);
SELECT DISTINCT movie_id FROM usersratingsocc WHERE age = 40 AND gender='M' AND name='Student' AND rating=5;

-- 4) List the unique titles of each of the movies released on the most popular release day.
CREATE VIEW release_date_freqs AS (SELECT release_date, COUNT(id) AS num_films FROM movies GROUP BY release_date);
SELECT DISTINCT title FROM movies WHERE release_date=(SELECT release_date FROM release_date_freqs WHERE num_films=(SELECT MAX(num_films) FROM release_date_freqs));

-- 5) Find the total number of movies in each genre; list the results in ascending numeric order.
CREATE VIEW counts AS (SELECT genre_id, COUNT(movie_id) AS num_movies FROM genres_movies GROUP BY genre_id ORDER BY COUNT(movie_id));
SELECT g.*, c.num_movies FROM genres g JOIN counts c ON g.id=c.genre_id ORDER BY num_movies;
