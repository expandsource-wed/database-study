-- 01_SELECT

-- scott.sql 실행 후 SCOTT 스키마 사용
USE scott;
-- 데이터베이스 탐색
SHOW tables;
DESCRIBE emp;

-- 전체 테이블 내용을 확인하기
-- *(asterisk) : 모든 열을 선택
SELECT * FROM emp;

-- 특정 컬럼만 선택하기 (프로젝션(투영))
-- projection attritube
-- 직원 테이블에서 직원번호, 이름, 직무 선택
SELECT empno, ename, job FROM emp;

-- 특정 조건만 선택하기 (셀렉션(선택))
-- select conditon
-- 직원 테이블에서 직무가 'CLERK'인 사람만 선택
SELECT * FROM emp WHERE job = 'CLERK';

-- 셀렉션 + 프로젝션
-- 직원 테이블에서 직무가 'CLERK'인 사람의 이름과 직무를 선택
SELECT ename, job FROM emp WHERE job = 'CLERK';

-- WHERE절 조건식
-- (문법) SELECT 컬럼명, ... FROM 테이블명 WHERE 조건식(condition)

-- 특정 조건에 일치하는 행 선택
SELECT * FROM emp WHERE job = 'CLERK';

-- 조건에 따른 비교 (>, <, >=, <=)
SELECT * FROM emp WHERE SAL > 1500;

-- 논리 연산자 사용 (AND, OR, NOT)
-- AND(그리고) : 급여가 1500 이상이면서 SALESMAN 인 직원 조회
SELECT * FROM emp WHERE SAL > 1500 AND JOB = 'SALESMAN';
-- OR(또는) : 직무가 SALESMAN이거나 부서번호가 30번인 직원 조회
SELECT * FROM emp WHERE JOB = 'SALESMAN' OR DEPTNO = 30;
-- NOT(아니다) : 직무가 SALESMAN이 아닌 직원 조회
SELECT * FROM emp WHERE NOT JOB = 'SALESMAN';

-- NULL 처리
-- IS NULL : 해당 값(커미션)이 NULL 인 직원 조회
SELECT * FROM emp WHERE comm IS NULL;
-- IS NOT NULL : 해당 값(커미션)이 NULL 이 아닌 직원 조회
SELECT * FROM emp WHERE comm IS NOT NULL;

-- 별칭 사용 (AS 키워드)
SELECT EMPNO AS id, ENAME AS name FROM emp;

-- 별칭(AS)를 사용하여 계산된 열을 표시
SELECT ename as 직원이름,
   sal AS 급여,
   comm AS 상여,
   sal + ifnull(comm, 0) AS 실지급액	-- null인경우 0으로 처리
 FROM emp;

-- 테이블 이름에 별칭을 부여하여 사용
SELECT emp.ename, emp.job FROM emp;
SELECT e.ename, e.job FROM emp AS e;

