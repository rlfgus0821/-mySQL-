-- 집계 함수: max(필드명), min(필드명), avg(필드명), sum(필드명), round(필드명), count(필드명)
use bookshopdb;

select * from product;

select count(prdPrice) as '총 제품수',
	sum(prdPrice) as '가격 총액',
	round(avg(prdPrice),2) as 평균가격,
	min(prdPrice) as 최저가,
    max(prdPrice) as 최고가
    from product;
    
select count(bookAuthor) as '저자 수',
	count(*) as '도서 개수',
	min(bookPrice) as 최저가,
    max(bookPrice) as 최고가
	from book;

select count(prdName)
	from product 
    where prdName like '%노트북%';
    
-- 그룹별 집계 : group by / having
-- select 집약키필드명, 집계함수적용, .... from where 조건 group by 집약키필드명;
-- grouop by에 사용하는 필드 => 집계를 위한 키, 집약키    

select * from book
	order by pubNo;

select pubNo, count(pubNo), sum(bookPrice) 
	from book
    group by pubNo;
    
-- productorder 테이블에서 고객별 주문총액과 평균주문액 출력
select customer_id, 
	count(quantity) as 주문횟수,
    sum(quantity) as '주문총량', 
    avg(quantity) as 평균주문량
	from productorder
	group by customer_id
    # with rollup
    order by 평균주문량;