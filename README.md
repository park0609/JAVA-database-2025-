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

        <img src="./image/db001.png" width = "650>
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

- 함수(내장함수) [SQL](./Day_01/sql02_select(기본).sql)
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
- JOIN
    - 카티션곱
    - 내부조인, 외부조인
- DDL
    - CREATE, 