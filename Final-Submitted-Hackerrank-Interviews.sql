---https://www.hackerrank.com/challenges/interviews/problem

Select con.contest_id, con.hacker_id, con.name,
coalesce(sum(Sum_Sub_Stat.tSubm),0),
coalesce(sum(Sum_Sub_Stat.tAcept),0),
coalesce(sum(Sum_View_Stat.tViews),0),
coalesce(sum(Sum_View_Stat.tUnqViews),0)
from Contests con
 join Colleges col on con.contest_id = col.contest_id
 join Challenges cha on col.college_id=cha.college_id
left join (
Select sub.challenge_id, sum(sub.total_submissions) tSubm,
	sum(sub.total_accepted_submissions) tAcept
	from Submission_Stats sub
	group by sub.challenge_id) Sum_Sub_Stat on  Sum_Sub_Stat.challenge_id=cha.challenge_id
left join (
Select vst.challenge_id, sum(vst.total_views) tViews,
	sum(vst.total_unique_views) tUnqViews from View_Stats vst
	group by vst.challenge_id ) Sum_View_Stat on
Sum_View_Stat.challenge_id=cha.challenge_id
group by con.contest_id, con.hacker_id, con.name
Having
(coalesce(sum(Sum_Sub_Stat.tSubm),0)+
coalesce(sum(Sum_Sub_Stat.tAcept),0) +
coalesce(sum(Sum_View_Stat.tViews),0)+
coalesce(sum(Sum_View_Stat.tUnqViews),0)) <>0

Order by con.contest_id;


----
---Sample Data
create table Contests ( contest_id INT, hacker_id INT, name VARCHAR(200) );

insert into Contests (contest_id, hacker_id, name) values (66406, 17973, "Rose"), (66556, 79153, "Angela"), (94828, 80275, "Frank");

create table Colleges( college_id INT, contest_id INT );

insert into Colleges (college_id, contest_id) values (11219, 66406), (32473, 66556), (56685, 94828);

create table Challenges ( challenge_id INT, college_id INT );

insert into Challenges (challenge_id, college_id) values (18765, 11219), (47127, 11219), (60292, 32473), (72974, 56685);

create table View_Stats ( challenge_id INT, total_views INT, total_unique_views INT );

insert into View_Stats (challenge_id, total_views, total_unique_views) values (47127, 26, 19), (47127, 15, 14), (18765, 43, 10), (18765, 72, 13), (75516, 35, 17), (60292, 11, 10), (72974, 41, 15), (75516, 75, 11);

create table Submission_Stats ( challenge_id INT, total_submissions INT, total_accepted_submissions INT );

insert into Submission_Stats (challenge_id, total_submissions, total_accepted_submissions) values (75516, 34, 12), (47127, 27, 10), (47127, 56, 18), (75516, 74, 12), (75516, 83, 8), (72974, 68, 24), (72974, 82, 14), (47127, 28, 11);
