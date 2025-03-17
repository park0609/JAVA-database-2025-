/*
 *  VIEW
 * */
-- sysdba로 실행해야함
GRANT CREATE VIEW TO sampleuser;


--
SELECT * FROM emp2;

-- 뷰 생성 DDL
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM emp2;

-- 뷰로 select
SELECT *
  FROM v_emp2;

-- 뷰로 insert
-- 단, 뷰에 속하지 않는 컬럼중 NOT NULL 조건이 있으면 데이터 삽입 불가
INSERT INTO v_emp2 VALUES (20000219, 'Tom Holand', 1004, '051)627-9832', 'IT Programmer',19960303);


-- not null인 deptno를 빼고 수정
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, tel, POSITION, pempno
	  FROM emp2;


-- deptno 컬럼이 not null인데 뷰에는 존재하지 않아서 INSERT 불가
INSERT INTO v_emp2 VALUES (20000219, 'Zen Daiya', '051)627-9832', 'IT Programmer',19960303);

COMMIT;


--CRUD 중 SELECT만 가능하게 할려면
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM emp2
WITH READ ONLY;

-- 삽입 불가
INSERT INTO v_emp2 VALUES (20000219, 'Holand', 1004, '051)627-9832', 'IT Programmer',19960303);

-- 복합 뷰. JOIN 등으로 여러 테이블을 합쳐서 보여주는 뷰
-- 복합 뷰는 INSERT, UPDATE, DELETE가 거의 불가
CREATE OR REPLACE VIEW V_emp3
AS
	SELECT e.empno, e.name, e.deptno, d.dname
	  FROM emp2 e, dept2 d
	 WHERE e.deptno = d.dcode;

-- 조회
SELECT * FROM v_emp3;
































































































