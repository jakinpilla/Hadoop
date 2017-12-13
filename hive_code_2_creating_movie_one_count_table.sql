# create movies_one_count_table schema

CREATE TABLE movies_one_count
(
    item STRING,
	counts INT
)
ROW FORAMT DELIMITED FIELDS TERMINATED BY "\t"

INSERT OVERWRITE TABLE movies_one_count
SELECT item, count(*)
FROM movies_one_count
GROUP BY item;

# check movies_one_count_table

select count(*) from movies_one_count;

guit;




