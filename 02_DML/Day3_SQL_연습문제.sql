use bookdb;
/*
drop database if exists bookdb ;
create database bookdb char set utf8mb4;

alter table publisher 
	modify pubNo varchar(10) not null primary key, 
	modify pubName varchar(20);

alter table book
	modify bookNo varchar(10) not null primary key,
	modify bookName varchar(20),
    modify bookAuthor varchar(30),
    modify bookDate date,
    modify pubNo varchar(10) not null,
    add constraint FK_book_publisher foreign key(pubNo) references publisher(pubNo);

 alter table bookClient
	modify clientNo varchar(10) not null primary key,
    modify clientName varchar(30),
    modify clientPhone varchar(13),
    modify clientAddress varchar(50),
    modify clientBirth date,
    modify clientHobby varchar(30),
    modify clientGender varchar(1);

 alter table bookSale
	modify bsNo varchar(10) not null primary key,
    modify bsDate date,
    modify clientNo varchar(10) not null,
    modify bookNo varchar(10) not null,
    add constraint FK_bookSale_bookClient foreign key(clientNo) references bookclient(clientNo),
    add constraint FK_bookSale_book foreign key(bookNo) references book(bookNo);
*/

-- 1) 모든 도서에 대하여 도서의 도서번호, 도서명, 출판사명 조회
select B.bookNo, B.bookName, PS.pubName 
from book join publisher on B.pubNo = PS.pubNo;

-- 2) ‘서울 출판사'에서 출간한 도서의 도서명, 저자명, 출판사명 조회 (조건에 출판사명 사용)
select B.bookNAuthor, B.bookName, PS.pubName 
from book join publisher on B.pubNo = PS.pubNo where pubName = '서울 출판사';

-- 3) ’종로출판사'에서 출간한 도서 중 판매된 도서의 도서명 조회 (중복된 경우 한 번만 출력) (조건에 출판사명 사용)
select distinct B.bookName 
	from book as B 
    join bookSale as BS on B.bookNo = BS.bookNo 
	join publisher as PS on B.pubNo = PS.pubNo
    where pubName = '종로 출판사';

-- 4) 도서가격이 30,000원 이상인 도서를 주문한 고객의 고객명, 도서명, 도서가격, 주문수량 조회
select BC.clientName, B.bookName, B.bookPrice, BS.bsQty as '주문수량'
	from book B join booksale BS on B.bookNo = BS.bookNo
				join bookclient BC on BS.clientNo = BC.clientNo
	where B.bookPrice >= 30000;

-- 5) '안드로이드 프로그래밍' 도서를 구매한 고객에 대하여 도서명, 고객명, 성별, 주소 조회 (고객명으로 오름차순 정렬)
    select B.bookName, BC.clientName, BC.clientGender, BC.clientAddress
	from book B join booksale BS on B.bookNo = BS.bookNo
				join bookclient BC on BS.clientNo = BC.clientNo
	where B.bookName = '안드로이드 프로그래밍' order by clientName; 

-- 6) ‘도서출판 강남'에서 출간된 도서 중 판매된 도서에 대하여 ‘총 매출액’ 조회
select sum(B.bookPrice * BS.bsQty) as '총 매출액'
	from publisher PS join book B on PS.pubNo = B.pubNo
					 join booksale BS on B.bookNo = BS.bookNo
					where PS.pubName = '도서출판 강남';

-- 7) ‘서울 출판사'에서 출간된 도서에 대하여 판매일, 출판사명, 도서명, 도서가격, 주문수량, 주문액 조회
    select BS.bsDate, PS.pubNo, B.bookName, BS.bsQty, B.bookPrice * BS.bsQty as '주문액'
	from publisher PS	join book B on PS.pubNo = B.pubNo
						join booksale BS on B.bookNo = BS.bookNo
    where PS.pubName = '서울 출판사';

-- 8) 판매된 도서에 대하여 도서별로 도서번호, 도서명, 총 주문 수량 조회
select B.bookNo, B.bookName, sum(BS.bsQty) as '총 주문 수량'
	from book B join booksale BS on B.bookNo = BS.bookNo
    group by B.bookNo;
    
-- 9) 판매된 도서에 대하여 고객별로 고객명, 총구매액 조회 ( 총구매액이 100,000원 이상인 경우만 해당)
select BC.clientName, (B.bookPrice * BS.bsQty) as '총 구매액'
	from book B	join bookSale BS on B.bookNo = BS.bookNo
				join bookClient BC on BS.clientNo = BC.clientNo
    group by BC.clientNo, '총 구매액' having '총 구매액' >= 100000;

-- 10) 판매(bookSale)된 도서 중 ＇도서출판 강남'(publisher)에서 출간한 도서에 대하여 고객명, 주문일, 도서명, 주문수량, 출판사명 조회 (고객명으로 오름차순 정렬)
select BC.clientName, BS.bsDate, B.bookName, BS.bsQty, PS.pubName 
	from bookClient BC 
    join bookSale BS on BC.clientNo = BS.clientNo
    join book B on BS.bookNo = B.bookNo
    join publisher PS on PS.pubNo = B.pubNo
    where pubName ='도서출판 강남'
    order by clientName;

-- 11) 호날두(고객명)가 주문한 도서의 총 구매량 조회
select clientName, sum(bsQty) as '총 구매량' 
	from bookClient BC join bookSale BS on BC.clientNo = BS.clientNo
    where clientName='호날두';

-- 12) ‘종로출판사’에서 출간한 도서를 구매한 적이 있는 고객명 조회
select clientName from bookClient where clientNo in 
(select clientNo from bookSale 
	where bookNo in 
		(select bookNo from book where pubNo in 
			(select pubNo from publisher where pubName = '종로 출판사')));

-- 13) 베컴(client)이 주문한 최고 주문수량(bookSale) 보다 더 많은 도서를 구매한 고객명 조회
select clientName from bookClient where clientNo in
    (select clientNo from bookSale where bsQty > 
		(select max(bsQty) from bookSale where clientNo = 
			(select clientNo from bookClient where clientName = '베컴')));

-- 14) 서울에 거주하는 고객(client)에게 판매한 도서(bookSale)의 총 판매량 조회
select sum(bsQty) as '총 판매량' 
	from bookSale BS join bookClient BC on BC.clientNo = BS.clientNo
    where clientAddress = '%서울%';

-- 15) ‘정보출판사’에서 출간한 도서를 구매한 적이 있는 고객명 조회
select clientName from bookClient where clientNo in 
	(select clientNo from bookSale where bookNo in 
		(select bookNo from book where pubNo in 
			(select pubNo from publisher where pubName = '정보출판사')));
