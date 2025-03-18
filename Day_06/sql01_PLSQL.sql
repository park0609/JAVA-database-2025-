/*
 * PL/SQL -
 * */
-- set serveroutput on; --콘솔에서만 사용가능

DECLARE -- 선언부. 여기에 사용할 모든 변수를 선언해야함
	v_empno		 emp.empno%TYPE; -- NUMBER(4,0);을 대처해서 특정테이블의 컬럼과 같은 데이터타입을 쓰겠다고 선언
	v_ename 	 varchar2(10); -- emp.ename%TYPE; 와 동일타입
BEGIN --  PL/SQL은 시작부분과 끝부분을 지정해줘야 한다
	SELECT empno, ename INTO v_empno, v_ename
      FROM emp
 	 WHERE empno = :empno; 
	-- DBEAVER 때문에 :empno로 변경	
	
	-- 정상실행되면

	DBMS_OUTPUT.PUT_LINE(v_empno || '- 이 멤버의 이름은 ' || v_ename);
EXCEPTION -- 예외처리 부분
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('멤버가 없음');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('데이터가 너무 많음');
END; --PL/SQL 끝부분
/

COMMIT;

