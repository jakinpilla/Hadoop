# ceate movie_new table : movies 테이블의 user와 light_user 테이블의 user를 inner join 

CREATE TABLE movies_new AS
SELECT t.*
FROM movies t
JOIN light_user a
ON t.user = a.user;

SELECT count(*) FROM movies_new;

# create moives_two_count table

CREATE TABLE movies_two_count
(
	item_ab STRING,
	count INT
)
ROW FORMAT DELIMIETD FIELDS TERMINATED BY "\t";

INSERT OVERWRITE TABLE movies_two_count
SELECT t.ab as item_ab, count(*) as counts
FROM (
	SELECT a.user as user, concat(a.item, ',', b.item) as ab
	FROM movies_new a
	JOIN movies_new b
	ON a.user = b.user
	WHERE a.time < b.time
) t
GROUP BY t.ab;

SELECT count(*), sum(counts) FROM movies_two_count;

# create movies_one_count table

INSERT OVERWRITE TABLE movies_one_count
SELECT item, count(*)
FROM movie_new
GROUP BY item;

SELECT count(*) FROM movies_one_count;

