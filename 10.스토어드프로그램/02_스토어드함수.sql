-- 02_스토어드함수
/*
 - DB에 저장되고 실행되는 SQL 구문 집합
 - 호출 시 항상 하나의 값을 반환
 - SQL문 내에서 호출 가능
*/
USE sqldb;

-- 스토어드 함수 생성 권한 허용
SET GLOBAL log_bin_trust_function_creators = 1;

-- 두 수를 더하는 함수
DELIMITER $$
CREATE FUNCTION addNumber(a INT, b INT)
	RETURNS INT
BEGIN
	RETURN a + b;
END $$
DELIMITER ;

-- 함수 호출
SELECT addNumber(10, 20);
-- 내장 함수처럼 SQL문 내부에서 호출 가능
SELECT name, height, addNumber(height, 10) FROM usertbl;


DROP FUNCTION IF EXISTS getUserAge;
-- 사용자의 나이를 계산하는 함수
DELIMITER $$
CREATE FUNCTION getUserAge(userName VARCHAR(10))
	RETURNS INT
BEGIN
	-- 사용할 변수 선언
	DECLARE yearBirth INT;
	DECLARE yearCurrent INT;
    
    -- 테이블에서 출생년도 가져오기
    SELECT birthYear INTO yearBirth
    FROM usertbl 
    WHERE name = userName;
    
    -- 연도 계산
    SET yearCurrent = year(curdate()); -- 현재연도
    
    -- 나이 계산하여 반환
    RETURN yearCurrent - yearBirth;
    
END $$
DELIMITER ;



-- 함수 호출
SELECT getUserAge('김범수');
SELECT name, birthYear, getUserAge(name) as age FROM usertbl;


-- 저장함수 목록 확인 (데이터사전에서 프로시저와 함수 확인)
SELECT * FROM information_schema.routines;
SELECT * FROM information_schema.routines
 WHERE routine_schema = 'sqldb';
 
SELECT routine_name, routine_type
 FROM information_schema.routines
 WHERE routine_schema = 'sqldb';

-- 저장 함수 생성문 확인
SHOW CREATE FUNCTION getUserAge;

-- 함수 삭제하기
DROP FUNCTION addNumber;


