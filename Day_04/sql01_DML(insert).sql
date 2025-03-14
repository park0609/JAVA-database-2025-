/*
 * DML중 SELECT 이외
 * INSERT, UPDATE, DELETE
 * */

-- INSERT
SELECT * FROM NEW_TABLE;

-- INSERT QUERY 기본
INSERT INTO NEW_TABLE (NO, name, jumin, birth, salary)
values(1, '홍길동', '810205-1654387', '1981-02-05', 5000);

-- 테이블 컬럼리스트와 동일한 순서, 동일한 값을 넣을때
-- 단, 컬럼리스트와 순서도 다르고 , 값리스트 개수도 다르면 컬럼리스트 생략 불가!
INSERT INTO NEW_TABLE 
values(2, '홍길순', '830205-2654387', '1983-02-05', 4000);

-- 컬럼리스트 순서와 갯수가 다를때는 반드시 컬럼을 적은대로 작성해야함
INSERT INTO NEW_TABLE (jumin, name, no)
values('920205-1654387', '냉장고', 3);

-- 값이 먼지 모를때는  NULL로 삽입 
INSERT INTO NEW_TABLE 
values(4, '홍길', '980205-2654387', NULL, null);


-- 한 테이블에 있는 데이터를 모두 옮기면서 새로운 테이블 생성
-- pk는 복사가 안됨!
CREATE TABLE professor_new
AS
SELECT * FROM professor;

SELECT * FROM professor;

-- 만들어진 테이블에 데이터 한꺼번에 옮기기
INSERT INTO professor_new
SELECT * FROM professor;

-- 새로 만들어진 테이블 professor_new 데이터를 삽입 테스트
INSERT INTO professor_new(profno, name, id, POSITION, pay, hiredate)
VALUES (4000, 'Tom Cruise', 'Cruise', 'instructor', 300, '2025-03-14');

-- professor_new는 PK가 없기 때문에 같은 값이 들어감
INSERT INTO professor_new(profno, name, id, POSITION, pay, hiredate)
VALUES (4000, 'Tom Holland', 'Holland', 'instructor', 310, '2025-03-14');

-- 대량의 데이터를 삽입
INSERT ALL 
	INTO NEW_TABLE  VALUES (5, '세탁기', '810205-1654387', '1981-02-05', 5000)
	INTO NEW_TABLE  VALUES (6, '세탁', '810205-1654387', '1981-02-05', 5000)
	INTO NEW_TABLE  VALUES (7, '탁기', '810205-1654387', '1981-02-05', 5000)
	INTO NEW_TABLE  VALUES (8, '세기', '810205-1654387', '1981-02-05', 5000)
	INTO NEW_TABLE  VALUES (9, '세', '810205-1654387', '1981-02-05', 5000)
	INTO NEW_TABLE  VALUES (10, '기', '810205-1654387', '1981-02-05', 5000)
SELECT * FROM dual;

SELECT * FROM new_table;










