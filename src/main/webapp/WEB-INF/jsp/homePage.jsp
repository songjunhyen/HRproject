모듈	URL	JSP 경로	목적/화면	권한(예시)
로그인	/login	webapp/WEB-INF/jsp/auth/login.jsp	로그인 폼	모든 사용자(비로그인)
대시보드	/admin/dashboard	…/jsp/admin/dashboard.jsp	오늘 근태/결재대기/연차통계 카드	MANAGER/ADMIN
내 프로필	/me	…/jsp/user/profile.jsp	비번변경, 개인정보	EMPLOYEE+
근태 목록	/attendance	…/jsp/attendance/list.jsp	월별 근태표, 필터	EMPLOYEE+
출근/퇴근	/attendance/punch	…/jsp/attendance/punch.jsp	버튼(출근/퇴근), 오늘 상태	EMPLOYEE+
휴가 신청	/requests/leave/new	…/jsp/requests/leave_form.jsp	휴가 폼	EMPLOYEE+
내 요청	/requests/my	…/jsp/requests/my_list.jsp	내가 올린 결재요청 목록	EMPLOYEE+
결재함(대기)	/approvals/inbox	…/jsp/approvals/inbox.jsp	내 결재 대기/진행	MANAGER/ADMIN
결재 상세	/approvals/{id}	…/jsp/approvals/detail.jsp	단계/이력/승인/반려	MANAGER/ADMIN
직원 목록	/admin/employees	…/jsp/admin/employees.jsp	직원 CRUD, 권한/부서	ADMIN
부서 관리	/admin/departments	…/jsp/admin/departments.jsp	부서 트리/CRUD	ADMIN
채용 공고 관리	/admin/jobs	…/jsp/admin/jobs.jsp	공고 CRUD, 상태 변경	ADMIN
지원서 검토	/admin/applications	…/jsp/admin/applications.jsp	지원 목록/상태 변경/다운로드	ADMIN
감사 로그	/admin/audit	…/jsp/admin/audit.jsp	주요 행위 기록 조회	ADMIN
시스템 설정	/admin/settings	…/jsp/admin/settings.jsp