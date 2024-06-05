-- 02_SELECT 조건연산자.sql
USE scott;

-- BETWEEN .. AND : 특정 범위 내의 값을 조회
-- 날짜 범위 : 1980년에 고용된 직원 조회
SELECT * FROM emp
WHERE hiredate BETWEEN '1980-01-01' AND '1980-12-31';

-- 숫자 범위 : 급여가 1500 ~ 2500 범위 내의 직원 조회
SELECT * FROM emp
WHERE sal BETWEEN 1500 AND 2500;

-- 문자 범위 : 이름이 A~C로 시작하는 직원을 조회
SELECT * FROM emp
WHERE ename BETWEEN 'A' AND 'D';

-- IN() : 특정 값 목록 중 하나와 일치하는 row를 조회
-- 직원 테이블에서 JOB이 'SALESMAN', 'MANAGER', 'CLERK' 중 하나인 직원 조회
SELECT * FROM emp
WHERE JOB IN ('SALESMAN', 'MANAGER', 'CLERK');

-- OR 조건문과 동일한 결과를 반환
SELECT * FROM emp
WHERE JOB = 'SALESMAN' OR JOB = 'MANAGER' OR JOB = 'CLERK';

-- 숫자 목록 조회 : 직원 테이블에서 부서번호가 10, 30인 직원 조회
SELECT * FROM emp
WHERE DEPTNO IN (10, 30);


-- LIKE : 문자열 패턴 매칭
-- 와일드카드 문자, '%' : 여러문자 매칭(0개 이상), '_' : 정확히 일치하는 한 문자

-- 이름이 S로 시작하는 직원 조회
SELECT * FROM emp
WHERE ename LIKE 'S%';

-- 이름의 두번째 문자가 M인 직원을 조회
SELECT * FROM emp
WHERE ename LIKE '_M%';

-- 이름이 S로 끝나는 직원 조회
SELECT * FROM emp
WHERE ename LIKE '%S';

-- 이름에 S가 포함되어 있는 직원 조회
SELECT * FROM emp
WHERE ename LIKE '%S%';

