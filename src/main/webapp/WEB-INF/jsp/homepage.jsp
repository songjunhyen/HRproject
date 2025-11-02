<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>홈페이지 (기능 확인용)</title>
</head>
<body>
  <h1>홈페이지</h1>

  <c:choose>
    <c:when test="${not empty user}">
      <p>안녕하세요, <strong>${user.name}</strong>님! (${user.userId})</p>
      <p>이메일: ${user.email}</p>
      <p>부서 ID: ${user.deptId}</p>
      <form method="post" action="<c:url value='/auth/logout'/>">
        <c:if test="${not empty _csrf}">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>
        <button type="submit">로그아웃</button>
      </form>
    </c:when>
    <c:otherwise>
      <p>로그인 정보가 없습니다.</p>
      <a href="<c:url value='/auth/login'/>">로그인으로 이동</a>
    </c:otherwise>
  </c:choose>

</body>
</html>