<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; background:#f6f8fa; }
    .wrap { max-width: 420px; margin: 64px auto; background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding: 24px 24px 28px; }
    h1 { margin:0 0 16px; font-size: 20px; }
    .field { margin: 12px 0; display:flex; flex-direction:column; gap:6px; }
    .field label { font-size: 13px; color:#374151; }
    .field input { padding:10px 12px; border:1px solid #d1d5db; border-radius:8px; font-size:14px; }
    .error { background:#fef2f2; color:#991b1b; border:1px solid #fecaca; padding:10px 12px; border-radius:8px; margin: 8px 0 12px; font-size: 13px; }
    .actions { margin-top: 16px; display:flex; gap:8px; align-items:center; }
    .btn { appearance:none; border:0; padding:10px 14px; border-radius:8px; background:#111827; color:#fff; cursor:pointer; font-weight:600; }
    .link { font-size: 13px; color:#2563eb; text-decoration:none; }
    .muted { font-size: 12px; color:#6b7280; margin-top: 12px; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>로그인</h1>

    <c:if test="${not empty error}">
      <div class="error">${error}</div>
    </c:if>

    <c:set var="csrfParam" value="${_csrf != null ? _csrf.parameterName : ''}" />
    <c:set var="csrfToken" value="${_csrf != null ? _csrf.token : ''}" />

    <form method="post" action="<c:url value='/auth/login'/>">
      <c:if test="${not empty csrfParam}">
        <input type="hidden" name="${csrfParam}" value="${csrfToken}" />
      </c:if>

      <div class="field">
        <label for="userId">아이디</label>
        <input id="userId" name="userId" type="text" required
               value="${param.userId}" autocomplete="username" />
      </div>

      <div class="field">
        <label for="password">비밀번호</label>
        <input id="password" name="password" type="password" required autocomplete="current-password" />
      </div>

      <div class="actions">
        <button class="btn" type="submit">로그인</button>
        <a class="link" href="<c:url value='/auth/signup'/>">회원가입</a>
      </div>

      <p class="muted">로그인에 문제가 있으면 관리자에게 문의하세요.</p>
    </form>
   </div>

    <!-- ✅ 임시 비밀번호나 안내 메시지 플래시 표시 -->
    <c:if test="${not empty resetPw}">
      <script>
        window.addEventListener('load', function() {
          alert('임시 비밀번호가 발급되었습니다:\\n\\n${resetPw}\\n\\n보안을 위해 즉시 변경하세요.');
        });
      </script>
    </c:if>

    <c:if test="${not empty info}">
      <script>
        window.addEventListener('load', function() {
          alert('${info}');
        });
      </script>
    </c:if>
</body>
</html>
