/*
 * 제약조건. 잘못된 데이터가 들어가지 않도록 막는 기능
 * */
-- 제약조건 다섯가지 모두 사용한 테이블 생성 쿼리

CREATE TABLE new_emp(
	idx NUMBER PRIMARY KEY,
	name varchar2(20) NOT NULL,
	jumin varchar2(14) NOT NULL UNIQUE,
	loc_code  number(1) CHECK (loc_code > 0 AND loc_code < 5), -- loc_code에 들어가는 수는 1,2,3,4로 제약둠
	dcode varchar2(6) REFERENCES dept2(dcode) 
);

ALTER TABLE new_emp
  ADD CONSTRAINT uk_name unique(name);

ALTER TABLE new_emp
  MODIFY (loc_code CONSTRAINT ck_loc_code CHECK (loc_code > 0 AND loc_code < 7));

-- 필요없는 제약조건 삭제
ALTER TABLE new_emp DROP CONSTRAINT "SYS_C007113";