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
    - 기본 쿼리 학습 : [기본](./Day_01/sql01_select(기본).sql)
        1. 기본 select
        2. where 조건절
        3. null(!)
        4. order by 정렬 
        5. 집합

- 함수(내장함수) : [함수](./Day_01/sql02_함수.sql)
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

- 함수(계속) : [함수계속](./Day_02/sql01_함수계속.sql)
    - 문자함수
    - 숫자함수
    - 날짜함수
    - 형변환 함수
- 복수행함수 : [복수행함수](./Day_02/sql02_복수형함수.sql)
    - 집계함수
    - GROUP BY
    - HAVING
    - ROLLUP
    - RANK, DENSE_RANK

## 3일차
- JOIN : [JOIN](./Day_03/sql03_Join.sql)
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
- DDL : [DDL](./Day_03/sql04_DDL.sql)
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

    <img src = "./image/db002.png"  width = "650">
- DML : [INSERT](./Day_04/sql01_DML(insert).sql), [UPDATE, DELETE](./Day_04/sql02_DML(update,delete).sql)
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

- 트랜잭션 : [트랜잭션](./Day_04/sql03_DML(transaction).sql)
    - 논리적인 처리단위
    - 은행에서 돈을 찾을 때 아주 많은 테이블에 접근해서 일을 처리
        - 적어도 일곱여덟개 이상의 테이블 접근해서 조회하고 업데이트 수행
        - 제대로 일이 처리안되면 다시 원상복귀
        - DB 설정 AUTO COMMIT 해제 권한
        - ROLLBACK은 트랜잭션 종료 X COMMIT을 해야 종료
        ```sql
        set transaction read write; -- 트랜잭션 시작(옵션)
        commit; -- 트랜잭션 확정
        rollback; -- 원상복귀
        ```

- 제약조건(constraint) : [제약조건](./Day_04/sql04_제약조건.sql)
    - 잘못된 데이터가 들어가지 않도록 막는 기법
        - PK - 기본키, UNIQUE NOT NULL, 중복되지 않고 없어도 안됨
        - FK - 외래키, 다른테이블 pk에 없는 값을 가져다 쓸 수 없음
        - NOT NULL - 값이 빠지면 안됨
        - UNIQUE - 들어간 데이터가 중복되면 안됨
        - CHECK - 기준에 부합하지 않는 데이터는 입력되면 안됨
        - DEFAULT - null입력시 기본값이 입력되도록 하는 제약 조건
        ```sql
        create table 테이블명(
            컬럼 생성시 제약조건 추가
        );

        alter table 테이블명 add constraint 제약조건
        ```

- INDEX : [인덱스](./Day_04/sql05_INDEX.sql), [인덱스용테이블생성](./ref/bulk_data_insert.sql)
    - 책의 찾아보기와 동일한 기능
    - 검색을 매우 빨리 할 수 있도록 해줌
    - B(alanced) Tree를 사용해서 검색횟수를 반이하로 줄임
    - 인덱스 종류
        - 클러스터드(Clustered) 인덱스 (테이블당 한개)
            - PK가 자동으로 생성되는 인덱스(무지 빠름)
            - PK가 없으면 처음으로 설정되는 UNIQUE 제약조건의 컬럼에 생성
        - 보조 인덱스(Non-Clustered) (테이블당 여러개)
            - 사용자가 추가하는 인덱스
            - 클러스터드 인덱스보다 조금 느림
    - 유의점
        - PK에 자동 인덱스 후 컬럼에 UNIQUE을 걸어도 인덱스가 생성안됨. 수동으로 생성 필요
        - WHERE절에서 검색하는 컬럼은 인덱스를 걸어주는 것이 성능향상에 도움
        - 인덱스는 한 테이블당 4개이상 걸면 성능 저하
        - NULL 값, 중복값이 많은 컬럼에 인덱스는 성능 저하
        - INSERT, UPDATE, DELETE가 많이 발생하는 테이블에 인덱스를 걸면 성능 저하

        ```sql
        create index 인덱스명 on 테이블명(인덱스 걸 컬럼명)
        ```

## 5일차
- VIEW : [VIEW](./Day_05/sql01_VIEW.sql)
    - 기존 테이블에서 권한별로 보일수 있는 컬럼을 지정해서 만드는 개체(보안 목적)
    - 기존 테이블 중 개인정보나 중요한 부분이 있으면 제외하고 보일 수 있음
    - 뷰라도 INSERT, UPDATE, DELETE가 가능함. 단, 단일뷰에서만 가능
    ```sql
    create VIEW 뷰명
    AS
        SELECT
    [WITH READ ONLY] -- 읽기 전용
    ```
    - 복합 뷰는 두개이상의 테이블을 JOIN해서 만든뷰. DML기능 불가

- 서브쿼리 : [서브쿼리](./Day_05/sql02_서브쿼리.sql)
    - 메인 쿼리를 도와주는 하위쿼리 뜻함. 소괄호() 내에 포함됨
    - 단일행 서브쿼리, 다중행 서브쿼리마다 사용법 다름
    - SELECT절 서브쿼리, FROM절 서브쿼리, WHERE절 서브 쿼리
    - 서브쿼리는 JOIN으로 변경가능

- 시퀀스 : [시퀀스](./Day_05/sql03_시퀀스.sql)
    - 번호로 지정된 PK값을 자동으로 삽입할 수 있도록 도와주는 기능
    - 없어도 기능에는 차이가 없지만 효율을 위해 사용하는 경우가 많음
    - Oracle에만 존재. 타 DB보다 자동증가값 사용 불편
    ```sql
    create sequence 시퀀스명
    incremant by 1 -- 증가값
    start with 1 -- 초기 시작값
    [MAXVALUE 999999] -- 최대증가값
    [CYCLE] -- 최대증가값에 도달하면 다시 처음 1로 돌아올것인지
    [cache] -- 번호증가 캐쉬. 대용량 삽입시만 관계 O
    
    시퀀스명.NEXTVAL
    시퀀스명.CURRVAL
    ```

- 사용자 계정 권한 : [권한](./Day_05/sql05_권한.sql)
    - 사용자 생성 후 권한(롤)을 부여해야 스키마를 사용가능

        ```sql
        -- 권한부여
        GRANT 권한 | 롤 TO 사용자[WITH ADMIN|GRANT OPTION]
        -- 권한해제
        REVOKE 권한 | 롤 FROM 사용자
        ```

## 6일차
- PL/SQL - Oracle에서 파이썬처럼 코딩
    - 오라클에서 프로그래밍을 하기위한 언어
    - 기본구조
        - 선언부(DECLAER), 실행부(BEGIN~END), 예외처리부(EXCEPTION)
    - Oracle 스키마 중 Packages, Procedures, Functions 이 PL/SQL로 작업하는 영역
        - 저장된(Stored) PL/SQL
    - 결과하면에 출력하려면 명령어를 실행하고 PL/SQL을 수행해야함
        ```sql
        set serveroutput on; -- 화면 출력기능 활성화
        show errors; -- 오류 상세내용 보기
        ```

- Stored Procedure와 Function을 만들기 위해서 사용
    - 저장프로시저
        - 한꺼번에 많은 일을 수행해야할 때(Transaction당 수행되는 로직들 묶어서)
        - 예) 한번에 5개의 테이블에서 조회와 DML을 처리해야한다
            - 쿼리를 최소 10개를 수행해야 함
            - 프로시저 한번만 수행해서 해결할 수 있음
        - 중.대형 IT솔루션 등에서는 프로시저가 거의 필수
        ```sql
        create or replace procedure 프로시저명
        (
            param1 datatype1,
            param2 datatype2,
            ...
        )
        IS | AS
        PL/SQL Block;
        /
        ```

        - 실행시 EXEC 사용
        ```sql
        call 프로시저명(파라미터);
        exec 프로시저명(파라미터); -- 현재 DBeaver에서 사용 불가
        ```
    - 함수
        - 스칼라값을 리턴할 때 - Select절 서브쿼리와 기능 동일
        - 개발자에게 편의성을 제공하기 위해 만듬
        ```sql
        create or replace 함수명
        (
            param1 datatype
            ...
        )
        return datatype
        IS | AS
        PL/SQL Block
        ```
        - 실행시 select문, DML등과 같이 사용
        ```sql
        select * 함수명(파라미터)
          from 컬럼명;
        ```
    - 커서
        - DB에서 테이블에 들어있는 데이터를 한줄씩 읽기 위해서 필요
        ```sql
        cursor 커서명 IS
            select쿼리;
        ```

    - 트리거
        - 특정 동작으로 다른 테이블에 자동으로 데이터가 변경되는 기능
        - 한가지 동작에 대해서 연쇠적으로 다른일 발생
        ```sql
        create ot replace trigger 트리거명
        before|after insert|update|delete on 테이블[뷰] 이름
        begin
            PL/SQL쿼리
        END;
        ```

## 7일차
- oracle 연동 python GUI 프로그램 개발
    - [오라클연동](./toyproject/README.md)

    