-- 데이터 사전(Data Dictionary)

-- 데이터를 구성하는 정보가 담겨 있는 데이터
-- 메타 데이터(Meta Data)
-- 사용자 정보, DB 객체(테이블, 인덱스, 뷰) 정보
-- 제약조건, 함수, 프로시저, 트리거 등

USE information_schema;

-- information_schema
-- 표준 스키마, 읽기 전용 테이블, DB 현재 상태 확인

SHOW tables;

-- 데이터베이스 내의 모든 테이블에 대한 정보를 저장한 테이블
-- information_schema.tables
SELECT * FROM information_schema.tables;

-- 특정 스키마(DB) 내부에 있는 테이블 정보 조회
-- DB이름, 테이블이름, DB엔진명, 데이터크기, 생성시간 등
SELECT TABLE_SCHEMA, TABLE_NAME, ENGINE,
	DATA_LENGTH, CREATE_TIME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'world';

-- columns
-- DB 내의 모든 컬럼에 대한 정보
SELECT * FROM information_schema.columns;

-- 특정 스키마, 특정 테이블의 컬럼 정보 조회
SELECT * 
FROM information_schema.columns
WHERE TABLE_SCHEMA = 'world' AND TABLE_NAME = 'city';

-- table_constraints : DB 내의 전체 테이블 제약조건에 대한 조회
SELECT * FROM information_schema.table_constraints;

-- 특정 스키마에 대한 제약조건 확인
SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM information_schema.table_constraints
WHERE TABLE_SCHEMA = 'world';

-- DB의 인덱스 정보 조회
SELECT * FROM information_schema.STATISTICS;

-- 특정 스키마의 인덱스 정보 조회
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME, SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'world';

-- 데이터베이스(스키마) 목록 조회
SELECT * FROM information_schema.SCHEMATA;

SELECT SCHEMA_NAME FROM information_schema.SCHEMATA;
SHOW databases;
show schemas;