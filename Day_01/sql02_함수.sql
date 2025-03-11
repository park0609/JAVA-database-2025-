/*내장함수
 * */


/* 문자(열) 함수*/

--initcap() 단어의 첫글자를 대문자로
SELECT initcap('hello oracle') AS "result"
  FROM dual; -- dual은 실제하지 않는 테이블
  
-- lower - 모든글자를 소문자로 / upper - 모든글자를 대문자로

SELECT lower(first_name) AS "fitst_name" -- 얘네들은 컬럼안에 값을 바꾸는것이 아니기 때문에 컬럼 명이 함수이름으로 바꿔지는 거다 그래서 항상 as로 이름을 변경해줘야함
 	 , upper(last_name) AS "LAST_NAME"
 	 , first_name AS "orginal_first_name" 
FROM employees;
  

-- length() / lengthb() 함수
-- length는 단순 단어의 길이를 뜻하지만 lengthb는 그 문자자체의 byte값을 구한다
SELECT LENGTH('hello oracle') -- 영어 12
	 , LENGTHB('hello oracle') -- 영어 12byte
	 , LENGTH('반가워요 오라클') -- 한글 8
	 , lengthb('반가워요 오라클') -- 한글 22byte -> 한글은 1개 3byte 7개여서 21byte에 공백 1byte
	 , ascii('A') -- 아스키 코드 변환 A = 22
	 , ASCII('a')
	 , ASCII('가')
  FROM dual;

-- concat() == ||와 동일 기능
SELECT concat(concat(first_name, ' '), last_name) AS "full_name"
  FROM employees;