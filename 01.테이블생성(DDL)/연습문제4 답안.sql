-- (연습문제3.sql)의 테이블에서 테이블 구조를 변경하세요)
use exercise;

-- 제약조건 이름 확인하기
SELECT TABLE_SCHEMA, CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
	FROM information_schema.TABLE_CONSTRAINTS
	WHERE TABLE_SCHEMA = 'exercise';

-- 연습 문제 1: departments 테이블에 고유 제약조건을 삭제한 후 다시 추가하세요.

-- 연습 문제 2: departments 테이블에서 location 컬럼에 NOT NULL 제약조건을 추가하세요.
-- 연습 문제 3: employees 테이블에서 급여가 음수인 경우를 허용하도록 CHECK 제약조건을 삭제하세요.
-- 연습 문제 4: employees 테이블에 position 컬럼을 추가하고 기본값을 'Staff'로 설정하세요.
-- 연습 문제 5: employees 테이블에서 salary 컬럼을 NULL 허용으로 변경하세요.
-- 연습 문제 6: projects 테이블에서 project_name 컬럼의 길이를 VARCHAR(100)으로 변경하세요.
-- 연습 문제 7: projects 테이블에 budget 컬럼을 추가하고 기본값을 10000으로 설정하세요.
-- 연습 문제 8: projects 테이블에 CHECK 제약조건을 추가하여 프로젝트 예산(budget)이 5000 이상이어야 한다는 조건을 설정하세요.
-- 연습 문제 9: assignments 테이블에 UNIQUE 제약조건을 추가하여 동일한 직원과 프로젝트 조합이 중복되지 않도록 하세요.
-- 연습 문제 10: assignments 테이블에 assignment_date 컬럼을 추가하고 기본값을 현재 날짜로 설정하세요.
-- 연습 문제 11: departments 테이블에서 location 컬럼을 삭제하세요
-- 연습 문제 12: employees 테이블에서 position 컬럼을 삭제하세요.
-- 연습 문제 13: projects 테이블에서 CHECK 예산 추가 제약조건을 삭제하세요.(제약조건 이름 확인 필요)
-- 연습 문제 14: projects 테이블에서 다른 체크제약 조건들을 찾아 삭제하세요.(제약조건 이름 확인 필요)
-- 연습 문제 15: assignments 테이블에서 동일한 직원과 프로젝트 조합이 중복되지 않도록 하는 제약조건을 삭제하세요. (제약조건 이름 확인 필요)