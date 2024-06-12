-- 07_SELECT 서브쿼리.sql
USE scott;
-- 서브쿼리 : SQL 문 내에 포함된 쿼리(SELECT문), 중첩 쿼리, 
-- 메인 쿼리의 일부로 동작

-- JONES 씨의 급여 = 2975
SELECT sal FROM emp WHERE ename = 'JONES';

-- JONES 씨보다 급여를 많이 받는 사원의 정보
SELECT * FROM emp WHERE sal > 2975; -- 메인쿼리

SELECT * FROM emp WHERE sal > (
	SELECT sal FROM emp WHERE ename = 'JONES'  -- 서브쿼리
);

-- 단일 행(single row) 서브쿼리

-- SCOTT 씨보다 빨리 입사한 사원의 정보

-- 1. 서브쿼리 (스콧의 입사일)
SELECT hiredate FROM emp WHERE ename='scott';  -- 1982-12-09

-- 2. 메인쿼리
SELECT * FROM emp WHERE hiredate < 
  (SELECT hiredate FROM emp WHERE ename='scott');

-- 집계함수 sum, avg, count, min, max -> 단일행
-- 30번 부서의 평균 급여보다 높은 급여를 받는 직원 정보

-- 서브쿼리 : 30번 부서의 평균 => 단일행
SELECT avg(sal) FROM emp WHERE deptno = 30;  -- 1566

-- 메인쿼리
SELECT * FROM emp WHERE sal > (
	SELECT avg(sal) FROM emp WHERE deptno = 30
);


-- 다중행(multi-row) 서브쿼리

-- 각 부서별 최고급여와 동일한 급여를 받는 사원 정보
-- 1. 서브쿼리
SELECT max(sal) FROM emp GROUP BY deptno;	-- 다중 행

-- 서브쿼리가 1행 이상 이상인 경우 Error 발생 (1242)
SELECT * FROM emp WHERE sal = (
	SELECT max(sal) FROM emp GROUP BY deptno
);

-- IN 함수를 사용하는 경우, 여러 개의 값을 인자로 받을 수 있음.
SELECT * FROM emp 
 WHERE sal IN (3000, 2850, 5000);		
 
-- 다중 행 메인 쿼리
SELECT * FROM emp 
 WHERE sal IN (
	SELECT max(sal) FROM emp GROUP BY deptno
 );
 
 
-- ANY : 비교연산자와 함께 사용
-- 결과 집합 중 하나 이상의 값과 비교할 때 사용

-- 30번 부서 직원들의 급여 (1600, 1250, 1250, 2850, 1500, 950)
SELECT sal FROM emp WHERE deptno = 30;

-- 30번 부서 직원들의 급여보다 적은 급여를 받는 사원 정보
 SELECT * FROM emp 
 WHERE sal < ANY (
	SELECT sal FROM emp WHERE deptno = 30
 );
 
 -- 인자들 중 하나라도 참이면 참 => 인자들 중 최대값(2850)보다 적은 급여
 

-- ALL : 서브 쿼리의 모든 집합과 비교, 비교연산자와 함께 사용

-- (1600, 1250, 1250, 2850, 1500, 950)
-- 결과 셋의 모든 값을 만족해야 통과 => 950보다 적은 값만 만족
-- 30번 부서 직원들의 급여보다 적은 급여를 받는 사원 정보
 SELECT * FROM emp 
 WHERE sal < ALL (
	SELECT sal FROM emp WHERE deptno = 30
 );
 
 
-- SELECT 절 내부에서 서브쿼리 사용
-- 사원의 부서 이름을 조회하는데 서브 쿼리를 사용
SELECT e.ename,
	   (SELECT d.dname FROM dept d WHERE e.deptno = d.deptno)
       AS '부서명'
FROM emp e;

-- FROM 절 내부에서 서브쿼리 사용
-- 각 부서의 최대급여를 부서이름과 조회
SELECT d.dname, max_dept_sal.max_sal
FROM dept d
 JOIN (SELECT deptno, max(sal) as max_sal FROM emp GROUP BY deptno)
		AS max_dept_sal
 ON d.DEPTNO = max_dept_sal.deptno;

 