# adding timestamps in movies table

# putting a movies.csv file on HDFS

# $hadoop fs -put movies.csv . 
# $hadoop fs -ls

# $ hive

show tables;

CREATE TABLE movies
(
    user STRING,
	item STRING,
	time INT
)
ROW FORMAT DELIMIED FIELDS TERMINATED BY "\t";

LOAD DATA INPATH 'movies.csv'
INTO TABLE movies;

select * from movies limit 5;


