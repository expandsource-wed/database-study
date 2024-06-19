-- 01_내장함수
USE scott; 

-- 변수 선언
SET @variable1 = 5;
SET @variable2 = 3;
SELECT @variable1 + @variable2;

-- 직원 급여 평균을 변수로 저장
SET @avg_salary = (SELECT avg(sal) FROM emp);

SELECT @avg_salary;

-- 변수를 사용해서 쿼리 수행 : 평균보다 많이 급여를 받는 사원 조회
SELECT * FROM emp WHERE sal > @avg_salary;


-- 1. 문자열 함수

-- length(문자열)
SELECT length('hello, sql');
SELECT ename, length(ename) FROM emp;	-- 직원 이름 길이 문자열

-- upper(문자열), lower(문자열)
SELECT upper('hello, sql');				-- 대문자로
SELECT ename, lower(ename) FROM emp;	-- 소문자로

-- substr(문자열, 시작위치, 길이) : 특정 문자열 추출
SELECT substr('hello, sql', 1, 5);		-- 시작위치가 1부터 시작
SELECT ename, substr(ename, 1, 3) as short FROM emp;

-- instr(문자열, 찾을문자열) : 찾을 문자열이 처음 나타나는 위치 반환
SELECT instr('hello, sql', ',');
SELECT ename, instr(ename, 'A') FROM emp;  -- 포함 되지 않으면 0 반환
-- instr을 사용하여 substr의 인덱스를 계산 (, 이전의 글자 추출)
SELECT substr('hello, sql', 1, instr('hello, sql', ',') - 1);	

-- concat(문자열1, 문자열2, ...) : 2개 이상의 문자열을 연결
SELECT concat("안녕하세요", " ", "반갑습니다.");
SELECT ename, job, concat(ename, '-', job) as `name-job` from emp;
-- concat_ws(구분자, 문자열1, 문자열2, ...) : 2개 이상의 문자열을 구분자 포함 연결
SELECT concat_ws('-', '2024', '06', '19');
SELECT concat_ws('/', '2024', '06', '19');

-- trim, ltrim, rtrim : 기본으로 공백제거 또는 특정문자 제거
SELECT trim('      문자열    ');	   -- 좌우 공백 제거
SELECT ltrim('      문자열    ');	   -- 왼쪽 공백 제거
SELECT rtrim('      문자열    ');	   -- 오른쪽 공백 제거
SELECT trim('-' from '----문자열----');	-- 특정 문자 제거

-- replace(원본문자열, 찾을문자열, 대체문자열) : 다른 문자열로 대체
SELECT replace('문자열', '문자', '유희');
SELECT replace(ename, 'A', '*') from emp;

-- lpad, rpad(문자열, 전체길이, 패딩문자) : 패딩문자를 추가
SELECT lpad('안녕하세요', 10, '#');
SELECT rpad('안녕하세요', 10, '#');
SELECT sal, lpad(sal, 4, '0') FROM emp;

-- left, right(문자열, 길이) : 문자열의 방향에서 길이만큼 반환
SELECT left('문자열', 2);
SELECT right('문자열', 2);
SELECT left(ename, 3) from emp;

-- reverse(문자열) : 문자열 뒤집어서 반환
SELECT reverse('문자열');

-- repeat(문자열, 횟수) : 횟수만큼 반복
SELECT repeat('문자열', 5);

-- space(길이) : 길이만큼의 공백을 반환
SELECT concat('문', space(5), '자', space(5), '열');

-- ascii(문자열) : 첫번째 글자의 아스키문자열 반환
SELECT ename, ascii(ename) FROM emp;


-- 2. 숫자 함수

-- round(숫자, 소수점자리수) : 반올림
SELECT round(10.4567), round(10.4567, 2), round(4567.1234, -2);

-- 올림 ceil(숫자), 내림 floor(숫자)
SELECT ceil(23.456), floor(56.789);

-- 거듭제곱 pow, power(숫자, 거듭제곱 값)
SELECT pow(4, 2), pow(4, 3), pow(2, 10);

-- 제곱근 sqrt(숫자)
SELECT sqrt(16);

-- log 자연로그, log10 상용로그
SELECT log(2.71828), log10(100);

-- mod(숫자, 나눌숫자) : 나머지 연산
SELECT mod(10, 3);	-- 나머지 1

-- pi() : 원주율
SELECT pi();


-- 3. 날짜함수

-- now() : 현재 날짜 시간
SELECT now();

-- curdate() : 현재 날짜, curtime() : 현재 시간;
SELECT curdate(), curtime();

-- date(DATETIME|TIMESTAMP 타입등 ) : 전체 날짜시간에서 날짜만 반환
SELECT date(now()), time(now());
SELECT date('2024-06-19 10:35:21'), time('2024-06-19 10:35:21');

-- year, month, day(DATE|DATETIME|TIMESTMAP 날짜타입) : 연 월 일 추출
SELECT ename, hiredate, 
	year(hiredate), month(hiredate), day(hiredate)
FROM emp;

-- hour, minute, second(시간타입) : 시 분 초 추출
SELECT now(), hour(now()), minute(now()), second(now());

-- date_add(날짜값, INTERVAL 간격(DAY, MONTH, YEAR)) : 지정된 날짜 더하기
SELECT now(), date_add(now(), interval 7 day);	  -- 일주일 후
SELECT now(), date_add(now(), interval 7 month);  -- 7 개월 후
SELECT now(), date_add(now(), interval 7 year);	  -- 7 년 후

-- date_sub(날짜값, INTERVAL 간격(DAY, MONTH, YEAR)) : 지정된 날짜 빼기
SELECT now(), date_sub(now(), interval 7 day);	  -- 일주일 전
SELECT now(), date_sub(now(), interval 7 month);  -- 7 개월 전
SELECT now(), date_sub(now(), interval 7 year);	  -- 7 년 전

-- datediff(날짜1, 날짜2) : 날짜 차이를 일 단위로 반환
SELECT datediff(now(), '2020-01-01');

-- timestampdiff(단위, 날짜1, 날짜2) : 지정된 단위로 날짜/시간 차이 반환
SELECT timestampdiff(month, now(), '2020-01-01');
SELECT timestampdiff(year, now(), '2020-01-01');
SELECT timestampdiff(hour, now(), '2020-01-01 01:01:01');

-- date_format(날짜, 날짜형식) : 날짜값을 지정된 형식의 문자열로 반환
SELECT date_format(now(), '%Y/%m/%d');
SELECT date_format(now(), '%Y년 %m월 %d일');

-- lasy_day(날짜타입) : 주어진 달의 마지막 날 반환
SELECT now(), last_day(now());
SELECT '2024-02-01', last_day('2024-02-01');


-- 4. 변환 함수

-- cast(값 as 타입) : 데이터를 지정된 타입으로 변환
SELECT cast(1000 as CHAR); -- 숫자를 문자열 타입으로
desc emp;
SELECT cast(sal as CHAR) FROM emp; -- 숫자를 문자열 타입으로
-- SELECT cast(ename as int) from emp; -- 문자열 -> 숫자 (X)

-- convert(값, 데이터타입) : 타입 변환
SELECT convert(1000, CHAR);	-- 숫자를 문자열 타입으로

-- str_to_date(날짜타입의문자열, 날짜타입) : 문자열을 날짜타입로 변환
SELECT str_to_date('2024년 6월 19일', '%Y년 %m월 %d일');

-- format(숫자, 소수점 자리수) : 숫자를 1000단위마다 콤마가 붙여진 문자열로 변환
SELECT format(1234567812345, 2);
SELECT format(1234567812345, 0);


-- 5. 집계 함수 : count, sum, avg, min, max -> Groupby에서 다룸


-- 6. 시스템 정보 함수

SELECT version();		-- MySql 서버 버전 반환
SELECT database();		-- 현재 선택(use)된 데이터베이스 반환
SELECT user();			-- 현재 세션에 접속된 사용자와 호스트 정보 반환
SELECT current_timestamp();  -- 현재 시스템 상 날짜 시간 반화

SELECT @@hostname;		-- 서버의 호스트 이름 반환
SELECT @@port;			-- MySql 서버 포트 반환

-- sleep(n초) : 쿼리 실행을 n초간 멈춤
SELECT sleep(3);
SELECT '3초 후의 쿼리';


-- 7. 제어 흐름 함수

-- if(조건, 참일때, 거짓일때)
SELECT if(100 < 101, '참', '거짓');
SELECT if(100 > 101, '참', '거짓');

-- ifnull(표현식, 대체할값) : 만약 첫번째 인자 표현식이 null이면 대체값(두번째 인자) 반환
SELECT ifnull(null, '빈값');
SELECT ename, sal, comm from emp;				-- null 존재 컬럼(comm)
SELECT ename, sal, ifnull(comm, 0) from emp;	-- null -> 0 대체

-- nullif(표현식1, 표현식2) : 두 표현식이 같으면 null, 다르면 표현식1(첫번째 인자) 반환
SELECT nullif(100, 100), nullif(100, 0);

-- 커미션이 null이면 0으로 반환하여 계산 (ifnull)
SELECT ename, sal, comm,
	sal+ifnull(comm, 0) as total_sal from emp;
    
-- 급여합계와 급여가 같으면 null을 반환 (nullif)
SELECT ename, sal, comm,
	sal+ifnull(comm, 0) as total_sal,
    nullif(sal, sal+ifnull(comm, 0))
    from emp;