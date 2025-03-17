-- 1번 연습문제

SELECT *
  FROM professor;

SELECT *
  FROM department;

SELECT *
  FROM PROFESSOR p, DEPARTMENT d 
 WHERE p.deptno = d.deptno;

CREATE VIEW v_prof_dept2
AS
	SELECT p.profno, p.name, d.dname
 	  FROM PROFESSOR p, DEPARTMENT d 
 	 WHERE p.deptno = d.deptno;

SELECT *
  FROM v_prof_dept2;

-- 2번 연습문제

SELECT * FROM student;

SELECT d.DNAME
	 , max(s.height) AS "MAX_HEIGHT"
	 , max(s.weight) AS "MAX_WEIGHT"
  FROM student s, DEPARTMENT d 
 WHERE s.DEPTNO1 = d.DEPTNO
 GROUP BY dname
 ORDER BY dname;


	SELECT max(height) AS "MAX_HEIGHT"
		 , max(weight) AS "MAX_WEIGHT"
	  FROM student
	 GROUP BY deptno1;
	 

SELECT * FROM stu_max;

SELECT d.DNAME, s.MAX_HEIGHT , s.MAX_WEIGHT
  FROM  (SELECT deptno1
  			  , max(height) AS "MAX_HEIGHT"
		 	  , max(weight) AS "MAX_WEIGHT"
	 	   FROM student
	 	  GROUP BY deptno1) s, DEPARTMENT d 
 WHERE s.DEPTNO1 = d.DEPTNO;



































