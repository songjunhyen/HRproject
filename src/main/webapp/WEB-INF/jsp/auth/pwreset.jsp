<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>비밀번호 초기화 (테스트용)</title>
</head>
<body>
  <h1>비밀번호 초기화</h1>

  <!-- 에러 메시지 표시 -->
  <c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
  </c:if>

  <!-- (선택) CSRF 토큰: Spring Security 연동 시 자동 주입됨 -->
  <c:set var="csrfParam" value="${_csrf != null ? _csrf.parameterName : ''}" />
  <c:set var="csrfToken" value="${_csrf != null ? _csrf.token : ''}" />

  <!-- 기능 확인용: userId만 입력해서 POST /auth/pwreset 로 전송 -->
  <form method="post" action="<c:url value='/auth/pwreset'/>">
    <c:if test="${not empty csrfParam}">
      <input type="hidden" name="${csrfParam}" value="${csrfToken}" />
    </c:if>

    <label for="userId">아이디:</label>
    <input id="userId" name="userId" type="text" required value="${param.userId}" />
    <button type="submit">임시 비밀번호 발급</button>
  </form>

  <p><a href="<c:url value='/auth/login'/>">로그인으로 돌아가기</a></p>
</body>
</html>
