-- 인덱스
DROP SCHEMA IF EXISTS index_db;
CREATE SCHEMA IF NOT EXISTS index_db;
use index_db;

/*
 인덱스 
 - 데이터베이스의 검색 성능을 향상시키기 위해 사용하는 자료 구조
 - 책의 목차와 유사하게 특정 데이터를 빠르게 찾을 수 있게 도와줌
 - B-Tree 자료구조를 사용하여 효율적으로 인덱스 검색, 삽입, 삭제
*/

-- 테이블을 생성할 때 자동으로 생성되는 인덱스
CREATE TABLE tbl1 (
	id INT PRIMARY KEY,
    column_a INT,
    column_b INT
);

-- 인덱스 확인
SHOW INDEX FROM tbl1;
-- 기본 키 제약조건을 지정할 경우 자동으로 PRIMARY 인덱스가 생성


CREATE TABLE tbl2 (
	id INT PRIMARY KEY,
    column_a INT UNIQUE,
    column_b INT UNIQUE,
    column_c INT
);

SHOW INDEX FROM tbl2;
-- Unique 제약조건 : 한 테이블의 여러개의 인덱스(컬럼명)가 자동 생성

CREATE TABLE tbl3 (
	id INT PRIMARY KEY,
    column_a INT,
    column_b INT,
    tbl2_id INT,
    FOREIGN KEY (tbl2_id) REFERENCES tbl2(id)
);

SHOW INDEX FROM tbl3;
-- 다른 테이블을 참조하는 외래키 제약조건도 자동으로 인덱스 생성

-- 직접 인덱스 생성하기
CREATE INDEX idx_column_b ON tbl3(column_b); -- column_b를 기준으로 인덱스 생성
SHOW INDEX FROM tbl3;						 -- 생성된 인덱스 확인

-- 복합 인덱스 생성
CREATE INDEX idx_a_b ON tbl3(column_a, column_b); -- 두 개 이상의 열을 기준으로 인덱스 생성
SHOW INDEX FROM tbl3;

-- 인덱스 삭제하기
DROP INDEX idx_a_b ON tbl3;
SHOW INDEX FROM tbl3;
