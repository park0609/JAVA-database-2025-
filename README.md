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
    2. docker pull doctorkiri/oracle-19c 입력
        ```shell
        docker pull oracleinanutshell/oracle-xe-11g
        ```
    3. 다운로드 된 이미지 확인
        ```shell
        PS C:\Users\Admin> docker image ls
        ppsc                              1.3       c69e337855fc   24 hours ago   1.76GB
        oracleinanutshell/oracle-xe-11g   latest    8b740e77d4b9   6 years ago    2.79GB
        ```
    4. 도커 컨테이너 실행
        ```shell
        docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1521 오라클 기본 포트
        - 아이디 system / oracle
    5. 도커 실행확인
        -Docker Desktop > Containers 확인
    6. powershell 오픈
        ```shell
        > docker exec -it oracle11g bash
        [oracle@776635265b18 ~]$ sqlplus / as sysdba
        SQL>

        ```
    7. DBeaver 접속
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
        - CREATE, ALTER, DROP ...
    - DCL(Data Control Lang) - 사용자의 권한 부여, 해제, 트랜잭션 시작, 종료
        - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
    - DML(Data Manupulation Lang) - 데이터 조작언어(핵심), 데이터 삽입 및 조회, 수정, 삭제
        - INSERT, SELECT, UPDATE, DELETE
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
    - 기본 쿼리 학습 : [SQL](./Day01/sql01_select기본.sql)
        1. 기본 select
        2. where 조건절
        3. null(!)
        4. order by 정렬 
        5. 집합
## 2일차