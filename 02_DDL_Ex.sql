-- 연습문제: 학생과 학과 테이블 생성하고 데이터 입력
create table testdb2.department(
	depNum varchar(10) not null primary key,
    depName varchar(15) not null,
    Phone varchar(30)
    );
    
create table testdb2.student(
	stNum int primary key,
    stName varchar(5) not null,
    stGra int check(stGra > 0 and stGra < 5),
    stAddr varchar(30),
    stBirt date,
    depNum varchar(10) not null,
    constraint FK_student_department foreign key(depNum) references department(depNum)
);

CREATE TABLE testdb2.professor (
    proNo CHAR(10) NOT NULL PRIMARY KEY,
    proName VARCHAR(30) NOT NULL,
    proPhone CHAR(20),
    depNum CHAR(10) NOT NULL,
    CONSTRAINT FK_pro_department FOREIGN KEY (depNum) REFERENCES department (depNum)
);

CREATE TABLE testdb2.course (
	courseCode CHAR(10) NOT NULL PRIMARY KEY,
    courseName VARCHAR(30) NOT NULL,
    courseCredit INT DEFAULT 3 CHECK (courseCredit >= 1 and courseCredit <= 6),
    proNo CHAR(10) NOT NULL,
    CONSTRAINT FK_course_professor FOREIGN KEY (proNo) REFERENCES professor (proNo)
);
--주키를 복합키로 지정
create table testdb2.scores(
	stNum int not null, 
    courseCode char(10) not null,
    score int default 0 not null check(score >=0 and score <= 100),
    grade char(10) not null,
    constraint PK_scores_stNum_courseCode primary key (stNum, courseCode),
	constraint FK_scores_student foreign Key (stNum) references student(stNum),
    constraint FP_scored_course foreign Key (courseCode) references course(courseCode)
);
-- 자동으로 아이디나 값이 증가: auto_increment
create table testdb2.board(
	boardNo int auto_increment not null primary key,
    boardTitle varchar(30) not null,
    boardAuthor varchar(20) not null,
    boardContent varchar(100) not null
    );

-- alter: 데이터베이스, 테이블, 뷰등의 정보 수정(변경)
-- 100부터 시작하게 설정
alter table testdb2.board auto_increment = 100;
-- 증가율을 3씩 증가하게 세팅
set @@auto_increment_increment = 3;

-- @변수이름 = -> 변수 설정
-- update문을 이용하여 게시판 boardNo 값을 일괄적으로 변경 
set @count = 0;
update testdb2.board set boardNo= @count :=@conut+1;