--한줄짜리 주석
/*
여러줄 주석 
*/

--현재 모든 계정들에 대해서 조회화는 명령문.

SELECT * FROM DBA_USERS;--이코드는 관리자계정으로 들어왔기떄문에 보인다.
--CTRL + ENTER : 명령문 하나씩 실행,~ 위쪽 재생버튼 클릭. 

--일반사용자계정 생성하는구문.(오로지 관리자계정에서만 가능)
--표현법: CREATE USER 계정명 IDENTIFIED BY 비밀번호;

CREATE USER kh IDENTIFIED BY kh;--계정명은 대소문자 안가리지만 비밀번호는 인식해서구별함.
--계정 추가해보니 오류발생
--위에서 생성한 일반사용자계정에게 최소한의 권한부여해야지만 생성됨.

--권한부여 표현법 : GRANT 권한1, 권한2, ... TO 계정명

GRANT CONNECT, RESOURCE TO kh;










