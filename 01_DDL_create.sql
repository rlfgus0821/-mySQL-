/*
   여러 줄 주석
*/
-- 여러줄 주석 ctrl+/
-- --한줄주석

-- 스키마 생성 & 삭제
drop schema testdb1;
drop database testdb2;

create schema testdb1 default character set utf8mb4;
create database testdb2 default character set utf8mb4;

use testdb1;

-- 상품 테이블 생성: 제품아이디, 제품명, 제품가격, 제조사
-- 제약조건: 기본키 -> 제품아이디

create table product(
	prdId varchar(10) not null primary key,
	prdName varchar(30) not null,
	prdPrice int,
	prdCompany varchar(30)
	);
    
-- primary key를 마지막에 사용하면 가독성 up        
create table product1(
	prdId varchar(10) not null,
    prdName varchar(30) not null,
    prdPrice int,
    prdCompany varchar(30),
    primary key(prdId)
	);
    
-- primary key를 constraint를 활용해 별칭 부여    
create table product2(
	prdId varchar(10) not null,
    prdName varchar(30) not null,
    prdPrice int,
    prdCompany varchar(30),
    constraint PK_product2_prdId primary key(prdId)
	);

-- 도서 관련 테이블 / 스키마.테이블이름으로 생성하면 use사용x
create table testdb1.publisher(
	pubNo varchar(10) not null primary key,
    pubName varchar(30) not null
); 
-- 외래키(foreign key)생성 및 제약조건 설정 및 constraint로 별칭 부여
create table book(
	bookNo varchar(10) not null primary key,
    bookName varchar(30) not null,
    bookPrice int default 10000 check(bookPrice > 1000),
    bookDate date,
    pubNo varchar(10) not null,
    constraint FK_book_publisher foreign key(pubNo) references publisher(pubNo)
    );
-- 테이블 형태 알아보기
describe testdb1.book;
describe testdb1.publisher;

-- [참조 무결성 제약조건]
-- 외래키를 갖는 테이블에 값을 삽입, 삭제, 수정 시 실행불가 
-- => 외래키를 갖는 데이터를 수정불가하도록 지정되어 있음 => onupdate가 Restrict로 지정되어 있기 때문
-- 외래키를 주키로 하는 테이블에서 수정해야한다.
-- 외래키를 주키로 사용하는 테이블 삭제 시:
-- => 외래키를 사용하는 테이블을 먼저 삭제 -> 외래키를 주키로 하는 테이블 삭제