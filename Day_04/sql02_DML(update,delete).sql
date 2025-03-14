/*
 * update/delete
 * 데이터 변경/데이터 삭제
 * */
-- 삭제
SELECT count(*) FROM PROFESSOR_new; 

DELETE FROM PROFESSOR_NEW 
 WHERE profno = 1001;

-- 삭제시 where절 빼는 것은 극히 주의!
DELETE FROM PROFESSOR_NEW; --  TRUNCATE와 동일하나 테이블 초기화는 없음


SELECT * FROM PROFESSOR_NEW;
-- 변경
-- profno 4002번인 수잔 서랜든의 아이디를 기존 shrandon에서 susans으로, 급여를 330에서 350으로 변경
UPDATE PROFESSOR_NEW SET
       ID = 'SusanS'
     , PAY =  350;
 WHERE profno = 4002;

ROLLBACK; -- 원상복귀, 트랜잭션은 종료안됨
COMMIT; -- 확정짓고 트랜잭션이 종료!