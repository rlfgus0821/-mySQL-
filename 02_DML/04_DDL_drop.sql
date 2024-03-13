-- 테이블 형식 보기: describe 테이블 이름;
-- 테이블 삭제: drop table [purge | cascade constraints];
-- 테이블의 레코드들만 삭제: delete (DML)

-- testdb1 스키마의 product2 테이블 삭제
-- drop table testdb1.product2; 

select foreign_key_checks;
drop table testdb1.publisher;