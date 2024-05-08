-- (연습문제3.sql)의 테이블에서 테이블 구조를 변경하세요)
use exercise;

-- 제약조건 이름 확인하기
SELECT TABLE_SCHEMA, CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'exercise';

-- 연습 문제 1: departments 테이블에 고유 제약조건을 삭제한 후 다시 추가하세요.
DESCRIBE departments;
ALTER TABLE departments
	DROP CONSTRAINT dept_name;	-- 제약조건 이름으로 삭제
ALTER TABLE departments
	ADD UNIQUE (dept_name);		-- 유니크 제약조건 추가
-- 인덱스(유니크 제약조건에서 생성되는 인덱스)로 삭제하기
ALTER TABLE departments
	DROP INDEX dept_name;
-- 연습 문제 2: departments 테이블에서 location 컬럼에 NOT NULL 제약조건을 추가하세요.
DESCRIBE departments;
ALTER TABLE departments
	MODIFY COLUMN location varchar(255) NOT NULL;
-- 연습 문제 3: employees 테이블에서 급여가 음수인 경우를 허용하도록 CHECK 제약조건을 삭제하세요.
DESCRIBE employees;
SHOW CREATE TABLE employees;	-- DDL문으로 이름 확인

ALTER TABLE employees
	DROP CONSTRAINT employees_chk_1;

-- 연습 문제 4: employees 테이블에 position 컬럼을 추가하고 기본값을 'Staff'로 설정하세요.
ALTER TABLE employees
	ADD COLUMN position VARCHAR(255) DEFAULT 'Staff';
DESCRIBE employees;			-- 구조 확인
SELECT * FROM employees;    -- 데이터 확인

-- 연습 문제 5: employees 테이블에서 salary 컬럼을 NULL 허용으로 변경하세요.
ALTER TABLE employees
	MODIFY COLUMN salary INT NULL;
DESCRIBE employees;

-- 연습 문제 6: projects 테이블에서 project_name 컬럼의 길이를 VARCHAR(100)으로 변경하세요.
DESC projects;
ALTER TABLE projects
	MODIFY COLUMN project_name VARCHAR(100) NOT NULL;

-- 연습 문제 7: projects 테이블에 budget 컬럼을 추가하고 기본값을 10000으로 설정하세요.
ALTER TABLE projects
	ADD COLUMN budget INT DEFAULT 10000;
DESC projects;

-- 연습 문제 8: projects 테이블에 CHECK 제약조건을 추가하여 프로젝트 예산(budget)이 5000 이상이어야 한다는 조건을 설정하세요.
ALTER TABLE projects
	ADD CONSTRAINT chk_budget CHECK (budget >= 5000);
    
-- 연습 문제 9: assignments 테이블에 UNIQUE 제약조건을 추가하여 동일한 직원과 프로젝트 조합이 중복되지 않도록 하세요.
DESCRIBE assignments;
ALTER TABLE assignments
	ADD CONSTRAINT UNIQUE (emp_id, project_id);
SHOW CREATE TABLE assignments;

-- 연습 문제 10: assignments 테이블에 assignment_date 컬럼을 추가하고 기본값을 현재 날짜로 설정하세요.
ALTER TABLE assignments
	ADD COLUMN assignment_date DATE DEFAULT (CURRENT_DATE);
DESCRIBE assignments;

-- 연습 문제 11: departments 테이블에서 location 컬럼을 삭제하세요
desc departments;
ALTER TABLE departments
	DROP COLUMN location;

-- 연습 문제 12: employees 테이블에서 position 컬럼을 삭제하세요.
DESC employees;
ALTER TABLE employees
	DROP COLUMN position;

-- 연습 문제 13: projects 테이블에서 CHECK 예산 추가 제약조건을 삭제하세요.(제약조건 이름 확인 필요)
DESC projects;
ALTER TABLE projects
	DROP CONSTRAINT chk_budget;
	-- 연습문제 8번에서 명시한 이름

-- 연습 문제 14: projects 테이블에서 다른 체크제약 조건들을 찾아 삭제하세요.(제약조건 이름 확인 필요)

-- (참고) 제약조건 이름 확인하기
SELECT TABLE_SCHEMA, CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'exercise';

ALTER TABLE projects
	DROP CONSTRAINT projects_chk_1;

-- 연습 문제 15: assignments 테이블에서 동일한 직원과 프로젝트 조합이 중복되지 않도록 하는 제약조건을 삭제하세요. (제약조건 이름 확인 필요)
-- 외래키 제약조건이 삭제가 전제되어야 함.
ALTER TABLE assignments
	DROP CONSTRAINT assignments_ibfk_1;
ALTER TABLE assignments
	DROP CONSTRAINT assignments_ibfk_2;
ALTER TABLE assignments
	DROP CONSTRAINT emp_id;

SHOW CREATE TABLE assignments;
