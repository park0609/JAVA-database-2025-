/*
 * DDL - 데이터 조작언어
 * CREATE, ALTER, DROP, TRUNCATE
 * 객체를 생성하고, 수정하고, 삭제하고, 데이터를 초기화...
 *  */

-- no, name, birth 컬럼의 테이블 new_table을 생성하시오
-- create table new_table ();
CREATE TABLE NEW_TABLE(
	NO 		NUMBER(5,0) PRIMARY KEY, -- 5,0이라는 소리는 0단위를 말한다. 해석하면 10000까지 쓰겠다.
	name 	varchar2(20) NOT NULL,
	jumin	char(14),
	birth	DATE 
);

DROP TABLE new_table;

-- 기본값을 설정하면서 테이블 생성
CREATE TABLE NEW_TABLE(
	NO 		NUMBER(5,0) PRIMARY KEY, 
	name 	varchar2(20) NOT NULL,
	jumin	char(14),
	birth	DATE,
	salary  number(7,0) DEFAULT 0 -- 아무값도 넣지않고 INSERT하면 null은 0으로 대체
);

-- 테이블 컬럼에 주석 추가
COMMENT ON COLUMN new_table.name IS '사원이름'

-- 기본키가 두개인 테이블 생성
CREATE TABLE doublekeytbl(
	ID	    NUMBER(5,0),
	code	CHAR(4),
	NAME	VARCHAR(20) NOT NULL,
	JUMIN	CHAR(14) UNIQUE,
	CONSTRAINT pk_doublekeytbl PRIMARY KEY(ID, CODE)
);

-- new_number 부모테이블과 new_board 자식 테이블간의 관계가 성립된 테이블을 생성하시오
CREATE TABLE new_mumber(
	idx NUMBER PRIMARY KEY,
	name varchar2(20) NOT NULL,
	id	varchar2(20) NOT NULL,
	pwd varchar2(256) NOT null
);

-- new_board는 new_nember의 pk idx를 외래키로 사용
CREATE TABLE new_board(
	bidx	 NUMBER PRIMARY KEY,
	title 	varchar2(125) NOT NULL,
	content 	LONG NOT NULL,
	reg_date 	DATE DEFAULT sysdate,
	count	NUMBER(6,0) DEFAULT 0,
	midx NUMBER NOT NULL,
	CONSTRAINT FK_nemberidx FOREIGN KEY (midx) REFERENCES new_mumber (idx)
);


-- ALTER 기존 테이블을 수정할 때 사용
ALTER TABLE new_table ADD (adress varchar2(200));

-- ALTER 기존 테이블에 전화번호 컬럼 추가
-- 이미 데이터가 존재하는 테이블에 not null 컬럼은 추가 불가
ALTER TABLE new_table ADD (tel varchar2(20));

-- 컬럼 수정 varchar2(200) -> 100으로 수정
ALTER TABLE new_table MODIFY (adress varchar2(100));

-- DROP 테이블 삭제
DROP TABLE new_table purge;

-- TRUNCATE 테이블 초기화
-- ID(자동으로 증가하는 형태) 1,2,3,4,5
TRUNCATE TABLE new_table;

