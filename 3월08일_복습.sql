/*
03/07 저리

DML : 데이터조작언어
데이터 삽입 / 갱신 / 삭제 / 조회

테이블 = 관계/개체 (원자형태 => 정규화)
행(row) : 레코드, 튜플, 카디널리티
열(column) : 속성, 필드, 차수
키(key) : 주키(PK), 후보키, 대체키, 외래키(FK), 슈퍼키(복합키)

1. 데이터 삽입
INSERT INTO 테이블명 (열이름리스트)  VALUES (값리스트);

INSERT INTO 테이블명 (열이름리스트)
	 VALUES (값리스트),
	 VALUES (값리스트),
	 VALUES (값리스트);

2. 데이터 갱신
UPDATE 테이블명 SET 열=값 WHERE 조건;


3. 데이터 삭제
DELETE FROM 테이블명 WHERE 조건;

4. 데이터 조회
SELECT [ALL | DISTINCT] 열이름 리스트  (5)
	FROM 테이블명   (1)
	WHERE 검색조건(들)  (2)
	GROUP BY 열이름     (3)
	HAVING 검색조건(들) (4)
	ORDER BY 열이름1 [ASC┃ | DESC], 열이름2 [ASC┃ | DESC]  (6)

검색조건에서 사용되는 연산자
 (1) 비교 : = != > < >= <=
 (2) 범위 : between A and B, not between A and B
 (3) 멤버 :  in (  ), not in( )
 (4) NULL :  is NULL , is not NULL
 (5) 논리 :  and, or, xor
 (6) 패턴매칭 : LIKE '패턴'  => 와일드카드 _  %
*/

