-- Having 절
use bookshopdb;

-- having절은 group by의 조건

select pubNo, count(*)as '도서 수 합계' 
	from book where bookPrice >= 25000
    group by pubNo
	having count(*) >= 2
    order by pubNo;

-- Ex) 1. 도서 테이블에서 가격 순으로 내림차순 정렬하여, 도서명, 저자, 가격 출력(가격이 같으면 저자순으로 오름차순 정렬)
select bookName, bookAuthor, bookPrice from book 
	order by bookPrice desc, bookAuthor;
-- Ex) 2. 도서 테이블에서 저자에 '길동'이 들어가는 도서의 총 재고 수량을 계산하여 출력
select count(*) as '길동 in 총 재고 수량' from book
where bookAuthor like '%길동%';

-- Ex) 3. 도서 테이블에서 '서울 출판사'도서 중 최고가와 최저가 출력
select count(pubNo) as '총 개수', 
min(pubNo) as '최저가',
max(pubNo) as '최고가'
from book where pubNo = 2;

-- Ex) 4. 도서 테이블에서 출판사별로 총 재고수량과 평균 재고 수량을 계산하여 출력(총 재고수량으로 내림차순 정렬)
select pubNo,count(*) as '총 재고수량', avg(pubNo) as '평균 재고 수량' from book 
group by pubNo 
order by count(*) desc;

-- Ex) 5. 도서판매 테이블에서 고객별로 '총 주문수량'과 '총 주문건수' 출력, 단 주문 건수가 2이상인 고객만 해당
select * from productorder;
select customer_id, sum(quantity) as'총 주문수량', count(order_id) as '총 주문건수' from productorder 
	 group by customer_id having count(order_id) >= 2
     order by customer_id;
