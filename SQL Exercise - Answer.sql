--Section I. Simple queries 
--Exercise 1: 459 rows
Select
	EventName,
	EventDate
from
	tblEvent te
order by
	EventDate desc;
	
--Exercise 2: 5 rows
Select
	top 5 EventName as What,
	EventDetails as Details
from
	tblEvent te
order by
	EventDate asc;
	
--Exercise 3: 3 rows
Select
	top 3 
	CategoryID,
	CategoryName
from
	tblCategory tc
order by
	CategoryName desc;
	
--Exercise 4: 2 rows - Click on the 'Text' instead of 'Grid' to switch
Select
	top 2 EventName,
	EventDetails
from
		tblEvent
order by
		EventDate asc;

Select
	top 2 EventName,
	EventDetails
from
		tblEvent
order by
		EventDate desc;
		
--Section II. Use WHERE
--Exercise 1: 3 rows
Select
	*
from
	tblEvent
where
	CategoryID = 11;
	
--Exercise 2: 2 rows
Select
	*
from
	tblEvent
where
	year(EventDate) = 2005
	and month(EventDate) = 2;

--Exercise 3: 2 rows
Select
	*
from
	tblEvent
where
	EventName like '%Teletubbies%'
	or EventName like '%Pandy%';

--Exercise 4: 6 rows - 13 rows without the '>=1970' filter
Select
	*
from
	tblEvent
where
	(CountryID in (8, 22, 30, 35)
	or EventDetails like '%Water%'
	or CategoryID = 4)
	and year(EventDate) >= 1970;

--Exercise 5: 4 rows
Select
	*
from
	tblEvent
where
	CategoryID != 14
	and EventDetails like '%Train%';

--Exercise 6: 6 rows
Select
	*
from
	tblEvent
where
	CountryID = 13
	and EventName not like '%Space%'
	and EventDetails not like '%Space%';

--Exercise 7: 91 rows
Select
	*
from
	tblEvent
where
	CategoryID in (5, 6)
	and EventDetails not like '%War%'
	and EventDetails not like '%Death%';

--Section III: Calculations
--Exercise 1:
Select
	te.EventName,
	len(te.EventName) as [Number of EventNameChar]
from
	tblEvent te
order by
	[Number of EventNameChar] asc;

--Exercise 2: 459 rows
Select
	concat (te.EventName,' ',
	tc.CategoryID) as [Event Name & CateID]
from
	tblEvent te
left join tblCategory tc on
	te.CategoryID = tc.CategoryID; 

--Exercise 3: 8 rows
--ISNULL function
Select
	tc.ContinentID,
	tc.ContinentName,
	isnull(tc.Summary,
	'No summary') as [Summary]
from
	tblContinent tc;

--COALESCE function
Select
	tc.ContinentID,
	tc.ContinentName,
	coalesce(tc.Summary,
	'No summary') as [Summary]
from
	tblContinent tc; 

--CASE WHEN function
Select
	tc.ContinentID,
	tc.ContinentName,
	case
		when tc.Summary is null then 'No summary'
		else tc.Summary
	end
from
	tblContinent tc;

--Exercise 4:
--Explanation Table: 5 rows
Select
	distinct
case
		when tc.ContinentID in (1 , 3) then '1 or 3'
		when tc.ContinentID in (5, 6) then '5 or 6'
		when tc.ContinentID in (2, 4) then '2 or 4'
		when tc.ContinentID in (7) then '7'
		else 'Otherwise'
	end as [Continent id],
	case
		when tc.ContinentID in (1 , 3) then 'Eurasia'
		when tc.ContinentID in (5, 6) then 'Americas'
		when tc.ContinentID in (2, 4) then 'Somewhere hot'
		when tc.ContinentID in (7) then 'Somewhere cold'
		else 'Somewhere else'
	end as [Belongs to],
	case
		when tc.ContinentID in (1 , 3) then 'Europe or Asia'
		when tc.ContinentID in (5, 6) then 'North and South Ameria'
		when tc.ContinentID in (2, 4) then 'Africa and Australasia'
		when tc.ContinentID in (7) then 'Antarctica'
		else 'International'
	end as [Actual continent (for interest)]
from
	tblContinent tc
left join tblCountry tc2 on
	tc.ContinentID = tc2.ContinentID;

--Country list: 43 rows
Select
	tc.ContinentID,
	tc2.CountryName,
	case
		when tc.ContinentID in (1 , 3) then 'Eurasia'
		when tc.ContinentID in (5, 6) then 'Americas'
		when tc.ContinentID in (2, 4) then 'Somewhere hot'
		when tc.ContinentID in (7) then 'Somewhere cold'
		else 'Somewhere else'
	end as [Belongs to],
	case
		when tc.ContinentID in (1 , 3) then 'Europe or Asia'
		when tc.ContinentID in (5, 6) then 'North and South Ameria'
		when tc.ContinentID in (2, 4) then 'Africa and Australasia'
		when tc.ContinentID in (7) then 'Antarctica'
		else 'International'
	end as [Actual continent (for interest)]
from
	tblContinent tc
left join tblCountry tc2 on
	tc.ContinentID = tc2.ContinentID;

--Exercise 5: 196 rows
--CAST function
Select
	*,
	concat(cast(cba.KmSquared / 20761 as int), ' time(s) ', Country, ' could accommodate Wales') as 'WalesUnit',
	(cba.KmSquared - cast(cba.KmSquared / 20761 as int) * 20761) as 'AreaLeftOver',
	row_number () over(
	order by abs(cba.KmSquared - 20761) asc) [Closest size to Wales]
from
	CountriesByArea cba; 

--FLOOR function
Select
	*,
	concat(floor(cba.KmSquared / 20761), ' time(s) ', Country, ' could accommodate Wales')as 'WalesUnit',
	(cba.KmSquared - floor(cba.KmSquared / 20761) * 20761) as 'AreaLeftOver',
	row_number () over(
	order by abs(cba.KmSquared - 20761) asc) [Closest size to Wales]
from
	CountriesByArea cba; 

--Exercise 6: 7 rows
--WHERE function
select
	te.EventName
from
	tblEvent te
where
	left (te.EventName, 1) in ('a', 'e', 'i', 'o', 'u')
	and right(te.EventName, 1) in ('a', 'e', 'i', 'o', 'u');

--Exercise 7: 21 rows
select
	te.EventName
from
	tblEvent te
where
	left (te.EventName, 1) 
	= right(te.EventName, 1);

--Section IV: Calculations using dates
--Exercise 1: 5 rows
Select
	te.EventName,
	format(te.EventDate,
	'dd/MM/yyyy') as [Event took place in 1998]
from
	tblEvent te
where
	year(te.EventDate) = '1998';

--Exercise 2:
Select
	te.EventName,
	te.EventDate,
	abs(datediff(day, '1998/02/20', te.EventDate)) as [Number of days]
from
	tblEvent te
order by
	[Number of days] asc;

--Exercise 3:
Select
	te.EventName,
	concat(datename(weekday, te.EventDate), ' ', datename(day, te.EventDate),
		case
			when datename(day, te.EventDate) in (1, 21, 31) then 'st'
			when datename(day, te.EventDate) in (2, 22) then 'nd'
			when datename(day, te.EventDate) in (3, 23) then 'rd'
			else 'th'
		end) as [Event Date],
	case
		when datename(weekday, te.EventDate) = 'Friday'
		and day (te.EventDate) = '13' then 'The unlucky day'
		when datename(weekday, te.EventDate) = 'Thursday'
		and day (te.EventDate) = '12' then 'The day before'
		when datename(weekday, te.EventDate) = 'Saturday'
		and day (te.EventDate) = '14' then 'The day after'
		else ' '
	end as [Friday 13th]
from
	tblEvent te
order by
	[Event Date]; 

--Exercise 4:
Select
	te.EventName,
	concat(datename(weekday, te.EventDate), ' ', datename(day, te.EventDate),
		case 
			when datename(day, te.EventDate) in (1, 21, 31) then 'st'
			when datename(day, te.EventDate) in (2, 22) then 'nd'
			when datename(day, te.EventDate) in (3, 23) then 'rd'
			else 'th'
		end, ' ', 
		datename(month, te.EventDate), ' ', datename(year, te.EventDate)) as [Event Date]
from
	tblEvent te
order by
	year(te.EventDate) asc;

--Section V: Basic joins
--Exercise 1: 13 rows
Select
	ta.AuthorName,
	te.Title,
	te.EpisodeType
from
	tblAuthor ta
inner join tblEpisode te on
	ta.AuthorId = te.AuthorId
where
	te.EpisodeType like '%Special%'
order by
	te.Title;

--Exercise 2: 15 rows
Select
	td.DoctorName,
	te.Title
from
	tblEpisode te
left join tblDoctor td on
	te.DoctorId = td.DoctorId
where
	year(te.EpisodeDate) = 2010;
	
--Exercise 3: 459 rows
Select
	tc.CountryName,
	te.EventName,
	te.EventDate
from
	tblCountry tc
inner join tblEvent te on
	tc.CountryID = te.CountryID
order by
	te.EventDate;
	
	
--Exercise 4: 5 rows
Select
	te.EventName,
	tc.CountryName,
	tc2.ContinentName
from
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID
left join tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
where
	tc2.ContinentName = 'Antarctic'
	or tc.CountryName = 'Russia'

--Exercise 5: Inner join - 459 rows
Select
	te.EventName,
	te.CategoryID,
	tc.CategoryName
from
	tblEvent te
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID;

--Full outer join - 461 rows
Select
	te.EventName,
	te.EventDate,
	tc.CategoryName
from
	tblEvent te
full outer join tblCategory tc on
	te.CategoryID = tc.CategoryID;
	
--There are 2 categories which don't have any corresponding events.
Select
	te.EventName,
	te.CategoryID,
	tc.CategoryName
from
	tblEvent te
full outer join tblCategory tc on
	te.CategoryID = tc.CategoryID
where
	te.EventID is null;

--Exercise 6: 16 rows
Select
	te.Title,
	ta.AuthorName,
	te2.EnemyName
from
	tblAuthor ta
inner join tblEpisode te on
	ta.AuthorId = te.AuthorId
inner join tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
inner join tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
where
	te2.EnemyName = 'Daleks';

--Exercise 7: 2 rows
Select
	ta.AuthorName,
	te2.Title,
	td.DoctorName,
	te.EnemyName,
	te.Description,
	(len(ta.AuthorName)+
	len(te2.Title)+
	len(td.DoctorName)+
	len(te.EnemyName)) as [Total_Characters]
from
	tblEnemy te
inner join tblEpisodeEnemy tee on
	te.EnemyId = tee.EnemyId
inner join tblEpisode te2 on
	tee.EpisodeId = te2.EpisodeId
inner join tblDoctor td on
	te2.DoctorId = td.DoctorId
inner join tblAuthor ta on
	te2.AuthorId = ta.AuthorId
group by
	ta.AuthorName,
	te2.Title,
	td.DoctorName,
	te.EnemyName,
	te.Description
Having
	sum (len(ta.AuthorName) + len(te2.Title) + len(td.DoctorName) + len(te.EnemyName)) <40;
	
--Exercise 8: 1 row
Select
	*
from
	tblCountry tc
full outer join tblEvent te on
	tc.CountryID = te.CountryID
where
	te.EventID is null;
	
--Section 6: Aggregation & grouping
--Exercise 1: 25 rows
Select
	ta.AuthorName,
	count(distinct te.EpisodeId) as [Number of Episodes],
	min(te.EpisodeDate) as [Earliest Episode Date],
	max(te.EpisodeDate) as [Latest Episode Date]
from
	tblEpisode te
left join tblAuthor ta on
	te.AuthorId = ta.AuthorId
group by
	ta.AuthorName
order by
	count(distinct te.EpisodeId) desc;

--Exercise 2: Inner join - 18 rows, Left join - 20 rows
Select
	tc.CategoryName,
	count(distinct te.EventID) as [Number of Events]
from
	tblCategory tc
left join tblEvent te on
	tc.CategoryID = te.CategoryID
group by
	tc.CategoryName
order by
	count(distinct te.EventID) desc;

--Exercise 3: 1 row
Select
	count (distinct te.EventName) as [Number of Events],
	min (te.EventDate) as [First Date],
	max (te.EventDate) as [Last Date]
from
	tblEvent te;

--Exercise 4: 42 rows
Select
	tc.CountryName,
	tc2.ContinentName,
	count(distinct te.EventID) as [Number of Events]
from
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID
left join tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
group by
	tc.CountryName,
	tc2.ContinentName;

--Exercise 5: 4 rows
Select
	ta.AuthorName,
	td.DoctorName,
	count (distinct te.EpisodeId) as [Number of Episodes]
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
inner join tblDoctor td on
	te.DoctorId = td.DoctorId
group by
	ta.AuthorName,
	td.DoctorName
having
	count (distinct te.EpisodeId) > 5
order by
	count (distinct te.EpisodeId) desc;

--Exercise 6: 4 rows
Select
	year(td.BirthDate) as [Doctor's BirthDate],
	te2.EnemyName,
	year(te.EpisodeDate) as [Episode Year],
	count (distinct te.EpisodeId) as [No_of_Episodes]
from
	tblEpisode te
inner join tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
inner join tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
inner join tblDoctor td on
	te.DoctorId = td.DoctorId
where
	year(td.BirthDate) < 1970
group by
	year(td.BirthDate),
	year(te.EpisodeDate),
	te2.EnemyName
having
	count (distinct te.EpisodeId) >1
order by
	count (distinct te.EpisodeId) desc;

--Exercise 7: 12 rows without nulls - 14 rows with nulls
select
	left(tc.CategoryName, 1),
	count(distinct te.EventID) as [Number of events],
	avg(len(EventName)) as [Average event name length]
from
	tblEvent te
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID
group by
	left(tc.CategoryName, 1)
order by 
	avg(len(EventName)) desc;

--Exercise 8: 4 rows
select
	concat(1 + (year(EventDate) - 1) / 100,  
		case when right(1 + (year(EventDate) - 1) / 100, 1) = 1 then ' st'
			 when right(1 + (year(EventDate) - 1) / 100, 1) = 2 then ' nd'
			 when right(1 + (year(EventDate) - 1) / 100, 1) = 3 then ' rd'
			 else 'th'
		end,' century') as Century,
	count(distinct EventID) as [Number of events]
from
	tblEvent te
group by
	1 + (year(EventDate) - 1) / 100;

--SQL Queries
--Section I: Subqueries
--Exercise 1: 4 rows
select
	te.EventName,
	te.EventDate
from
	tblEvent te
where
	te.EventDate > 
	(select max(te.EventDate)
	from
		tblEvent te
	where
		te.CountryID = 21);
		
--Exercise 2: 204 rows
Select
	te.EventName
from
	tblEvent te
where
	len(te.EventName) > 
	(select
		avg(len(te.EventName))
	from
		tblEvent te);
		
--Select 3: 8 rows
Select
	te.EventName,
	tc2.ContinentName
from
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
inner join tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
where tc2.ContinentName in
	(select
		top 3 tc2.ContinentName
	from
		tblEvent te
	inner join tblCountry tc on
		te.CountryID = tc.CountryID
	inner join tblContinent tc2 on
		tc.ContinentID = tc2.ContinentID
	group by
		tc2.ContinentName
	order by
		count(distinct te.EventID) asc);
		
--Select 4: 5 rows
Select
	distinct tc.CountryName
from
	tblCountry tc
left join tblEvent te on
	tc.CountryID = te.CountryID
where
	tc.CountryID in 
	(select
		tc.CountryID
	from
		tblCountry tc
	left join tblEvent te on
		tc.CountryID = te.CountryID
	group by
		tc.CountryID
	having
		count(distinct te.EventID) > 8);
	
--Exercise 5: 8 rows
Select
	te.EventName
from
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
inner join tblCategory tc2 on
	te.CategoryID = tc2.CategoryID
where
	tc.CountryID not in
	(select
		top 30 tc.CountryID
	from
		tblCountry tc
	order by
		tc.CountryName desc)
	and tc2.CategoryID not in
	(select
		top 15 tc2.CategoryID
	from
		tblCategory tc2
	order by
		tc2.CategoryName desc);
	
--Section II: CTEs
--Excercise 1: 4 rows
--Create full table in the CTE
With ThisAndThat as
(select
	case
		when te.EventDetails like '%this%' then '1'
		else '0'
	end as [IfThis],
		case
		when te.EventDetails like '%that%' then '1'
		else '0'
	end as [IfThat],
	count(distinct te.EventDetails) as [Number of Events]
from
	tblEvent te
group by te.EventDetails) 

Select
	tt.IfThis,
	tt.IfThat,
	count(*) as [Number of Events]
from
	ThisAndThat tt
where [IfThis] = 0 and [IfThat] = 0 or
	  [IfThis] = 0 and [IfThat] = 1 or
	  [IfThis] = 1 and [IfThat] = 0 or
	  [IfThis] = 1 and [IfThat] = 1
group by tt.IfThis, tt.IfThat;

--Another method
With ThisAndThat as
(select
	case
		when te.EventDetails like '%this%' then '1'
		else '0'
	end as [IfThis],
		case
		when te.EventDetails like '%that%' then '1'
		else '0'
	end as [IfThat],
	te.EventID 
from
	tblEvent te)

Select
	tt.IfThis,
	tt.IfThat,
	count(EventID) as [Number of Events]
from
	ThisAndThat tt
where [IfThis] = 0 and [IfThat] = 0 or
	  [IfThis] = 0 and [IfThat] = 1 or
	  [IfThis] = 1 and [IfThat] = 0 or
	  [IfThis] = 1 and [IfThat] = 1
group by tt.IfThis, tt.IfThat;

--Three events contains both 'This' and 'That'
Select
	te.EventName,
	te.EventDetails 
from
	tblEvent te
where
	te.EventDetails like '%this%'
	and te.EventDetails like '%that%';

--Exercise 2: 230 rows
Select
	EventName, 
	tc.CountryName
from
	(Select
		te.EventName,
		CountryID
	from
		tblEvent te
	where
		right(te.EventName, 1) like '[N-Z]') as Second_half_Derived
left join tblCountry tc on
	Second_half_Derived.CountryID = tc.CountryID;

--Exercise 3: 4 rows
With EpisodeIDMP as
(select
	te.EpisodeId
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
where
	ta.AuthorName like '%MP%')

--Outer Select
Select
	distinct tc.CompanionName
from
	tblCompanion tc
inner join tblEpisodeCompanion tec on
	tc.CompanionId = tec.CompanionId
inner join EpisodeIDMP on
	tec.EpisodeId = EpisodeIDMP.EpisodeId
where
	tec.EpisodeId = EpisodeIDMP.EpisodeId;

--Exercise 4: 116 rows
With NonOWLevent as
(Select
	te.EventName,
	te.CountryID
from
	tblEvent te
where
	te.EventDetails not like '%O%'
	and te.EventDetails not like '%W%'
	and te.EventDetails not like '%L%'),

OtherEventInNonOWLcountries as 
(Select
	te.EventName,
	te.CategoryID
from
	tblEvent te
inner join NonOWLevent on
	te.CountryID = NonOWLevent.CountryID)
--Outer Select
Select
	distinct te.EventName, te.EventDate, tc.CategoryName, tc2.CountryName 
from
	tblEvent te
inner join OtherEventInNonOWLcountries on
	te.CategoryID = OtherEventInNonOWLcountries.CategoryID
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID 
inner join tblCountry tc2 on
	te.CountryID = tc2.CountryID
order by
	te.EventDate;
	
--Exercise 5: 3 rows
With EraTbl as
(select
	te.EventID,
	case
		when year (te.EventDate) <1900 then '19th century and earlier'
		when year (te.EventDate) <2000 then '20th century'
		else '21st century'
	end as [Era]
from
	tblEvent te)
	
--Outer Select
Select
	EraTbl.Era,
	count(EraTbl.Era) as [Number of Events]
from
	tblEvent te
inner join EraTbl on
	te.EventID = EraTbl.EventID
group by
	EraTbl.Era;

