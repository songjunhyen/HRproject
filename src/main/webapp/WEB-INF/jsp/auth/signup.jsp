<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>회원가입</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; background:#f6f8fa; }
    .wrap { max-width: 520px; margin: 64px auto; background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding: 24px 24px 28px; }
    h1 { margin:0 0 16px; font-size: 20px; }
    .field { margin: 12px 0; display:flex; flex-direction:column; gap:6px; }
    .field label { font-size: 13px; color:#374151; }
    .field input { padding:10px 12px; border:1px solid #d1d5db; border-radius:8px; font-size:14px; }
    .error { background:#fef2f2; color:#991b1b; border:1px solid #fecaca; padding:10px 12px; border-radius:8px; margin: 8px 0 12px; font-size: 13px; }
    .actions { margin-top: 16px; display:flex; gap:8px; align-items:center; }
    .btn { appearance:none; border:0; padding:10px 14px; border-radius:8px; background:#111827; color:#fff; cursor:pointer; font-weight:600; }
    .link { font-size: 13px; color:#2563eb; text-decoration:none; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>회원가입</h1>

    <c:if test="${not empty error}">
      <div class="error">${error}</div>
    </c:if>

    <c:set var="csrfParam" value="${_csrf != null ? _csrf.parameterName : ''}" />
    <c:set var="csrfToken" value="${_csrf != null ? _csrf.token : ''}" />

    <form method="post" action="<c:url value='/auth/signup'/>">
      <c:if test="${not empty csrfParam}">
        <input type="hidden" name="${csrfParam}" value="${csrfToken}" />
      </c:if>

      <div class="field">
        <label for="userId">아이디</label>
        <input id="userId" name="userId" type="text" required value="${param.userId}" />
      </div>

      <div class="field">
        <label for="password">비밀번호</label>
        <input id="password" name="password" type="password" required />
      </div>

      <div class="field">
        <label for="name">이름</label>
        <input id="name" name="name" type="text" required value="${param.name}" />
      </div>

      <div class="field">
        <label for="email">이메일</label>
        <input id="email" name="email" type="email" required value="${param.email}" />
      </div>

      <div class="field">
        <label for="deptId">부서 ID</label>
        <input id="deptId" name="deptId" type="number" required value="${param.deptId}" />
      </div>

      <div class="actions">
        <button class="btn" type="submit">가입하기</button>
        <a class="link" href="<c:url value='/auth/login'/>">로그인으로 돌아가기</a>
      </div>
    </form>
  </div>
</body>
</html>
