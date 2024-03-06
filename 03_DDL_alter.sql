use testdb2;
-- alter table: add -> 열추가 / rename column -> 열의 이름 변경 / modify -> 열의 데이터 형식 변경
-- drop column -> 열 삭제 / drop -> 여러개의 열 삭제 / drop primary key -> 기본키 삭제 / drop constraint -> 제약조건 삭제
-- add constraint: 제약조건 추가 / alter 열이름 set default 값: 기본값 변경 / alter 열이름 drop default: 기본값 삭제

-- student table에 열추가 -> alter
alter table student add stdTel varchar(13);

-- student table의 여러개 열을 한번에 추가: stdAge, stdAddr2
alter table student add (stdAge char(2), stdAddr2 varchar(30));

-- modify 열이름 데이터 형식: 데이터 형식 변경
alter table student modify stdAge int;

-- modify 열이름 데이터 형식 제약조건: 데이터 제약조건과 형식 변경  
alter table student modify stName varchar(20) null;


-- rename column 기존이름 to 바꿀 이름:  열의 이름 변경 
alter table student rename column stdTel to stdHp;

-- change 기존 열이름 바꿀 열이름 바꿀 타입: 열이름과 타입 변경
alter table student change stAddr stdAddr1 varchar(30);

-- drop column 열이름: 열 삭제
alter table student drop column stdHp;

-- drop 열이름, drop 열이름,...: 여러개의 열 삭제
alter table student drop stdAge,
					drop stdAddr1, 
                    drop stdAddr2;

-- drop primary key: 기본키 삭제 
alter table department drop primary key;
-- 외래키로 참조하고 있는 student, professor table이 있어서 삭제불가
-- 먼저 외래키로 사용하고 있는 테이블에서 제약조건 삭제해야함

-- drop constraint 별칭: 외래키 삭제
alter table student drop constraint FK_student_department;
alter table professor drop constraint FK_pro_department;
alter table department drop primary key;

-- add constraint: 제약조건 추가
alter table department add constraint PK_department_depNum primary key(depNum);
-- add: 별칭 없이 할 때
alter table department add primary key(depNum);
-- add foreign key (필드) references 테이블(필드)
alter table student add foreign key(depNum) references department(depNum);
-- 별칭 추가
alter table student add constraint FK_stu_dep foreign key(depNum) references department(depNum);

alter table student drop constraint FK_stu_dep;
-- on delete cascade
-- -> 외래키의 부모키의 row가 삭제되었을 때 외래키를 받은 테이블의 삭제된 row의 값을 가진 데이터들이 자동으로 삭제
alter table student 
	add constraint FK_stu_depart foreign key(depNum) references department(depNum)
	on delete cascade;

-- 모든 제약조건 출력
select * from information_schema.table_constraints;
-- 내가 사용한 제약조건 출력
select * from information_schema.table_constraints
	where table_schema='testdb2' and table_name='student';

-- testdb1 테이블의 book 테이블의 check 제약 확인
select * from information_schema.table_constraints
 	where table_schema='testdb1';
-- check 제약 삭제 후 조건 변경
alter table testdb1.book drop constraint book_chk_1;
alter table testdb1.book add check(bookPrice > 100);    
select * from information_schema.table_constraints
 	where table_schema='testdb1';

alter table testdb1.book alter column bookPrice set default 1000;
alter table testdb1.book alter column bookPrice drop default;
