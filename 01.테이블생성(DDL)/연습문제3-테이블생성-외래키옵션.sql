DROP SCHEMA IF EXISTS exercise;
CREATE SCHEMA IF NOT EXISTS exercise;
USE exercise;
/*
### 문제: 다양한 타입과 제약조건을 활용하여 테이블 생성하기

문제 설명
새로운 데이터베이스 스키마를 설계하고 다음 요구사항을 만족하는 테이블을 생성하세요.

스키마 설명
- departments: 회사의 부서 정보를 저장하는 테이블
- employees: 부서에 소속된 직원 정보를 저장하는 테이블
- projects: 회사에서 진행 중인 프로젝트 정보를 저장하는 테이블
- assignments: 직원이 프로젝트에 배정된 정보를 저장하는 테이블

제약조건
1. 각 테이블은 기본 키(Primary Key)를 가져야 합니다.
2. 적절한 데이터 타입을 사용하고 `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT` 등의 제약조건을 활용하세요.
3. 외래 키(Foreign Key)로 테이블 간의 관계를 설정하고 참조 옵션을 사용하세요.

요구사항
1. departments 테이블
   - dept_id: 부서 ID (자동 증가, 기본 키)
   - dept_name: 부서 이름 (고유해야 함)
   - location: 부서 위치

2. employees 테이블
   - emp_id: 직원 ID (자동 증가, 기본 키)
   - emp_name: 직원 이름 (필수)
   - hire_date: 입사 날짜 (필수)
   - salary: 급여 (필수, 양수만 허용)
   - dept_id: 부서 ID (외래 키, `ON DELETE SET NULL`, `ON UPDATE CASCADE`)

3. projects 테이블
   - project_id: 프로젝트 ID (자동 증가, 기본 키)
   - project_name: 프로젝트 이름 (필수, 고유해야 함)
   - start_date: 프로젝트 시작 날짜 (기본값은 현재 날짜)
   - end_date: 프로젝트 종료 날짜 (종료 날짜가 시작 날짜 이후여야 함)

4. assignments 테이블
   - assignment_id: 배정 ID (자동 증가, 기본 키)
   - emp_id: 직원 ID (외래 키, `ON DELETE CASCADE`, `ON UPDATE CASCADE`)
   - project_id: 프로젝트 ID (외래 키, `ON DELETE CASCADE`, `ON UPDATE CASCADE`)

모든 테이블을 생성하고 적절한 외래 키 관계를 설정한 후 각 테이블의 구조를 확인하세요.
*/