-- empno에 해당하는 사원의 급여를 10프로 인상하는 프로시저 저장
SELECT * FROM emp WHERE empno = 7900;

CREATE OR REPLACE PROCEDURE up_sal
(
	v_empno			emp.empno%TYPE
)
IS
	cnt_emp 		NUMBER(1,0);			
BEGIN
	SELECT count(*) INTO cnt_emp
	  FROM emp
	 WHERE empno = v_empno;
	IF cnt_emp > 0 THEN
		DBMS_OUTPUT.PUT_LINE('업데이트 하면됨');
		UPDATE emp SET
			   sal = sal + (sal * 0.1);
		 WHERE empno = v_empno;
		DBMS_OUTPUT.PUT_LINE('업데이트 완료!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('데이터 없음');
	END IF;
END;
/

-- 프로시저 실행
CALL up_sal(7900);