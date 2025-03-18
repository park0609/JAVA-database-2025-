CREATE OR REPLACE FUNCTION SAMPLEUSER.GET_DNAME(
	v_deptno 	emp2.deptno%TYPE
) RETURN varchar2
IS
	deptname 	dept2.dname%TYPE;
BEGIN
	 SELECT dname INTO deptname
	   FROM dept2 WHERE dcode = v_deptno;

	RETURN deptname; --빼먹으면 안됨
END GET_DNAME;
