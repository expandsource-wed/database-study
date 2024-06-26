-- 뷰
/*
  View : 실제 데이터를 저장하지 않고, 기본 테이블의 쿼리 결과를 기반으로 생성되는 가상의 테이블 
*/
USE sqldb;

SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 뷰 생성
CREATE VIEW view_user AS
 SELECT userId, name FROM usertbl;

-- 뷰 조회
SELECT * FROM view_user;	-- 테이블처럼 조회 가능
DESC view_user;             -- 테이블처럼 구조 확인 가능
DESC usertbl;
-- 실제 (물리적) 테이블에서는 기본키 제약조건이 존재하지만
-- 가상 (논리적) 테이블에서는 기본키 제약조건이 존재하지 않음.
-- 컬럼명, 타입 동일

-- 가상 테이블과 실제 테이블이 조건이 동일할 경우에만 삽입 가능
INSERT INTO view_user VALUES ('ABC', '에비씨');

-- 제약조건이 일치할 경우 DML 수행됨 -> 실제테이블에 반영
UPDATE view_user SET name = '바비킹'
 WHERE userId = 'BBK';
 
SELECT * FROM view_user;	-- 뷰
SELECT * FROM usertbl;	    -- 물리적 테이블

-- 뷰 생성 시 내장함수, 컬럼명 변경, 조인 가능
CREATE VIEW view_user_buy AS
	SELECT u.userid '아이디', 
		   u.name '이름',
           b.prodName '상품명',
           u.addr '주소',
           concat(u.mobile1, '-', u.mobile2) '전화번호'
    FROM usertbl u
    INNER JOIN buytbl b ON u.userId = b.userId;
    
SELECT * FROM view_user_buy;
DESC view_user_buy;
-- 뷰로 생성된 가상 테이블(쿼리 결과)는 실제 테이블처럼 사용 가능

SELECT 아이디, 이름 FROM view_user_buy;

-- CREATE OR REPLACE VIEW
-- 기존의 동일한 이름의 뷰가 있다면 에러 대신 덮어쓰기
CREATE OR REPLACE VIEW view_user_buy AS
	SELECT u.userid '아이디', 
		   u.name '이름',
           b.prodName '제품명',
           u.addr '지역',
           concat(u.mobile1, '-', u.mobile2) '전화번호'
    FROM usertbl u
    INNER JOIN buytbl b ON u.userId = b.userId;
    
DESC view_user_buy;

-- 뷰 목록 조회하기
SHOW TABLES;	-- 물리적 테이블과 가상 테이블 구분 안됨
SHOW FULL TABLES;  -- 테이블의 타입이 같이 조회

-- 뷰만 조회하기
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 데이터 사전에서 뷰 조회하기
SELECT * FROM information_schema.views;
-- 데이터 사전에서 특정 DB의 뷰 목록만 조회하기
SELECT * FROM information_schema.views
 WHERE table_schema = 'sqldb';

-- 뷰 삭제하기
DROP VIEW view_user_buy;

/*
 뷰 사용의 장점
 1. 데이터 보안 강화 : 사용자가 실제 테이블에 접근하지 못하게 하여 민감한 정보 노출을 방지
 2. 데이터 접근 단순화 : 여러 테이블을 조인하거나 복잡한 셀렉트문의 결과를 반복적으로 사용해야 할 경우
 3. 쿼리 재사용 : 한번 정의된 뷰는 다른 쿼리에서 재사용 가능
*/