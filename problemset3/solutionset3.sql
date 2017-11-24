-- ProblemSet 3, November 24,2017
-- Submission by r.elizabeth.ranjit@accenture.com 

/* 1.Find the titles of all movies directed by Steven Spielberg.*/ 

select title from Movie where director='Steven Spielberg';

Record Count: 2;

2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)

select year from Movie join Rating where stars=4 or stars=5 order by year;

Record Count: 48;

3.Find the titles of all movies that have no ratings. (1 point possible)

select distinct(title) from Movie join Rating where Movie.mid not in (select Rating.mid from Rating);

Record Count: 2

4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. (1 point possible)

select Reviewer.name from Reviewer join Rating on Reviewer.rid=Rating.rid where Rating.ratingdate is null;

Record Count: 2

5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. (1 point possible)

select r.name,a.title,a.stars,a.ratingdate from reviewer r inner join
(select rt.rid,m.title,rt.stars,rt.ratingdate from movie m inner join rating rt on m.mid=rt.mid) a on r.rid=a.rid order by r.name,a.title,a.stars; 

6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. (1 point possible)

select movie.title,reviewer.name from movie,reviewer,(select r1.rid,r1.mid from rating r1,rating r2 where  
r1.mid=r2.mid and r1.rid=r2.rid and r2.ratingdate>r1.ratingdate and r2.stars>r1.stars) s 
where movie.mid=s.mid and reviewer.rid=s.rid;

7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. (1 point possible)

select m.title,a.maxstars from movie m inner join(select mid,max(stars) as maxstars from rating group by mid) a on m.mid=a.mid;

8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)

select m.title,a.ratingspread from movie m join(select mid,max(stars)-min(stars) as ratingspread from rating group by mid) a 
on a.mid=m.mid order by a.ratingspread desc,m.title ;

9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)

select average1-average2 as diff_bw_beforeandafter80 from (select avg(avgbefore80) as average1 from (select mid,avg(stars)as avgbefore80 from rating where mid in (select mid from movie where year<1980)  group by mid) a) c join
(select avg(avgafter80) as average2 from (select mid,avg(stars)as avgafter80 from rating where mid in (select mid from movie where year>1980)  group by mid) b) d

10.Find the names of all reviewers who rated Gone with the Wind. (1 point possible)

select name from reviewer where rid in(select distinct(rid) from rating where mid in(select mid from movie where title="gone with the wind"));

11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. (1 point possible)

select x.title,x.name,x.stars from(select a.title,a.director,a.stars,r.name from 
(select m.title,m.director,rt.rid,rt.stars from movie m join rating rt on m.mid=rt.mid) a join reviewer r on a.rid=r.rid) x 
where x.director=x.name;

12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) (1 point possible)

select name from reviewer union
select title from movie order by name;

13.Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)

select title from movie  where mid not in(select mid from rating where rid in(select rid from reviewer where name="Chris Jackson"));

14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. (1 point possible)

select a.title,r.name from reviewer r join (select m.title,n.rid from movie m join 
(select mid,rid from rating group by mid,rid) n where m.mid=n.mid) a where r.rid=a.rid order by a.title,r.name;

15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. (1 point possible)

select b.name,s.title,b.stars from movie s join(select r.name,a.mid,a.stars from reviewer r join
(select * from rating where stars in(select min(stars)from rating)) a on r.rid=a.rid) b on s.mid=b.mid;

16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. (1 point possible)

select m.title ,n.avg from movie m join (select mid,avg(stars) as avg from rating group by mid) n 
on m.mid=n.mid order by avg desc,m.title;

17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) (1 point possible)

select name from reviewer where rid in(select rid from rating group by rid having count(rid)>=3);

18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)

select title, director from movie where director in
(select director from movie group by director having count(title)>1) order by director,title;

19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

select m.title ,q.avg from movie m join
(select mid,avg(stars) as avg from rating group by mid having avg(stars)=
 (select max(average) from(select mid,avg(stars) as average from rating group by mid) a)) q 
 where m.mid=q.mid;

20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

select m.title,s.avg from movie m join
(select mid,avg(stars) as avg from rating group by mid having avg(stars)=
(select min(average)from (select mid,avg(stars) as average from rating group by mid) p)) 
s where m.mid=s.mid;

21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. (1 point possible)

select distinct director, title, stars from (select * from Rating join Movie using(mID) ) BestMovies
where not exists (select * from Rating join Movie using(mID) where 
BestMovies.director = director and BestMovies.stars < stars) and not director is null;