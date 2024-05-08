/* ALTER문 연습 */
DROP SCHEMA IF EXISTS alter_db;
CREATE SCHEMA alter_db;
USE alter_db;

-- 테이블 생성 (샘플 데이터베이스에서 테이블 구조를 복사)
CREATE TABLE employees
	LIKE employees.employees;
    -- employees DB의 employees 테이블 구조와 같은 테이블을 현재 DB에 생성한다.
    
DESCRIBE employees;		 -- 테이블 구조 확인
SELECT * FROM employees; -- 데이터는 복사되지 않음

-- 1. ADD 새로운 컬럼 추가
	-- ADD COLUMN 컬럼명 데이터타입
ALTER TABLE employees
	ADD COLUMN phone_number VARCHAR(20);

-- 2. DROP 컬럼 삭제
	-- DROP COLUMN 컬럼명
ALTER TABLE employees
	DROP COLUMN phone_number;

-- 3. CHANGE 컬럼명 변경하기
ALTER TABLE employees
	CHANGE COLUMN first_name FIRSTNAME varchar(14);

-- 4. MODIFY 데이터 타입 변경하기
ALTER TABLE employees
	MODIFY COLUMN hire_date DATETIME;

-- 5. RENAME 테이블 이름 변경하기
ALTER TABLE employees
	RENAME TO employees_ABC;
ALTER TABLE employees_ABC
	RENAME TO employees;
    
DESC employees;

