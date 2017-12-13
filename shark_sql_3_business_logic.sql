# movies_two_count 데이터를 로컬 파일로 내리기
$ hadoop fs -getmerge /user/hive/warehouse/movies_two_count ./movies_two_count.dat

$ head movies_two_count.dat

# A, B가 동일한 것 삭제, ',' --> '\t'으로 변환, 빈도수가 1인것 삭제

# 파일 : step4_movies_two_count.php
$ php step4_movies_two_count.php
$ eha

$ history
$ ../shark/bin/shark -h localhost -p 8083

CREATE TABLE movies_two_count
(
	item_a STRING,
	item_b STRING,
	count INT
)
ROW FORMAT DELIMIETD FIELDS TERMINATED BY "\t";

# 로컬에서 처리한 파일을 로드, 파일의 경로에 유의할 것

LOAD DATA LOCAL INPATH 'movie_two_count.csv'
INTO TABLE movies_two_count;

select * from movies_two_count;

# create table for confidence, lift values

CREATE TABLE movies_association
(
	item_a	int,
	item_b  int,
	n_ab    bigint,
	n_a     bigint,
	s_ab    bigint,
	s_a     double,
	s_b     double,
	confidence    double,
	lift    double
)
ROW FORMAT DELIMIETD FIELDS TERMINATED BY ",";

INSERT OVERWRIGHT TABLE movies_association
SELECT t.item_a                                       as item_a,
       t.item_b                                       as item_b, 
       SUM(t.n_ab)                                    as n_ab,
       SUM(t.n_a)                                     as n_a,
       SUM(b.counts)                                  as n_b,
       SUM(t.n_ab/579)                                as s_ab,
       SUM(t.n_a/579)                                 as s_a,
       SUM(b.counts/579)                              as s_b,
       SUM((t.n_ab/579)/(t.n_a/579))                  as confidence
       SUM((t.n_ab/579)/((t.n_a/579)*(b.counts/579))) as lift
  FROM (
	  SELECT two.item_a as item_a,
	         two.item_b as item_b,
	         SUM(two.counts) as n_ab,
	         SUM(one.counts) as n_a
	  FROM movies_two_count two
	  JOIN movies_one_count one
	  ON two.item_a = one.item_a
	  GROUP BY two.item_a, two.item_b
  ) t
JOIN moives_one_count b
ON t.item_b = b.item_b
GROUP BY t.item_a, t.item_b;

SELECT count(*) FROM movies_association;

shark> quit;



