# 🧾 HR Management System – 인사·근태·휴가 관리 웹 애플리케이션

## 📌 프로젝트 개요

**프로젝트명:** HR Management System  
**개발 기간:** 2025.10 ~ (개인 프로젝트 진행 중)  
**목표:** 인사 및 근태·휴가·채용 관련 기능을 통합 관리할 수 있는 내부용 HR 플랫폼 구축  

**기획 배경:**  
직원 수가 많지 않은 중소기업이나 학습 조직에서도 근태 및 휴가 관리, 채용 기록 등을  
엑셀 대신 웹 기반으로 관리할 수 있도록 하기 위해 개발했습니다.

---

## 🚀 주요 기능

- **직원 관리:** 사원 등록/수정/퇴사처리 (부서, 직급, 권한별 관리)  
- **근태 관리:** 출퇴근 버튼, 근무기록 (지각/연장 자동 계산)  
- **휴가 관리:** 휴가 신청 및 승인 (잔여 연차 자동 계산)  
- **전자결재:** 휴가, 연장근무 등 결재 프로세스  
- **채용 관리:** 공고 등록 및 지원서(PDF) 업로드  
- **대시보드:** 근태 현황, 결재 대기, 잔여 연차 통계 시각화  
- **감사 로그:** 주요 행위 기록 (누가 언제 무엇을 했는지 추적)

---

## 🧱 시스템 아키텍처

Spring Boot (MVC)
├── Controller (Web Layer)
├── Service (Business Logic)
├── Mapper (MyBatis)
├── Domain (Entity/DTO)
└── JSP + Tailwind (View)

MariaDB ←→ MyBatis ←→ Spring Boot ←→ JSP (UI)


---

## 🗂 주요 테이블 (ERD 요약)

| 테이블 | 설명 |
|---------|------|
| **Employee** | 직원 정보 (권한, 부서, 잔여연차 등) |
| **Department** | 부서 정보 |
| **Attendance** | 출퇴근, 근태 기록 |
| **Approvals / Requests** | 휴가 신청 및 결재 상태 |
| **JobPosting / Application** | 채용 공고 및 지원서 |
| **AuditLog** | 주요 행위 기록 |

---

## 🧩 기술 스택

| 구분 | 내용 |
|------|------|
| **Language** | Java 21 |
| **Framework** | Spring Boot 3.x, Spring Security, MyBatis |
| **Database** | MariaDB |
| **Build Tool** | Gradle |
| **View** | JSP, JSTL, TailwindCSS |
| **Infra** | AWS EC2, Nginx, S3 (이력서 업로드) |
| **VCS** | Git / GitHub |
| **CI/CD** | GitHub Actions |
| **Test** | JUnit5, Spring Boot Test |

---

## 🔐 권한 및 보안 구조

| 역할 | 권한 설명 |
|------|-----------|
| **Admin** | 전체 시스템 관리 (직원/부서/결재/채용) |
| **Manager** | 부서 내 직원 근태·휴가 승인 |
| **Employee** | 개인 근태 및 휴가 신청 |

**보안 기능:**  
- Spring Security 로그인/로그아웃  
- BCrypt 비밀번호 암호화  
- CSRF 보호 및 JSP 내 자동 토큰 삽입  
- Interceptor 기반 감사 로그 기록  

---

## 💻 주요 화면 구성

- 로그인 / 회원 관리  
- 근태 출퇴근 버튼 및 월별 리포트  
- 휴가 신청 / 승인 페이지  
- 관리자 대시보드  
- 채용 공고 / 지원 관리 페이지  

---

## 🎬 시연 시나리오 (Demo Flow)

1. **직원(emp01)** 로그인 → 출근 버튼 클릭  
2. **팀장(manager)** 로그인 → 직원의 휴가 신청 승인  
3. **관리자(admin)** 로그인 → 근태 집계 및 결재 로그 확인  
4. **지원자** → 채용 공고 등록 → 지원서 업로드 확인  

---

## 👥 기본 계정 (테스트용)

| 구분 | ID | PW | ROLE |
|------|----|----|------|
| 관리자 | admin | Admin#12345 | ROLE_ADMIN |
| 팀장 | manager | Manager#12345 | ROLE_MANAGER |
| 직원 | emp01 | Emp#12345 | ROLE_EMPLOYEE |

---

## 🧰 배포 구조

Client → Nginx Reverse Proxy → Spring Boot App → MariaDB
↓
AWS S3 (Resume Files)


---

## 💡 개발 포인트

- MyBatis 동적 SQL을 통한 검색·필터링  
- Interceptor 기반 감사 로그 구현  
- Tailwind 반응형 JSP 디자인  
- 단계적 승인 프로세스 설계  
- GitHub Actions + EC2 자동 배포 파이프라인 구축  

---

## 🔧 향후 개선 계획

- 급여 산출 모듈 추가 (근무시간·휴가 자동 반영)  
- 평가 시스템 (연말 인사평가)  
- OAuth2(Google Login) SSO 연동  
- React/Thymeleaf 전환 (SPA형 대시보드)  
- Docker 기반 로컬 실행 환경 구성  

---

## 🔗 참고 링크

- **시연 영상 (YouTube):** [YouTube 시연 링크 넣기]  

---

> ✨ *본 프로젝트는 Spring Boot + MyBatis 기반의 HR 내부 관리 시스템으로,  
> 인사·근태·휴가·채용 프로세스를 통합하여 운영 효율을 높이는 것을 목표로 합니다.*

