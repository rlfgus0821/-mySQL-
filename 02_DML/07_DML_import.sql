-- table data import wizard를 이용하여 테이블 생성
-- 1. Navigator에서 DB 선택하고 우클릭하여 [Table Data import Wizard]선택
-- 2. import하려는 데이터 경로 선택
-- 3. 테이블 이름과 필드명, 데이터 형식 수정, 선택
-- 4. 데이터 임포트 실행
-- 5. 테이블 생성 확인

use bookshopdb;

desc bookshopdb.product;
-- 파일 임포트하면 제약조건이 없음
alter table product 
	modify prdNo varchar(10) not null;

alter table product 
	add constraint PK_product_prdNo primary key(prdNo);

alter table product 
modify prdName varchar(20),
	modify prdMaker varchar(30),
	modify prdColor varchar(10),
    modify ctgNo varchar(10);

desc product;

-- import 연습
use bookshopdb;

select * from productorder;

alter table productorder 
	add constraint PK_proder_order_id primary key(order_id);

alter table productorder 
 	modify order_time date not null,
	modify customer_id varchar(30) not null,
	modify product_id varchar(30) not null,
    modify price int default 0,
    modify order_id varchar(15) not null;

alter table productorder 
	add constraint FK_proorder_product foreign key(product_id) references product(prdNo);

alter table productorder 
	modify order_id int not null;
desc productorder;