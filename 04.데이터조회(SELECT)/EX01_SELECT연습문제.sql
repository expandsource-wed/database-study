-- EX01_SELECT연습문제
-- World 샘플 데이터베이스 탐색
USE world;
SHOW TABLES;
DESCRIBE city;
DESCRIBE country;

-- 문제 1: SELECT * 와 특정 열 선택
-- 1. country 테이블에서 모든 열을 선택하여 조회하세요.
SELECT * FROM country;
-- 2. city 테이블에서 ID, Name, CountryCode 열을 선택하여 조회하세요.
SELECT ID, Name, CountryCode FROM city;

-- 문제 2: 별칭 사용 (AS 키워드)
-- 1. country 테이블에서 Name 열을 CountryName이라는 별칭으로 선택하여 조회하세요.
SELECT Name AS CountryName FROM country;
-- 2. city 테이블에서 Name을 CityName으로, Population을 CityPopulation으로 별칭을 붙여 선택하여 조회하세요.
SELECT Name as CityName, Population as CityPopulation FROM city;

-- 문제 3: WHERE 절
-- 1. country 테이블에서 Continent가 'Asia'인 나라들을 조회하세요.
SELECT * FROM country WHERE Continent = 'Asia';
-- 2. city 테이블에서 Population이 5000000 이상인 도시들을 조회하세요.
SELECT * FROM city WHERE Population > 5000000;
-- 3. country 테이블에서 Region이 'Eastern Europe'인 나라들을 조회하세요.
SELECT * FROM country WHERE Region = 'Eastern Europe';


USE world;
describe country;
-- 문제 1: BETWEEN ... AND 사용
-- 1. country 테이블에서 인구(Population)가 2000만에서 5000만 사이인 나라들의 이름과 인구를 조회하세요.
SELECT Name, Population FROM country
WHERE Population BETWEEN 20000000 AND 50000000;

-- 문제 2: IN() 사용
-- 2. country 테이블에서 Continent가 'Africa', 'South America', 'Oceania' 중 하나인 나라들의 이름과 대륙을 조회하세요.
SELECT Name, Continent FROM country
WHERE Continent IN ('Africa', 'South America', 'Oceania');

-- 문제 3: LIKE 사용
-- 3. city 테이블에서 이름(Name)이 'A'로 시작하는 도시들의 이름을 조회하세요.
SELECT Name FROM city
WHERE Name LIKE 'A%';







