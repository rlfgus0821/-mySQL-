-- 1. 데이터베이스를 생성하시오
create database marketdb char set utf8mb4;
use marketdb;
-- 2. 다음의 테이블들을 정의하여 생성하고, 데이터를 입력할 때 insert문을 사용하여 입력하시오
create table membertype(
	membertype_id int not null,
    membertype varchar(5) not null,
    primary key(membertype_id));

create table customer(
	customer_id int not null,
    customer_name varchar(45) not null,
    birthday date,
    membertype_id int Not null,
    constraint FK_customer_membertype 
    foreign key(membertype_id) references membertype(membertype_id),
    primary key(customer_id));

create table product(
	product_id int not null,
    customer_name varchar(20) not null,
    stock int default 0,
    price int default 100 check(price>=0),
    primary key(product_id)
    );

create table productOrder(
	order_id int not null,
    customer_id int not null,
    product_id int not null,
    quantity int not null,
    price int not null,
    order_time datetime,
    constraint FK_proOrder_customer foreign key(customer_id)
    references customer(customer_id),
    constraint FK_proOrder_product foreign key(product_id)
    references product(product_id),
    primary key(order_id));
    
insert into membertype values(1, '보통 회원'), (2, '할인 회원');

insert into customer values(1, '김바람', '1984-06-24',2),
	(2, '이구름', '1990-07-16',1),
    (3, '박하늘', '1976-03-09',2),
    (4, '강산', '1991-05-04',1),
    (5, '유바다', '1993-04-21',2);

insert into product values(1, '약용 입욕제', 100, 70),
	(2, '약용 핸드솝', 23, 700),
    (3, '천연 아로마 입욕제', 4, 120),
    (4, '거품 목욕제', 23, 120);
    
insert into productOrder values(1, 4, 1, 12, 840, '2019-10-13 12:01:34'),
	(2, 5, 3, 5, 600,'2019-10-13 18:11:05'),
    (3, 2, 2, 2, 1400,'2019-10-14 10:43:54'),
    (4, 3, 2, 1, 700,'2019-10-15 23:15:09'),
    (5, 1, 4, 3, 360,'2019-10-15 23:37:11'),
    (6, 5, 2, 1, 700,'2019-10-16 -1:23:28'),
    (7, 1, 4, 2, 300,'2019-10-18 12:42:50');
-- 1) 고객테이블에 성별, 나이, 전화번호 컬럼을 추가하고, 성별은 ‘F’, ‘M’의 형식이 입력되게하고, 나이는 0살 이상 입력되도록 설정   
alter table customer 
	add column Sex varchar(5) check (sex = 'F' or sex = 'M'),
    add column Age int check (age >= 0),
    add column Tel varchar(20);

-- 2) 고객 테이블에 데이터 3개 정도 삽입     
insert into customer
values (6, '홍길동', '1990-01-01', 1, 'M', 20, '010-2222-1111'),
		(7, '심청이', '1990-01-01', 2, 'F', 20, '010-1234-1111'),
		(8, '이몽룡', '1990-01-01', 1, 'M', 20, '010-5555-1111');
        
-- 3) 고객명이 ‘홍길동’인 고객의 전화번호를 수정(값은 임의의 번호로     
update customer set Tel = '010-1234-5678' where customer_name = '홍길동';
-- 4) 나이가 20살 미만이 고객을 삭제
delete from customer where Age < 20;
-- 5) 고객 테이블에서 고객명, 생년월일, 성별 조회 
select customer_name, birthday, Sex from customer;
-- 6) 고객 테이블에서 주소만 검색하여 조회 (중복되는 주소는 한번만 출력)
select distinct customer_id from customer;
-- 7) 고객 테이블에서 취미가 '축구'이거나 '등산'인 고객의 고객명, 취미 조회
alter table customer
	add column Hobby varchar(30);
select customer_name, Hobby from customer where Hobby = '축구' or Hobby = '등산';
