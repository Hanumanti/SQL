
--1
select DEVELOPIN , AVG(SCOST) [avg selling cost of pascal] from software
where DEVELOPIN = 'PASCAL'
group by DEVELOPIN;

--2
select PNAME , DATEDIFF(year,DOB,GETDATE()) [age of programmer] from programmer;

--3
select PNAME , COURSE from studies
where course = 'DAP';

--4
select PNAME , DOB from programmer
where datepart(month,dob) = 1 ;

--5
select PNAME , title , sold from software
where sold = (select max(sold) from Software);

--6
select pname , course_fee from studies
where course_fee = (select min(course_fee) from Studies) ;

--7
select PNAME , course from Studies
where course = 'PGDCA';

--8
select sum(revenue) [total_revenue]  from (select title , developin , (scost+dcost)*sold [revenue] from software
where lower(developin) = 'c') t;

--9
select * from software
where lower(PNAME) = 'ramesh';

--10
select count(PNAME) [number of people studies at sabhari] from studies
where lower(institute) = 'sabhari';

--11
select t.title , t.developin ,sum(t.revenue) [total_revenue] from (select * , round((scost+dcost)*sold,2) [revenue] from software) t 
group by t.title  ,t.developin 
having sum(t.revenue) > 2000;

--12
select * , (scost+dcost)*sold [revenue] from software
where (scost+dcost)*sold > DCOST;

--13
select * from software
where lower(developin) = 'basic';

--14
select count(*) [total packages developed in dbase] from software
where lower(developin) = 'dbase';

--15
select count(*) [total people studied in pragathi]  from Studies
where lower(INSTITUTE) = 'pragathi';

--16
select count(*) [total programmers who paid between 5000 to 10000] from Studies
where COURSE_FEE between 5000 and 10000;

--17
select AVG(course_fee) from Studies;

--18
select * from programmer 
where lower(prof1) = 'c' or lower(prof2) = 'c';

--19
select count(*) from programmer
where lower(prof1) in ('cobol','pascal') or lower(prof2) in ('cobol','pascal') ;

select * from programmer;

--20
select pname,prof1,prof2 from programmer
where (lower(prof1) = 'c' and lower(prof2) = 'pascal' ) or (lower(prof1) = 'pascal' and lower(prof2) = 'c');

--21
select  MAX(DATEDIFF(year,DOB,GETDATE())) [oldest programmer] from programmer;

--22
select avg(DATEDIFF(year,DOB,GETDATE())) [avg age of programmer] from programmer
where lower(gender) = 'f';

--23
select Pname , DATEDIFF(year,DOJ,GETDATE()) [experince in years] from programmer
order by Pname DESC; 

--24
select Pname from programmer
where datepart(month,dob) = datepart(month , getdate())

--25
select count(*) [total female programmers] from programmer
where lower(gender) = 'f';

--26
select prof1 [languages studied by male programmers] from programmer
where lower(gender) = 'm'
union
select prof2 from programmer
where lower(gender) = 'm'

--27
select avg(salary) [avg salary] from programmer

--28
select count(*) [total employees with salary between 2000 and 4000]from programmer
where salary between 2000 and 4000;

--29
select * from programmer 
where prof1 <> 'clipper' and prof1 <>'cobol' and prof1<>'pascal' 
		and prof2<>'clipper' and prof2<>'cobol' and prof2<>'pascal'

--30
select pname, developin , scost+dcost [cost of package] from Software;

--31
select pname, developin , (scost+dcost)*sold [sales value of package] from Software;

--32
select pname, sum(sold) [total packages sold] from Software
group by pname;

--33
select pname, developin , scost from Software

--34
select developin , round(avg(scost),2) [avg scost]  , avg(dcost) [avg dcost] , round(avg(scost)+avg(dcost),2) [ avg price per copy] from Software
group by developin;

--35
select pname , max(scost+dcost) [costliest package], min(scost+dcost) [cheapest package] from software
group by pname;

--36
select institute ,count(institute) [total courses] ,  avg(course_fee) [avg course fee] from studies
group by institute;

--37
select institute ,count(institute) [total students] from studies
group by institute;

--38
select pname , gender from programmer;

--39
select pname , title from software
order by pname;

--40
select t.developin , count(t.developin) [number of packages in language] from ( select * from software where lower(developin) not in ('c','c++') )t
group by t.developin;

--41
select developin , count(*) [number of packages] from software 
where dcost < 1000
group by developin;

--42
select title , round(abs(avg(scost)-avg(dcost)),2) [avg difference between dcost and scost] from software
group by title;

--43
SELECT SUM(SCOST), SUM(DCOST), SUM(DCOST-(SOLD*SCOST)) FROM SOFTWARE 
GROUP BY pname 
HAVING SUM(DCOST)>SUM(SOLD*SCOST);

--44
select max(salary) [max salary] , min(salary) [min salary] ,avg(salary) [avg salary] from programmer
where salary  > 2000;

--45
select top 1 pname , max(salary) [salary] from programmer
where upper(prof1) = 'C' or upper(prof2) = 'C'
group by pname
order by max(salary) desc;

--46
select top 1 pname , max(salary) [salary] from programmer
where lower(gender) = 'f'
group by pname
order by max(salary) desc;

--47
with union_table as 
				(
				select pname , prof1 as prof ,salary from programmer
				union
				select pname , prof2 , salary from programmer
				)
select pname , prof , salary from (select  * , dense_rank() over(partition by prof order by salary desc) [rank_] from union_table  ) t
where t.rank_ = 1
order by prof;

--48
select top 1 Pname , DATEDIFF(year,DOJ,GETDATE()) [experince in years] from programmer
order by DATEDIFF(year,DOJ,GETDATE()); 

--49
select top 1 pname , datediff(day, doj , convert(date,getdate())) [exp in days] from programmer
where lower(gender) = 'm'
order by datediff(day, doj , convert(date,getdate())) desc;

--50
select t.prof1 ,count(*) [no of programmer knowing] from (select prof1 from programmer
				      union all
					  select prof2 from programmer) t
group by prof1
having count(*) = 1;  

--51
select * from (select pname , prof1 from programmer
		      union all
			  select pname , prof2 from programmer) t 
where lower(prof1) in ('cpp','foxpro','oracle');

--52
select top 1 Pname , DATEDIFF(year,DOB,GETDATE()) [age] from programmer
where lower(prof1) = 'dbase' or lower(prof2) = 'dbase'
order by DATEDIFF(year,DOB,GETDATE()); 

--53
select * from programmer
where lower(gender) = 'f' and salary > 3000 and lower(prof1) not in ('c','c++','oracle','dbase') and lower(prof2) not in ('c','c++','oracle','dbase')

--54
select top 1 institute , count(pname) [number of students] from studies
group by institute 
order by count(pname) desc;

--55
select top 1 course ,  max(course_fee) [course fee] from studies
group by course;

--56
select top 1 course , count(pname) [number of students] from studies
group by course;

--57
select top 1 institute , course,  max(course_fee) [course fee] from studies
group by institute , course 
order by max(course_fee) desc;

--58
select institute , course ,  course_fee from studies
where course_fee < (select avg(course_fee) from studies);

--59
select course ,  course_fee from studies
where course_fee between (select avg(course_fee) from studies)-1000 and (select avg(course_fee) from studies)+1000;

--60
select title , dcost from software
where dcost = (select max(dcost) from software);

--61
with t as 
		(SELECT COURSE, COUNT(PNAME) [no_of_students] FROM studies GROUP BY COURSE )

select t.course , t.no_of_students from t
where t.no_of_students <= (SELECT AVG(t.no_of_students) FROM t)

--62
SELECT TITLE,SCOST FROM SOFTWARE 
WHERE SCOST = (SELECT MIN(SCOST) FROM SOFTWARE);

--63
select pname,sold from software 
where sold = (select min(sold) from software);

--64
SELECT DEVELOPIN,SCOST FROM SOFTWARE 
WHERE SCOST = (SELECT MAX(SCOST) FROM SOFTWARE);

--65
SELECT SOLD,TITLE FROM SOFTWARE
WHERE TITLE = (SELECT TITLE FROM SOFTWARE
WHERE (DCOST-SCOST)=(SELECT MIN(DCOST-SCOST) FROM SOFTWARE));

--66
SELECT TITLE FROM SOFTWARE 
WHERE DCOST = (SELECT MAX(DCOST)FROM SOFTWARE WHERE DEVELOPIN LIKE 'PASCAL');

--67
SELECT DEVELOPIN FROM SOFTWARE 
GROUP BY DEVELOPIN 
HAVING DEVELOPIN = (SELECT MAX(DEVELOPIN) FROM SOFTWARE);

--68
SELECT PNAME FROM SOFTWARE 
GROUP BY PNAME 
HAVING PNAME = (SELECT MAX(PNAME) FROM SOFTWARE);

--69
SELECT PNAME, DCOST FROM SOFTWARE 
WHERE DCOST = (SELECT MAX(DCOST) FROM SOFTWARE);

--70
SELECT TITLE FROM SOFTWARE 
WHERE SOLD < (SELECT AVG(SOLD) FROM SOFTWARE);

--71
SELECT distinct PNAME FROM SOFTWARE 
WHERE SOLD*SCOST > 2*DCOST;

--72
SELECT PNAME,TITLE FROM SOFTWARE 
WHERE DCOST IN (SELECT MIN(DCOST) FROM SOFTWARE GROUP BY DEVELOPIN);

--73
SELECT PNAME, DEVELOPIN FROM SOFTWARE 
WHERE SOLD IN (SELECT MAX(SOLD) FROM SOFTWARE GROUP BY PNAME) 
UNION 
SELECT PNAME, DEVELOPIN FROM SOFTWARE 
WHERE SOLD IN (SELECT MIN(SOLD) FROM SOFTWARE GROUP BY PNAME);

--74
SELECT pname , case 
					when dateadd(year, datediff(YEAR, dob, getdate()), dob) > getdate() 
						then datediff(YEAR, dob, getdate()) - 1 
					else datediff(YEAR, dob, getdate()) end As Age 
																	from programmer 
where dob = (SELECT max(dob) from programmer where YEAR(dob)='1965'and GENDER='M')

--75
SELECT pname , case 
					when dateadd(year, datediff(YEAR, dob, getdate()), dob) > getdate() 
						then datediff(YEAR, dob, getdate()) - 1 
					else datediff(YEAR, dob, getdate()) end As Age 
																	from programmer 
where dob = (SELECT min(dob) from programmer where YEAR(doj)='1992'and GENDER='F');

--76
CREATE TABLE TEMP (YOB INT, CNT INT)

INSERT INTO TEMP
SELECT YEAR(DOB) AS YEAR ,COUNT(pname) FROM programmer GROUP BY YEAR(DOB) 

SELECT * FROM TEMP 

SELECT YOB, CNT FROM TEMP WHERE CNT= (SELECT MAX(CNT) FROM TEMP);

--77
CREATE TABLE MOJ (MOJ INT, CNT INT)

INSERT INTO MOJ 
SELECT MONTH(DOJ),COUNT(pname) FROM programmer 
GROUP BY MONTH(DOJ)

SELECT MOJ, CNT FROM MOJ 
WHERE CNT= (SELECT MAX(CNT) FROM MOJ);

--78
CREATE TABLE PCNT (PR VARCHAR(20), CNT INT)
CREATE TABLE PsCNT (PRs VARCHAR(20), sCNT INT)

INSERT INTO PCNT 
SELECT PROF1, COUNT(pname) FROM programmer GROUP BY PROF1 
UNION ALL 
SELECT PROF2, COUNT(pname) FROM programmer GROUP BY PROF2

select * from PCNT

INSERT INTO PsCNT
SELECT PR, SUM(CNT) FROM PCNT GROUP BY PR

select * from PsCNT 

SELECT PRs, sCNT FROM PsCNT 
WHERE sCNT =(SELECT MAX(sCNT) FROM PsCNT)

--79
SELECT PNAME FROM PROGRAMMER 
WHERE GENDER LIKE 'M'AND SALARY < (SELECT(AVG(SALARY)) FROM PROGRAMMER WHERE GENDER LIKE 'F')

--80
SELECT PNAME FROM PROGRAMMER 
WHERE GENDER = 'F' AND SALARY > (SELECT(MAX(SALARY))FROM PROGRAMMER WHERE GENDER = 'M');

--81
SELECT PROF1 FROM PROGRAMMER 
GROUP BY PROF1 
HAVING PROF1 = (SELECT MAX(PROF1) FROM PROGRAMMER)
union 
SELECT PROF2 FROM PROGRAMMER 
GROUP BY PROF2 
HAVING PROF2 = (SELECT MAX(PROF2) FROMPROGRAMMER);

--82
Select * From PROGRAMMER 
Where Salary in (Select Salary From PROGRAMMER Group by Salary Having Count(Salary ) > 1);

--83
select * from programmer p , software s 
where p.pname = s.pname and salary > 3000 and gender='m';

--84
select s.* from programmer p , software s 
where p.pname = s.pname and gender='f' and DEVELOPIN ='pascal';

--85
select * from programmer 
where year(doj)< 1990;

--86
select s.* from software s , studies st , programmer p 
where s.pname = st.pname and p.pname=s.pname and gender='f' and institute='pragathi';

--87
Select sd.institute, count(sf.developin) AS developin , count(sf.sold) As Sold, sum(sf.sold*sf.scost) AS sales from software sf , studies sd 
where sf.pname =sd.pname 
group by sd.institute;

--88
CREATE TABLE INST (INS VARCHAR(20), CNT INT)

INSERT INTO INST
SELECT INSTITUTE, COUNT(PNAME) FROM studies 
GROUP BY INSTITUTE 

SELECT distinct SW.* FROM software AS SW, programmer AS PG, studies AS ST, INST
WHERE DEVELOPIN='DBASE' 
		AND GENDER='M' 
			AND SW.PNAME = PG.PNAME 
				AND INSTITUTE = INS 
					AND CNT= (SELECT MAX(CNT) FROM INST);

--89
SELECT S.*, YEAR(DOB),GENDER FROM Programmer p , Software s 
WHERE s.PNAME=p.PNAME 
			AND((GENDER='M' AND YEAR(DOB)<1965) OR (GENDER='F' AND YEAR(DOB)>1975));

--90
select s.* from programmer p , software s 
where s.pname = p.pname and (developin <> prof1 and developin <> prof2);

--91
select s.* from software s,studies st,programmer p 
where s.pname=st.pname and p.pname=s.pname and gender='m' and institute='Sabhari';

--92
select pname from programmer 
where pname not in(select pname from software);

--93
select sum(scost) from software s,studies st
where s.pname=st.pname and institute='apple';

--94
select a.pname,a.doj from programmer a , programmer b 
where a.doj=b.doj and a.pname <> b.pname;

--95
select distinct(a.pname),a.prof2 from programmer a , programmer b 
where a.prof2=b.prof2 and a.pname <> b.pname;

--96
select studies.institute , sum(software.sold*software.scost) from software , studies
where studies.pname = software.pname 
group by studies.institute;

--97
select institute from software st , studies s 
where s.pname = st.pname 
group by institute,dcost 
having dcost=(select max(dcost)from software);

--98
select prof1 from programmer 
where prof1 not in (select developin from software) 
union
select prof2 from programmer 
where prof2 not in(select developin from software);

--99
select p1.salary,s2.course from programmer p1 , software s1 ,  studies s2 
where p1.pname = s1.pname 
			and s1.pname = s2.pname 
				and scost = (select max(scost) from software);

--100
select avg(salary) from programmer p,software s
where p .pname=s.pname and sold*scost>50000;

--101
select s.pname, count(title) As packages from software s , studies st
where s.pname = st.pname 
group by s.pname,course_fee 
having min(course_fee) = (select min(course_fee) from studies);

--102
select count(developin) from programmer p , software s 
where s.pname = p.pname 
group by developin 
having min(dcost)=(select min(dcost) fromsoftware);

--103
select count(developin) from programmer p , software s 
where s.pname = p.pname 
			and gender='f' 
					and salary>(select max(salary) from programmer p, software s where s.pname=p.pname and gender='m');

--104
select count(*) from software s , programmer p 
where p.pname = s.pname 
group by doj 
having min(doj) = (select min(doj)from studies st,programmer p, software s where p.pname=s.pname and st.pname=p.pname and (institute='bdps'));

--105
select pname,institute from studies
where pname not in(select pname from software);

--106
select	 sum(scost*sold-dcost) "PROFIT" from software 
where developin in (select prof1 from programmer) 
group by developin;

--107
select s.pname , count(developin) from programmer p1 , software s
where p1.pname=s.pname 
group by s.pname;









