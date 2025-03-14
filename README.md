# JAVA-database-2025-
java 개발자 database 리포지토리

## 1일차
- Git hub Desktop 설치
    - https://desktop.github.com/download/ 다운로드
    - 기존 Github계정으로 signin with Browser 
    - Git 명령어 없이 사용가능
- DataBase(DB) 개요
    - 데이터를 저장하는 장소, 서비스를 하는 서버
    - DataBase를 관리하는 프로그램 : DBMS(DataBase Management Software)
    - 가장 유명한것이 Oracle
    - 사용자는 SQL로 요청, DB서버는 처리결과를 테이블로 결과를 리턴
    - SQL을 배우는 것이 목표
- Oracle 설치(Docker)
    1. powersheel 오픈
    2. docker search로 다운받고싶은 이미지 검색
    3. docker pull doctorkiri/oracle-19c 입력
        ```shell
        docker pull oracleinanutshell/oracle-xe-11g
        ```
    4. 다운로드 된 이미지 확인
        ```shell
        PS C:\Users\Admin> docker image ls
        ppsc                              1.3       c69e337855fc   24 hours ago   1.76GB
        oracleinanutshell/oracle-xe-11g   latest    8b740e77d4b9   6 years ago    2.79GB
        ```
    5. 도커 컨테이너 실행
        ```shell
        docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1521 오라클 기본 포트
        - 아이디 system / oracle
    6. 도커 실행확인
        -Docker Desktop > Containers 확인
    7. powershell 오픈
        ```shell
        > docker exec -it oracle11g bash
        [oracle@776635265b18 ~]$ sqlplus / as sysdba
        SQL>

        ```
    8. DBeaver 접속
        - Connection > select your DB > oracle 선택

        <img src="./image/db001.png" width = "650">
- DBeaver 툴 설치
    - https://dbeaver.io/download/
- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
        - 프로그래밍언어와 차이 - 어떻게(How)
        - SQL - 무엇(What)(데이터베이스)
        - 
    - SQL의 구성요소 3가지
    - DDL(Data Definition Lang) - 데이터베이스 생성, 테이블 생성, 그외 객체들을 생성 및 수정,삭제
        - `CREATE`, `ALTER`, `DROP` ...
    - DCL(Data Control Lang) - 사용자의 권한 부여, 해제, 트랜잭션 시작, 종료
        - `GRANT`, `REVOKE`, `BEGIN TRANS`, `COMMIT`, `ROLLBACK`
    - DML(Data Manupulation Lang) - 데이터 조작언어(핵심), 데이터 삽입 및 조회, 수정, 삭제
        - `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- SELECT 기본
    - 데이터 조회 시 사용하는 기본 명령어
        ```sql
        -- sql 기본주석(한줄 주석)
        /* 여러줄 주석
        여러줄로 주석 작성가능*/
        SELECT [ALL|DISTINCT] [*|컬럼명(들)]
          from 테이블 명(들)
        [where 검색조건(들)]
        [group by 속성명(들)]
        [having 집계함수조건(들)]
        [order by 정렬속성(들) asc|desc]
        [with rollup]
        ```
    - 기본 쿼리 학습 : [SQL](./Day_01/sql01_select(기본).sql)
        1. 기본 select
        2. where 조건절
        3. null(!)
        4. order by 정렬 
        5. 집합

- 함수(내장함수) [SQL](./Day_01/sql02_함수.sql)
    - 문자함수
    - 숫자함수

## 2일차
- 함수(계속)
    - 문자함수 부터 
    - 숫자함수
    - 날짜함수
    - 형변환 함수

- 데이터베이스 타입형
    - **CHAR(n)** - 고정형 문자열, 최대 2000바이트
        - char(20) "Hello World"를 입력하면 , "Hello World       '로 저장
        - CHAR는 고정형 문자열이기 때문에 지정된 바이트만큼 무조건 사용 만약 문자가 다쓰고도 바이트가 남으면 공백으로 처리
        - 기준코드나 반드시 자리수를 지켜야 하는 데이터에 필요함, 주민번호 등
    - **VARCHAR2(n)** - 가변형 문자열, 최대 4000바이트
        - varchar2(20) "Hello World"를 입력하면. "Hello World"로 저장
        - varchar2는 가변형이기 때문에 char와 다르게 바이트가 남아도 공백을 만들지않는다.
    - **number(p,s)** - 숫자값, p 전체자리수, s 소수점길이. 최대 22byte
    - integer - 모든 데이터의 기준, 4byte, 정수를 담는 데이터형
    - float(p) - 실수형 타입, 최대 22byte
    - **date** - 날짜타입
    - **long(n)** - 가변길이문자열, 최대 2GB
    - lobng raw(n) -  원시이진 데이터, 최대 2GB
    - clob - 대용량 텍스트 데이터타입, 최대 4GB
    - blob - 대용량 바이너리 데이터타입, 최대 4GB
    - bfile - 외부파일

- 함수(계속) [SQL](./Day_02/sql01_함수계속.sql)
    - 문자함수
    - 숫자함수
    - 날짜함수
    - 형변환 함수
- 복수행함수[SQL](./Day_02/sql02_복수형함수.sql)
    - 집계함수
    - GROUP BY
    - HAVING
    - ROLLUP
    - RANK, DENSE_RANK

## 3일차
- JOIN [SQL](./Day_03/sql03_Join.sql)
    - ERD(Entitiy Relationship Diagram) - 개체 관계 다이어그램
        - PK(Primary Key) - 기본 키 -> 중복이 안되고 빠진 데이터가 하나도 없다. UNIQE, NOT NULL이라고 함
        - FK(Foreign Key) - 외래 키 -> 다른 엔티티(테이블)의 PK. 두 엔티티의 관께를 연결
        - Relationship - 부모 엔티티와 자식 엔티티간의 연관, 부모 1, 자식 N을 가질 수 있음
    - 카테시안 곱 - 2개의 테이블에서 나올수있는 모든 경우의 수를 말함
        - 두 개 이상의 테이블의 조건과 관계없이 연결할 수 있는 경우의 수
        - 조인 이전에 데이터 확인 - 실무에서 카티션곱으로 데이터를 사용할 일이 절대! 없음
    - 내부조인 
        - 다중 테이블에서 보통 PK와 FK간의 일치하는 데이터를 한꺼번에 출력하기 위한 방법
        - 관계형 데이터베이스에서 필수로 사용해야 함
        - INNER JOIN 또는 오라클 간결문법 사용
    - 외부조인
        - PK와 FK간의 일치하지 않는 데이터도 출력하고자 할때 사용하는 방법
        - LEFT OUTER JOIN, RIGHT OUTER JOIN 또는 오라클 간결문법 사용
- DDL[SQL](./Day_03/sql04_DDL.sql)
    - CREATE - table, view, procedure, function
        - 타입형
        ```sql 
        create table 테이블명(
            첫번째_컬럼 타입형 제약조건,
            두번째_컬럼 타입형 제약조건,
            ...
            마지막_컬럼 타입형 제약조건
            [,
            기본키, 외래키 등의 옵션
            ]
        )
        ``` 
    - ALTER - 개체 중 테이블에서 수정이 필요할 때 사용하는 키워드
        ```sql
        ALTER TABLE 테이블 명 ADD (컬럼명 타입형 제약조건);
        ALTER TABLE 테이블 명 MODIFY (컬럼명 타입형 제약조건);
        ```
    - DROP - 개체 삭제시 사용하는 키워드
        ```sql
        DROP TABLE 테이블명 PUEGE; -- Purge는 - 휴지통
        ```
    - TRUNCATE - 테이블 완전 초기화 키워드
        ```sql
        TRUNCATE TABLE 테이블명;
        ```
## 4일차
- VS Code DB플러그인
    - 확장 -> database검색 -> database  cilent -> 확장중 database 선택

    <img src = "./image/db0002.png"  width = "650">
- DML
    - INSERT - 테이블에 새로운 데이터를 삽입하는 명령
        - 한 건씩 삽입
        ```sql
        insert into 테이블명[(컬럼리스트)]
        values (값리스트);
        ```
        - 여러건 한꺼번에 삽입
    - UPDATE - 데이터 변경, where 조건 없이 실행하면 테이블 모든 데이터가 수정됨(주의요망!)
        ```sql
        update 테이블명 set
            컬럼명 = 변경할 값,
            [컬럼명 = 변경할 값] -- 반복
        [where 조건]
        ```
    - DELETE - 데이터 삭제, where 조건 없이 실행하면 테이블 모든 데이터가 삭제됨(주의요망!)
        ```sql
        delete from 테이블명
        [where 조건]
        ```
- 트랜잭션
    - 논리적인 처리단위
    - 은행에서 돈을 찾을 때 아주 많은 테이블에 접근해서 일을 처리
        - 적어도 일곱여덟개 이상의 테이블 접근해서 조회하고 업데이트 수행
        - 제대로 일이 처리안되면 다시 원상복귀
        ```sql
        begin transaction; -- 트랜잭션 시작
        commit; -- 트랜잭션 확정
        rollback; -- 원상복귀
        ```
- 제약조건(constraint)
    - 잘못된 데이터가 들어가지 않도록 막는 기법
        - PK - 기본키, UNIQUE NOT NULL, 중복되지 않고 없어도 안됨
        - FK - 외래키, 다른테이블 pk에 없는 값을 가져다 쓸 수 없음
        - NOT NULL - 값이 빠지면 안됨
        - UNIQUE - 들어간 데이터가 중복되면 안됨
        - CHECK - 기준에 부합하지 않는 데이터는 입력되면 안됨
- INDEX
- VIEW
- 서브쿼리
- 시퀀스