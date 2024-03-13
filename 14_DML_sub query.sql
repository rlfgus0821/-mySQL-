use bookdb;

-- 서브쿼리(subquery): 부속질의 / 메인쿼리와 서브쿼리로 구성
-- 단일행 서브쿼리 | 다중행 서브쿼리
-- where 절에 사용하는 서브쿼리 연산자
-- 비교: = < <= > >= != (단일행 반환)
-- 집합: in, not in (다중행 반환)
-- 존재: exists, not exists (다중행 반환)
-- 한정: any, all (다중행 반환)

-- 고객 호날두가 주문한 수량을 조회
-- inner join
select BS.bsDate, BS.bsQty, BC.clientNo, BC.clientName
	from bookSale BS join bookClient BC on BS.clientNo = BC.clientNo
    where BC.clientName = '호날두';
-- subquery: 단일행 서브쿼리
select bsDate, bsQty
	from bookSale
    where clientNo = ( select clientNo from bookClient where clientName = '호날두');

-- 호날두가 주문한 총 주문량 출력
select sum(bsQty) as '총 주문량'
	from bookSale
    where clientNo = ( select clientNo from bookClient where clientName = '호날두');

-- 가장 비싼 도서의 도서명과 가격 조회
select bookName, bookPrice
	from book
		where bookPrice = (select max(bookPrice) from book);
	
-- 평균 도서 가격보다 비싼 도서의 도서명과 도서가격 조회
select bookName, bookPrice
	from book
		where bookPrice > (select avg(bookPrice) from book);


-- 다중행 서브쿼리: in ,not in

-- 도서 구매이력이 있는 고객명 조회
select clientName
from bookClient
where clientNo in (select distinct clientNo from bookSale);

-- 도서 구매이력이 없는 고객명 조회
select clientName
from bookClient
where clientNo not in (select distinct clientNo from bookSale);

-- 도서명이 '자료구조'를 구매한 고객의 이름과 연락처 조회
select clientName, clientPhone
from bookClient
where clientNo in (select clientNo from bookSale where bookNo =(select bookNo from book where bookName = '자료구조'));

-- 다중행 서브쿼리: exists, not exists
-- 도서 구매이력이 있는 고객명 조회
select clientName
from bookClient
where exists (select clientNo from bookSale where bookClient.clientNo = bookSale.clientNo);

-- exists: 서브쿼리 결과에 null값 포함
select clientNo
from bookClient
where exists (select clientHobby from bookCLient);

-- in: 서브쿼리 결과에 null값 포함x
select clientNo
from bookClient
where clientHobby in (select clientHobby from bookCLient);

-- 다중형 서브쿼리: all | any
select clientNo, bsNo, bsQty
	from bookSale
    where bsQty > all(select bsQty from bookSale where client = '2');
