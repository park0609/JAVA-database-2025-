-- 1번
SELECT email
	 , MEMBERTBL.MOBILE 
	 , MEMBERTBL.NAMES 
	 , MEMBERTBL.ADDR 
  FROM membertbl;

-- 2번
SELECT BOOKSTBL.NAMES AS "도서명"
	 , BOOKSTBL.AUTHOR AS "저자"
	 , BOOKSTBL.ISBN 
	 , BOOKSTBL.PRICE AS "정가" 
  FROM BOOKSTBL
 ORDER BY isbn;

-- 3번
SELECT r.MEMBERIDX
  FROM membertbl m, (SELECT DISTINCT memberIDX 
 					   FROM RENTALTBL
 				   ORDER BY memberIDX) r
 WHERE m.idx = r.MEMBERIDX 
 ORDER BY r.memberidx;

SELECT DISTINCT memberIDX 
  FROM RENTALTBL
 ORDER BY memberIDX;
  
-- 4번
SELECT d.names
	 , sum(b.price)
  FROM BOOKSTBL b, DIVTBL d
 WHERE b.DIVISION = d.DIVISION
 GROUP BY ROLLUP(d.names, b.price)
 ORDER BY d.names;

SELECT d.NAMES
     , to_char(b."pri",'9,999,999') || '원' AS "총합계금액"
  FROM DIVTBL d
 INNER JOIN (SELECT division
	 			  , sum(price) AS "pri"
 			   FROM BOOKSTBL
		   GROUP BY division) b
    ON  b.DIVISION = d.division
 ORDER BY d.names;

 GROUP BY rollup(d.names,b."pri")

COMMIT;