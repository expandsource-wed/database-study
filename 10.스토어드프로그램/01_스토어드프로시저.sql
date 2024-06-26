-- 01_스토어드프로시저
/*
 스토어드(저장된, Stored) 프로시저(절차, Procedures)

 - 데이터베이스에 저장된 쿼리(SQL)의 집합
 - 자주 사용되는 쿼리(또는 복잡한 쿼리)를 저장해 두었다가 필요할 때 호출
 - 재사용성이 향상
 - 문법
 -- 구분자(;)를 변경
DELIMITER $$
CREATE PROCEDURE 프로시저명 (매개변수)
BEGIN
	-- 저장할 SQL 구문
    SELECT * FROM EMP;
    SELECT * FROM DEPT;
END$$
DELIMITER ;
 
*/
USE sqldb;

-- 스토어드 프로시저 생성
DELIMITER $$
-- 구분자를 ; 에서 $$로 변경
CREATE PROCEDURE userProc()
BEGIN
	-- SQL문
    SELECT * FROM usertbl;
END $$
-- 구분자를 $$ 에서 ;로 변경
DELIMITER ;

-- 스토어드 프로시저 호출
CALL userProc();


-- 매개변수 사용하여 프로시저 생성

DELIMITER $$
CREATE PROCEDURE userProcParam(IN userName VARCHAR(10))
-- IN : 입력 매개변수 데이터 타입
BEGIN
	-- SQL문
    SELECT * FROM usertbl WHERE name = userName;
END $$
DELIMITER ;

-- 매개변수가 있는 프로시저 호출
CALL userProcParam('김범수');
CALL userProcParam('바비킹');

-- 매개변수가 여러개 있는 프로시저

DELIMITER $$
CREATE PROCEDURE youngerAndTaller(IN userYear INT, IN userHeight INT)

BEGIN
	-- SQL문
    SELECT * FROM usertbl 
     WHERE birthYear > userYear
       AND height > userHeight;
END $$
DELIMITER ;

-- 1980년 이후 180 넘는 사람 조회
CALL youngerAndTaller(1980, 180);

DROP PROCEDURE youngerAndtaller;


-- 출력 매개변수 사용하기
DELIMITER $$
CREATE PROCEDURE countTaller(IN userHeight INT, OUT tallerCount INT)
-- OUT : 출력매개변수 -> INTO를 통해 변수에 반환
BEGIN
	-- SQL문
    SELECT count(*) INTO tallerCount
     FROM usertbl 
     WHERE height > userHeight;
END $$
DELIMITER ;

-- 호출하기
CALL countTaller(170, @cnt);
SELECT @cnt;		-- @cnt 변수에 쿼리문의 결과 값이 저장


-- 조건문
DELIMITER $$
CREATE PROCEDURE checkYear(IN userName VARCHAR(10))
BEGIN
	DECLARE yearBirth INT;  -- 정수값을 저장하는 변수 선언
	
    -- 쿼리문의 결과를 변수에 대입
    SELECT birthYear INTO yearBirth
    FROM usertbl 
    WHERE name = userName;
    
    -- 조건문
    IF (yearBirth >= 1980) THEN
		SELECT '밀레니얼 세대시군요..';
	ELSE
		SELECT 'X세대 시군요..';
	END IF;

END $$
DELIMITER ;

CALL checkYear('김범수');
CALL checkYear('이승기');


-- 반복문
DELIMITER $$
CREATE PROCEDURE printNumber()
BEGIN
	DECLARE counter INT DEFAULT 1;  -- 정수값 변수 1
	
	WHILE counter <= 5 DO
		SELECT counter;
		SET counter = counter + 1;
	END WHILE;
END $$
DELIMITER ;

CALL printNumber();


-- 스토어드 프로시저 목록 표시하기
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE db = 'sqldb'; -- 특정 DB

-- 프로시저 삭제하기
DROP PROCEDURE userProc;

-- 프로시저 정의 확인하기
SHOW CREATE PROCEDURE checkYear;