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
        PS C:\Users\Admin> docker pull doctorkirk/oracle-19c
        Using default tag: latest
        latest: Pulling from doctorkirk/oracle-19c  
        30ed1731acd1: Download complete
        1afbeedfc34a: Downloading [======>                                            ]  619.7MB/5.027GB
        e8b1c0b24c00: Download complete
        29415c7d058f: Download complete
        8bfefd996a95: Download complete
        198bff5413e1: Download complete
        ```
    3. 다운로드 된 이미지 확인
        ```shell
        PS C:\Users\Admin> docker image ls
        REPOSITORY              TAG       IMAGE ID       CREATED        SIZE
        ppsc                    1.3       c69e337855fc   22 hours ago   1.76GB
        doctorkirk/oracle-19c   latest    5816fe124f2a   3 years ago    16.8GB
        ```
    4. 도커 컨테이너 실행
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

## 2일차