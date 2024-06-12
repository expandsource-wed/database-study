-- 문제1.
-- 전체 사원 중 ALLEN과 같은 직책 (JOB)인 사원들의 사원 정보, 부서 정보를 출력하는 SQL문을 작성하세요.

SELECT job FROM emp WHERE ename = 'ALLEN';	-- SALESMAN, 서브

SELECT * FROM emp e
 JOIN dept d
 WHERE e.job = ( 
	SELECT job FROM emp WHERE ename = 'ALLEN'
 );

-- 문제2.
-- 직책이 SALESMAN 인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보 , 급여 등급 정보를 출력하는 SQL문을 작성하세요.
-- (방법 2가지 : 단일행 함수 사용하는 법, 다중행 함수 사용하는 법)

-- 단일행
SELECT * FROM emp WHERE sal > 
	( SELECT max(sal) FROM emp WHERE job = 'SALESMAN' );
    
-- 다중행
SELECT * FROM emp WHERE sal > ALL 
	( SELECT sal FROM emp WHERE job = 'SALESMAN' );