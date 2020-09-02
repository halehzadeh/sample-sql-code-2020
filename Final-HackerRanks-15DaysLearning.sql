--https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem


with table1 as(select du.submission_date, count(distinct du.hacker_id) as hack_cnt from (select sub.*, dense_rank() over (order by sub.submission_date) as date_rank, dense_rank() over (partition by sub.hacker_id order by sub.submission_date) as hack_rank from submissions sub) du where du.hack_rank=du.date_rank group by du.submission_date),table2 as(select s3.submission_date, s3.hacker_id from (select s2.*, row_number() over (partition by s2.submission_date order by  s2.hac_rank desc, s2.hacker_id)  as row_num_subs from (select s1.submission_date, s1.hacker_id, count(s1.hacker_id)  as hac_rank from submissions s1 group by  s1.hacker_id, s1.submission_date order by s1.submission_date) s2) s3 where s3.row_num_subs=1)select table1.submission_date, table1.hack_cnt, table2.hacker_id, h.name from table1 join table2 on table1.submission_date=table2.submission_date join hackers h on h.hacker_id=table2.hacker_id


with table1 as
(
	select du.submission_date, count(distinct du.hacker_id) as hack_cnt from (
	select sub.*, dense_rank() over (order by sub.submission_date) as date_rank,
			   dense_rank() over (partition by sub.hacker_id order by sub.submission_date) as hack_rank from submissions sub
) du where du.hack_rank=du.date_rank group by du.submission_date
),table2 as(
	select s3.submission_date, s3.hacker_id from (
	select s2.*, row_number() over (partition by s2.submission_date order by  s2.hac_rank desc, s2.hacker_id)  as row_num_subs from (
	select s1.submission_date, s1.hacker_id, count(s1.hacker_id)  as hac_rank
	from submissions s1 group by  s1.hacker_id, s1.submission_date order by s1.submission_date
) s2) s3 where s3.row_num_subs=1
)

select table1.submission_date, table1.hack_cnt, table2.hacker_id, h.name from table1 join table2 on table1.submission_date=table2.submission_date
	join hackers h on h.hacker_id=table2.hacker_id

--------
--Sample Data
  CREATE TABLE hackers (hacker_id integer, name VARCHAR(200));
  insert into hackers VALUES(15758,'Rose'), (20703,'Angela'), (36396,'Frank'), (38289,'Patrick'), (44065,'Lisa'), (53473,'Kimberly'), (62529,'Bonnie'), (79722,'Michael');

    create table submissions ( submission_date date, submission_id int, hacker_id int, score int );
    insert into submissions values
      ('2016-03-01', 8494, 20703, 0),
      ('2016-03-01', 22403, 53473, 60),
      ('2016-03-01', 23965, 79722, 60),
      ('2016-03-01', 30173, 36396, 70),
      ('2016-03-02', 34928, 20703, 0),
      ('2016-03-02', 38740, 15758, 60),
      ('2016-03-02', 42769, 79722, 60),
      ('2016-03-02', 44364, 79722, 60),
      ('2016-03-03', 45440, 20703, 0),
      ('2016-03-03', 49050, 36396, 70),
      ('2016-03-03', 50273, 79722, 5),
      ('2016-03-04', 50344, 20703, 0),
      ('2016-03-04', 51360, 44065, 90),
      ('2016-03-04', 54404, 53473, 65),
      ('2016-03-04', 61533, 79722, 45),
      ('2016-03-05', 72852, 20703,0),
      ('2016-03-05',74546, 38289, 0),
      ('2016-03-05', 76487, 62529, 0),
      ('2016-03-05',82439, 36396, 10),
      ('2016-03-05', 9006, 36396, 40),
      ('2016-03-06', 90404, 20703, 0);
