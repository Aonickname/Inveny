#Inveny - 재고 관리 시스템

Inveny는 복잡한 재고 관리를 손쉽게 할 수 있도록 돕는 서비스입니다.  
백엔드는 Spring Boot, 프론트엔드는 Flutter를 사용하여 제작되었습니다.

---

## 주요 기능
* 실시간 재고 조회: 서버에 저장된 모든 재고 목록을 한눈에 확인합니다.
* 재고 등록: 새로운 물품을 쉽고 빠르게 데이터베이스에 추가합니다.
* 정보 수정 및 업데이트: 물품의 수량이나 정보를 실시간으로 수정합니다.
* 재고 삭제: 더 이상 필요 없는 재고 데이터를 안전하게 삭제합니다.

## 기술 스택

### [Backend]
* Language: Java 21
* Framework: Spring Boot 3.5.9
* Database: MySQL
* ORM: Spring Data JPA

### [Frontend]
* Language: Dart
* Framework: Flutter
* Library: http, flutter_dotenv

---

## 시작하기 (Setup)

이 프로젝트를 로컬 환경에서 실행하려면 아래 설정이 필요합니다.

### 1. 백엔드 설정
`src/main/resources/application.properties` 파일을 생성하고 아래 내용을 입력하세요.
(샘플 파일인 `application.properties.sample`을 참고하세요.)

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/inveny_db
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD
