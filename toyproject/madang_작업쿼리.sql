-- madang 로그인

SELECT * FROM students;

-- 더미데이터 삽입

INSERT INTO STUDENTS
VALUES (SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1987);
INSERT INTO STUDENTS
VALUES (SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 1997);

COMMIT;
