DROP SCHEMA IF EXISTS exercise;
CREATE SCHEMA IF NOT EXISTS exercise;
USE exercise;

-- departments 테이블 생성
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL UNIQUE,
    location VARCHAR(255)
);

-- employees 테이블 생성
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    salary INT CHECK (salary > 0) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id)
		REFERENCES departments (dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE

);

-- projects 테이블 생성
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL UNIQUE,
    start_date DATE DEFAULT (CURRENT_DATE),
    end_date DATE,
    CHECK (end_date IS NULL OR end_date > start_date)
);

-- assignments 테이블 생성
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    project_id INT,
    FOREIGN KEY (emp_id)
        REFERENCES employees (emp_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (project_id)
        REFERENCES projects (project_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 테이블 구조 확인
DESCRIBE departments;
DESCRIBE employees;
DESCRIBE projects;
DESCRIBE assignments;

-- departments 테이블 데이터 삽입
INSERT INTO departments (dept_name, location)
VALUES ('개발팀', '부산'),
       ('영업팀', '서울'),
       ('마케팅팀', '창원');

-- employees 테이블 데이터 삽입
INSERT INTO employees (emp_name, hire_date, salary, dept_id)
VALUES ('홍길동', '2022-01-15', 3200000, 1),
       ('김철수', '2023-03-01', 2700000, 2),
       ('박영희', '2021-07-01', 2900000, 3);

-- projects 테이블 데이터 삽입
INSERT INTO projects (project_name, start_date, end_date)
VALUES ('웹사이트 프로젝트', '2023-01-01', '2023-06-30'),
       ('쇼핑몰 프로젝트', '2023-02-01', '2023-12-31'),
       ('마케팅 프로젝트', '2023-03-01', NULL);

-- assignments 테이블 데이터 삽입
INSERT INTO assignments (emp_id, project_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (3, 3);

-- 데이터 확인
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM assignments;

-- 참조 옵션 확인

-- DELETE SET NULL
DELETE FROM departments WHERE dept_id = 1;
SELECT * FROM employees;

-- UPDATE CASCADE
UPDATE projects SET project_id = 100
 WHERE (project_id = 3);
SELECT * FROM assignments;




