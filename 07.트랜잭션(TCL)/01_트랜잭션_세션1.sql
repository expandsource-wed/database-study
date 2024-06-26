-- 01_트랜잭션_세션1.sql
/*
- 트랜잭션 : DBMS에서 데이터를 다루는 논리적 작업 단위

- 동시다발적으로 발생하는 다수의 작업을 안전하고, 독립적으로 처리하기 위한 단위
- 트랜잭션 내의 연산은 모두 성공하거나 모두 실패 해야 함. (All or Nothing)

- 트랜잭션의 성질 (ACID)
  1. 원자성(Atomicity) : 더 이상 쪼개지지 않는 하나의 단위. (All or Nothing)
  2. 일관성(Consistency) : 트랜잭션 완료되면 DB는 일관된 상태를 유지 (무결성)
  3. 고립성(Isolation) : 각 트랜잭션은 다른 트랜잭션에 영향을 주지 않고 독립적으로 수행
  4. 지속성(Durability) : 트랜잭션이 완료되면 결과가 영구적으로 반영.
  
- 트랜잭션 제어 언어 (TCL)
	- START TRANSACTION : 트랜잭션의 시작을 알림.
    - COMMIT : 트랜잭션 내 모든 연산을 확정. 변경사항 영구 반영.
    - ROLLBACK : 트랜잭션 내 모든 연산을 취소. 이전상태로 복구.
    - SAVEPOINT : 트랜잭션 내 특정 중간지점을 설정.
    - ROLLBACK TO SAVEPOINT : 설정한 지점으로 롤백(복구)
*/

DROP SCHEMA IF EXISTS tcl_db;
CREATE SCHEMA tcl_db;
USE tcl_db;

-- 테이블 생성
CREATE TABLE accounts (
	id INT AUTO_INCREMENT PRIMARY KEY,  -- 계좌 ID
    name VARCHAR(255) NOT NULL,         -- 이름
    balance BIGINT NOT NULL DEFAULT 0   -- 잔고
);

-- 데이터 삽입
INSERT INTO accounts (name, balance)
 VALUES ('홍길동', 100000), ('전우치', 200000);

-- 데이터 확인
SELECT * FROM accounts;

-- 은행 계좌 거래 트랜잭션 시작
START TRANSACTION;

-- 1. 인출 (홍길동 -5만원)
UPDATE accounts SET balance = balance - 50000
 WHERE name = '홍길동';
 
SELECT * FROM accounts;		-- 커밋이 이루어지지 않은 부분 완료 상태 (홍길동 -5만원)

-- 2. 입금 (전우치 +5만원)
UPDATE accounts SET balance = balance + 50000
 WHERE name = '전우치';
 
SELECT * FROM accounts;

-- 모든 변경사항을 확정 (트랜잭션 종료)
COMMIT; 

SELECT * FROM accounts;

-- 트랜잭션이 시작되고, 커밋이 완료가 되지 않은 상태에서
-- 세션이 종료되면 트랜잭션 시작 전으로 롤백

-- ROLLBACK
SELECT * FROM accounts;

START TRANSACTION;

-- 1. 인출 (홍길동 -10만원)
UPDATE accounts SET balance = balance - 100000
 WHERE name = '홍길동';
-- 2. 입금 (전우치 +10만원)
UPDATE accounts SET balance = balance + 100000
 WHERE name = '전우치';

-- 데이터 확인 : 문제 발생 (금액이 0 이하로 떨어짐) 
SELECT * FROM accounts;

-- 트랜잭션 시작 이전으로 복구
ROLLBACK;

SELECT * FROM accounts;		
/* ROLLBACK 실행시
 - 트랜잭션(START TRANSACTION) 이후 실행된 모든 SQL 문 취소
 - 트랜잭션이 종료됨.
*/


-- SAVEPOINT

START TRANSACTION;

-- 첫번째 거래
-- 1. 인출 (홍길동 -5만원)
UPDATE accounts SET balance = balance - 50000
 WHERE name = '홍길동';
-- 2. 입금 (전우치 +5만원)
UPDATE accounts SET balance = balance + 50000
 WHERE name = '전우치';
 
SELECT * FROM accounts;  -- (홍길동 0 / 전우치 30만)

SAVEPOINT P1;  -- 첫번째 거래 이후 중간 지점을 설정 (P1은 저장점 이름)

-- 두번째 거래
-- 1. 인출 (홍길동 -5만원)
UPDATE accounts SET balance = balance - 50000
 WHERE name = '홍길동';
-- 2. 입금 (전우치 +5만원)
UPDATE accounts SET balance = balance + 50000
 WHERE name = '전우치';
 
SELECT * FROM accounts;		-- 오류 확인 (홍길동 -5만)

-- 첫번째 거래지점까지 롤백하기( 트랜잭션을 종료하지 않음 )
ROLLBACK TO P1;			

SELECT * FROM accounts;		-- (홍길동 0 / 전우치 30만)

COMMIT; -- 변경사항 반영 + 트랜잭션 종료


-- scott DB 예시
USE scott;
DESC emp;
START TRANSACTION;	-- 1. 트랜잭션 시작
SAVEPOINT P1;		-- 2. 저장점 설정 (처음상태)
INSERT INTO emp     -- 3. 데이터 삽입 (직원 등록)
 VALUES (9999, 'TCL_TEST', null, null, null, null, null, null);
SAVEPOINT P2;		-- 4. 저장점 설정 (직원 데이터 삽입)
UPDATE emp          -- 5. 급여 인상
 SET sal=1000 WHERE empno = 9999;
ROLLBACK TO P2;     -- 6. 급여 인상 전으로 복구
ROLLBACK TO P1;     -- 7. 직원 등록 전으로 복구
COMMIT;				-- 8. 트랜잭션 종료 (변경사항 확정)
 
SELECT * FROM emp WHERE empno = 9999; -- 데이터 확인







