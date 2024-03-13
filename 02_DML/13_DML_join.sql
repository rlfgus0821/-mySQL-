-- 테이블 결합: union | union all | inner join | outer join
use bookdb;

select * from book 
	where pubNo ='1'
union
select * from book 
	where pubNo ='2';

-- 내부조인(Inner join)
-- 형식1: from 테이블1, 테이블2 where 테이블1.칼럼명 = 테이블2.칼럼명
select book.pubNo, pubName, bookName, bookAuthor, bookPrice
	from book, publisher
    where book. pubNo = publisher.pubNo
    order by pubNo;

-- 형식2: join -> from 테이블1 (별칭)join 테이블2 (별칭)on 테이블1.칼럼명 = 테이블2.칼럼명
-- bookClient와 bookSale을 조인하여 clientName 제시
select BC.clientNo, BC.clientName, BS.bsQty
		from bookCLient BC
        join bookSale BS on BC.clientNo = BS.clientNo;

-- 고객별로 총 주문수량을 계산하여 총 주문수량의 내림차순으로 고객번호, 고객이름, 총 주문수량 조회
select distinct BC.clientNo, BC.clientName, sum(BS.bsQty) as '총 주문수량'
	from bookCLient BC join bookSale BS on BC.clientNo = BS.clientNo
	group by BC.clientNo 
    order by '총 주문수량' desc;

-- 주문한 도서(bookSale)의 고객명(bookClient)과 도서명(book) 출력
select BC.clientName, B.bookName
	from bookSale BS
    join bookClient BC on BS.clientNo = BC.clientNo
    join book B on BS.bookNo = B.bookNo;

-- 주문한 도서(bookSale)의 고객명(bookClient)과 도서명(book), 주문정보 출력
select BS.bsNo, BS.bsDate, BC.clientNo, BC.clientName, B.bookName, BS.bsQty
	from bookSale BS
    join bookClient BC on BS.clientNo = BC.clientNo
    join book B on BS.bookNo = B.bookNo;


-- 주문한 도서(bookSale)의 고객명(bookClient)과 도서명(book), 주문정보, 주문량 출력
select BS.bsNo, BS.bsDate, BC.clientNo, BC.clientName, B.bookName, BS.bsQty, BSbsQty*B.bookPrice as 주문액
	from bookSale BS
    join bookClient BC on BS.clientNo = BC.clientNo
    join book B on BS.bookNo = B.bookNo
    order by 주문액 desc
    limit 3;

    -- 외부조인(outer join): 공통된 속성을 매개로 결합하되 정보가 없는 레코드도 추가
-- 1. 좌측 외부조인: 좌측의 테이블 정보 유지
select * 
	from bookClient BC
		left outer join bookSale Bs
        on BS.clientNo = BC.clientNo;
-- 2. 우측 외부조인: 우측의 테이블 정보 유지
select * 
	from bookClient BC
		right outer join bookSale Bs
        on BS.clientNo = BC.clientNo;
-- 3. 완전 외부조인: 두 테이블 정보 유지 / 좌측조인과 우측조인을 union
select * 
	from bookClient BC
		left outer join bookSale Bs
        on BS.clientNo = BC.clientNo
union
select * 
	from bookClient BC
		right outer join bookSale BS
        on BS.clientNo = BC.clientNo;

-- 구매이력이 없는 회원의 정보 조회
select BC.clientNo, BC.clientName
	 from bookClient BC
     left outer join bookSale BS on BS.clientNo = BC.clientNo
	where BS.clientNo is null
    order by BC.clientBirth;
