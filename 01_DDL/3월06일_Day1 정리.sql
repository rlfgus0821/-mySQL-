-- DDL : CREATE / ALTER  / DROP

-- 1. 데이터 베이스 생성

CREATE DATABASE 데이터베이스이름 character set utf8mb4;
CREATE SCHEMA 데이터베이스이름 character set utf8mb4 collate utf8mb4_unicode_ci;


-- 2. 테이블 생성

-- CREATE TABLE 스키마명.테이블명 ( 
--     열이름1 데이터타입 [PRIMARY KEY] [NOT NULL]  [UNIQUE] ,
--     열이름2 데이터타입 [AUTO_INCREMENT] ,
--     열이름3 데이터타입 [DEFAULT 기본값] [CHECK 체크조건] ,
--   [ 
--     CONSTRAINT명 
--     주키제약이름  PRIMARY KEY 열이름
--     외래키제약이름  FOREIGN KEY 열이름 REFERENCES 테이블명(열이름),
--     on delete [CASCADE | RESTRICT]
--     on update [CASCADE | RESTRICT] ]
-- ) CHARSET=utf8; 

-- create table 테이블명 (
-- 	[column_name1] INT AUTO_INCREMENT,    
-- 	[column_name2] VARCHAR(255) NOT NULL,
-- 	[column_name3] DATETIME NOT NULL,
-- 	CONSTRAINT PRIMARY KEY 
-- ) CHARSET=utf8;


-- 3. 테이블 변경

-- 테이블에 컬럼 추가하기
-- ALTER TABLE [table_name] ADD COLUMN [column_name] [column_type]; 

-- 테이블의 컬럼 타입 변경하기
-- ALTER TABLE [table_name] MODIFY COLUMN [column_name] [column_type]; 

-- 테이블의 컬림 이름 변경하기
-- ALTER TABLE [table_name] CHANGE COLUMN [old_column_name] [new_column_name] [new_column_type];

-- 테이블의 컬럼 삭제하기
-- ALTER TABLE [table_name] DROP COLUMN [column_name]; 

-- 테이블에 컬럼 인덱스 삭제
-- ALTER TABLE [table_name] DROP INDEX [index_name];

-- 테이블에 제약조건 삭제
-- ALTER TABLE [table_name] DROP CONSTRAINT 제약조건이름;

-- 테이블에 제약조건 추가
-- ALTER TABLE [table_name] ADD CONSTRAINT  제약조건형식;

-- 테이블에 PRIMARY KEY 만들기
-- ALTER TABLE [table_name] ADD PRIMARY KEY( column_name_on_this_table ); 

-- 테이블에 PRIMARY KEY 삭제하기
-- ALTER TABLE [table_name] DROP PRIMARY KEY; 

-- 테이블 명 바꾸기
-- ALTER TABLE [old_table_name] RENAME [new_table_name];


-- [참고] 제약조건 확인
select * from information_schema.table_constraints
	where table_schema='데이터베이스명' and table_name='테이블명';


-- 4. 테이블 삭제하기

DROP TABLE 테이블명;

