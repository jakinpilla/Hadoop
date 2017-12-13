# create movies_user_items insert data

CREATE TABLE movies_user_items
(
    user STRING,
	item_counts INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT OVERWRITE TABLE movies_user_items
SELECT user, count(*)
FROM movies
GROUP BY user;

# moives_user_item table : 유저당 몇 개의 영화를 보았는가를 카운팅한 테이블

# countinf the combination records number(t.cnts)

SELECT sum(t.cnts)
FROM (
	SELECT item_counts, item_counts*item_counts as cnts
	FROM movies_user_items
) t;

# The combination records number is about 20,000,000
# 20M * 4byte * 4 times memory = 320 MB
# The practice server memory limit is 200 MB

SELECT item_counts, count(*) as user_counts
FROM movies_user_items
GROUP BY item_counts
ORDER BY item_counts desc
LIMIT 5;

SELECT sum(t.cnts), count(*)
FROM (
	SELECT item_counts*item_counts as cnts
	FROM movies_user_items
	WHERE item_counts < 100
) t;

# create light_user table

CREATE TABLE light_user AS 
SELECT user
FROM movies_user_items
WHERE item_counts < 100;

select count(*) from light_user; # basket number is 579














