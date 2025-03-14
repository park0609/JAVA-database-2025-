SELECT max(sal + nvl(comm,0)) AS "MAX"
	 , min(sal + nvl(comm,0)) AS "MIN"
	 , round(avg(sal + nvl(comm,0)),1) AS "AVG"
  FROM emp;
 

SELECT count(birthday)
	 , CASE to_char(birthday, 'MM') WHEN '01' THEN count(*) END AS "JAN"
	 , CASE to_char(birthday, 'MM') WHEN '02' THEN count(*) END AS "FEB"
	 , CASE to_char(birthday, 'MM') WHEN '03' THEN count(*) END AS "MAR"
	 , CASE to_char(birthday, 'MM') WHEN '04' THEN count(*) END AS "APR"
	 , CASE to_char(birthday, 'MM') WHEN '05' THEN count(*) END AS "MAY"
	 , CASE to_char(birthday, 'MM') WHEN '06' THEN count(*) END AS "JUN"
	 , CASE to_char(birthday, 'MM') WHEN '07' THEN count(*) END AS "JUL" 
	 , CASE to_char(birthday, 'MM') WHEN '08' THEN count(*) END AS "AUG"
	 , CASE to_char(birthday, 'MM') WHEN '09' THEN count(*) END AS "SEP"
	 , CASE to_char(birthday, 'MM') WHEN '10' THEN count(*) END AS "OCT"
	 , CASE to_char(birthday, 'MM') WHEN '11' THEN count(*) END AS "NOV"
	 , CASE to_char(birthday, 'MM') WHEN '12' THEN count(*) END AS "DEC"
  FROM student
 GROUP BY to_char(birthday, 'MM')
 ORDER BY to_char(birthday, 'MM');

SELECT tel
	 , CASE tel WHEN '02' THEN count(*) end
  FROM student
 GROUP BY tel;
