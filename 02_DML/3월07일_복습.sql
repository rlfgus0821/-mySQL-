-- 03/06 복습

-- if exists = 있다면~
drop database if exists shopdb;
drop database if exists testdb1;
drop database if exists testdb2;
drop database if exists testdb;

-- DB 생성
create schema bookshopdb default char set utf8mb4;

-- tale 생성: 도서 book, 출판사 publisher
use bookshopdb;

create table bookshopdb.publisher(
	pubNo varchar(10) not null,
    pubName varchar(30) not null,
    primary key(pubNo)
    );

create table bookshopdb.book(
	bookNo varchar(10) not null,
    bookName varchar(30) not null,
    bookPrice int default 10000 check(bookPrice > 1000),
    bookDate date,
    pubNo varchar(10) not null,
    constraint FK_book_publisher foreign key(pubNo) references publisher(pubNo),
    primary key(bookNo)
   );
describe publisher;
describe book;

-- 학사관리 시스템 DB: schooldb 생성
create database schooldb char set utf8mb4;
create table schooldb.department(
	depCode char(10) not null,
    depName varchar(15) not null,
    depTel varchar(15),
    primary key(depCode)
    );
    
create table schooldb.student(
	stdId varchar(10) not null,
    stdName varchar(15) not null,
    stdYear int default 1 check (stdYear>=1 and stdYear <= 4),
    stdBirth date,
    depCode char(10) not null,
    constraint FK_student_department foreign key (depCode) references department(depCode),
    primary key(stdId)
    );

create table schooldb.professor(
	proNo char(10) not null,
    proName varchar(30) not null,
    proPhone char(20),
    depCode char(10) not null,
    constraint FK_professor_department foreign key(depCode) references department(depCode),
    primary key(proNo)
    );
    
create table schooldb.course(
	courseCode char(10) not null,
	courseName varchar(30) not null,
    courseCredit int default 3 check (courseCredit >= 1 and courseCredit <= 6),
    proNo char(10) not null,
    constraint FK_course_professor foreign key(proNo) references professor(proNo),
    primary key(courseCode)
    );
    
create table schooldb.scores(
	stdId varchar(10) not null,
    courseCode char(10) not null,
    score int default 0 check(score>=0 and score<=100),
    grade char(10) not null,
    constraint PK_scores_std_course primary key(stdId,courseCode),
    constraint FK_scores_std foreign key (stdId) references student(stdId),
    constraint FK_scores_course foreign key (courseCode) references course(courseCode)
    );
    
create table schooldb.board(
	boardNo int auto_increment not null,
    boardTitle varchar(30) not null,
    boardAuthor Varchar(20) not null,
    boardContent varchar(100) not null,
    primary key(boardNo)
    );

-- 테이블 변경(alter)    
alter table board auto_increment = 100;
set @@auto_increment_increment = 2;
set @count = 0;
update board set boardNo = @count := @count +1;