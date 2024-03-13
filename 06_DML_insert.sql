use bookshopdb;
-- DML: Data Manipulation Language
-- bookshopdb 사용 : 데이터 삽입

-- insert into 테이블명 (필드명,..,..) values(값1,값2,..)
insert into publisher(pubNo, pubName) values('1','강남출판사');
insert into publisher(pubNo, pubName) values('2','강북출판사');
insert into publisher(pubNo, pubName) values('3','서초출판사');

-- select 열 from 테이블: 테이블 조회
select * from publisher;

insert into book(bookNo, bookName, bookPrice, bookDate, pubNo) values('1', '자바', 20000, '2020-12-12', '1');
insert into book values('2', '자바스크립트', 15000, '2020-01-12', '2'),
		('3', '통계학개론', 30000, '2021-02-02', '3'),
		('4', '알고리즘', 35000, '2023-05-30', '2'),
		('5', '데이터분석', 10000, '2023-11-20', '1'),
		('6', '웹프로그래밍', 25000, '2019-09-15', '3');
insert into book values('7', '자바스크립트', 15000, '2020-01-12', '2'),
		('8', '통계학개론', 30000, '2021-02-02', '3'),
		('9', '알고리즘', 35000, '2023-05-30', '2'),
		('10', '데이터분석', 10000, '2023-11-20', '1');
select * from book;
