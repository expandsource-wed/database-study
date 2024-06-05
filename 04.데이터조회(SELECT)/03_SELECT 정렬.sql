-- 03_SELECT 정렬.sql

-- 기본문법
-- SELECT 컬럼명
-- FROM 테이블명
-- ORDER BY 컬럼명 [ASC|DESC], ...
-- 컬럼명 : 정렬할 기준이 되는 열
-- ASC : 오름차순
-- DESC : 내림차순
use scott; -- DB 사용 선언

-- sal 기준으로 오름차순 정렬 (ASC, DESC 생략시 기본값 : 오름차순)
-- 급여 적은 순으로 직원 정렬하여 조회
SELECT * FROM emp ORDER BY sal;

-- 급여 많은 순으로 직원 정렬하여 조회 (내림차순)
SELECT * FROM emp ORDER BY sal DESC;

-- 여러 컬럼을 기준으로 정렬하기
-- 부서 기준으로 정렬하고 각 부서 내부에서 급여 많은 순으로 조회
SELECT * FROM emp 
ORDER BY deptno ASC, sal DESC;


-- LIMIT 조회 결과를 제한

-- 급여를 가장 적게 받는 3인을 조회
SELECT * FROM emp 
ORDER BY sal LIMIT 3;

-- 급여를 가장 많이 받는 3인을 조회
SELECT * FROM emp 
ORDER BY sal DESC LIMIT 3;

-- OFFSET : 결과 셋에서 몇 행을 건너 뛸 때 사용

-- 급여 많이받는 순위 4 ~ 6위까지를 조회
SELECT * FROM emp 
ORDER BY sal DESC LIMIT 3 OFFSET 3;

-- LIMIT ~ OFFSET 은 대규모의 데이터셋에서 필요한 부분만 조회
-- 응답시간과 성능을 최적화하여 사용자 경험을 개선
-- 데이터 페이지네이션(Pagenation)


-- DISTINCT : 중복된 값을 제거하고 고유값만 반환

-- 직원 테이블에서 어떤 직무가 있는지 조회
SELECT DISTINCT job FROM emp;
-- 직원 테이블에서 어떤 부서번호가 있는지 조회
SELECT DISTINCT deptno FROM emp;

-- 직원 테이블에서 어떤 부서번호가 있는지 조회 + 오름차순 정렬
SELECT DISTINCT deptno FROM emp ORDER BY deptno;

