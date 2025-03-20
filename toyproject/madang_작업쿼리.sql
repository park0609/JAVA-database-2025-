-- madang 로그인

SELECT * FROM students;

-- 더미데이터 삽입

INSERT INTO STUDENTS
VALUES (SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1987);
INSERT INTO STUDENTS
VALUES (SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 1997);

COMMIT;

CREATE SEQUENCE seq_student
	INCREMENT BY 1
	START WITH 1;

INSERT INTO MADANG.STUDENTS
(std_id, std_name, std_mobile, std_regyear)
VALUES(seq_STUDENT.nextval, :v_std_name, :v_std_mobile, :v_std_regyear);