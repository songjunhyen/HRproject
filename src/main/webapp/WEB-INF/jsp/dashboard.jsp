<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>HRMS 대시보드</title>
</head>
<body>

<c:choose>
  <c:when test="${empty me}">
    <p>세션이 만료되었습니다. 다시 로그인하세요.</p>
    <p><a href="/auth/login">로그인 페이지로 이동</a></p>
    <c:remove var="LOGIN_USER" scope="session"/>
    <c:redirect url="/auth/login"/>
  </c:when>

  <c:otherwise>
    <h2>${me.name} 님, 환영합니다.</h2>
    <p>
      ID: ${me.userId}
      <br/>이메일: ${me.email}
      <br/>부서: <c:out value="${me.deptName}" default="미배정"/>
      <br/>역할:
      <c:choose>
        <c:when test="${not empty me.roles}">
          <!-- fn:join 대신 forEach로 출력 -->
          <c:forEach var="r" items="${me.roles}" varStatus="st">
            ${r}<c:if test="${!st.last}">, </c:if>
          </c:forEach>
        </c:when>
        <c:otherwise>없음</c:otherwise>
      </c:choose>
    </p>

    <hr/>

    <h3>요약</h3>
    <ul>
      <li>내 대기 결재: <c:out value="${pendingApprovalsCount}" default="0"/></li>
      <li>오늘 근태:
        <c:choose>
          <c:when test="${not empty todayAttendance}">
            출근=${todayAttendance.clockIn}, 퇴근=<c:out value="${todayAttendance.clockOut}" default="-"/>
          </c:when>
          <c:otherwise>기록 없음</c:otherwise>
        </c:choose>
      </li>
    </ul>

    <hr/>

    <!-- 역할 플래그 계산: fn:contains / fn:join 쓰지 않고 forEach로 -->
    <c:set var="isAdmin" value="false"/>
    <c:set var="isManager" value="false"/>
    <c:forEach var="r" items="${me.roles}">
      <c:if test="${r == 'ROLE_ADMIN'}"><c:set var="isAdmin" value="true"/></c:if>
      <c:if test="${r == 'ROLE_MANAGER'}"><c:set var="isManager" value="true"/></c:if>
    </c:forEach>

    <!-- 관리자 -->
    <c:if test="${isAdmin}">
      <h3>관리자 대시보드</h3>
      <ul>
        <li>부서 수: <c:out value="${deptCount}" default="0"/></li>
        <li>직원 수: <c:out value="${empCount}" default="0"/></li>
      </ul>

      <h4>최근 결재(전체)</h4>
      <c:choose>
        <c:when test="${not empty recentApprovals}">
          <ul>
            <c:forEach var="a" items="${recentApprovals}">
              <li>[${a.status}] ${a.title} - ${a.createdAt}</li>
            </c:forEach>
          </ul>
        </c:when>
        <c:otherwise>없음</c:otherwise>
      </c:choose>

      <p>
        <a href="/admin/employees">직원 관리</a> |
        <a href="/admin/departments">부서 관리</a> |
        <a href="/admin/approvals">결재 관리</a>
      </p>
      <hr/>
    </c:if>

    <!-- 매니저 -->
    <c:if test="${not isAdmin and isManager}">
      <h3>팀장 대시보드</h3>

      <h4>부서 오늘 근태</h4>
      <c:choose>
        <c:when test="${not empty teamToday}">
          <table border="1" cellpadding="4" cellspacing="0">
            <thead>
              <tr><th>사번</th><th>이름</th><th>출근</th><th>퇴근</th><th>상태</th></tr>
            </thead>
            <tbody>
              <c:forEach var="t" items="${teamToday}">
                <tr>
                  <td>${t.userId}</td>
                  <td>${t.name}</td>
                  <td>${t.clockIn}</td>
                  <td><c:out value="${t.clockOut}" default="-"/></td>
                  <td>${t.status}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>데이터 없음</c:otherwise>
      </c:choose>

      <h4>부서 대기 결재</h4>
      <c:choose>
        <c:when test="${not empty teamPending}">
          <ul>
            <c:forEach var="p" items="${teamPending}">
              <li>[${p.status}] ${p.title} - ${p.createdAt} / 신청자: ${p.requesterName}</li>
            </c:forEach>
          </ul>
        </c:when>
        <c:otherwise>없음</c:otherwise>
      </c:choose>
      <hr/>
    </c:if>

    <!-- 직원 -->
    <c:if test="${not isAdmin and not isManager}">
      <h3>직원 대시보드</h3>

      <h4>나의 오늘 근태</h4>
      <c:choose>
        <c:when test="${not empty myToday}">
          출근: ${myToday.clockIn} / 퇴근: <c:out value="${myToday.clockOut}" default="-"/>
        </c:when>
        <c:otherwise>오늘 출근 기록이 없습니다.</c:otherwise>
      </c:choose>

      <h4>최근 내 결재</h4>
      <c:choose>
        <c:when test="${not empty myApprovals}">
          <ul>
            <c:forEach var="r" items="${myApprovals}">
              <li>[${r.status}] ${r.title} - ${r.createdAt}</li>
            </c:forEach>
          </ul>
        </c:when>
        <c:otherwise>없음</c:otherwise>
      </c:choose>
      <hr/>
    </c:if>

    <!-- 공통 동작 -->
    <form action="/auth/logout" method="post">
      <button type="submit">로그아웃</button>
    </form>

  </c:otherwise>
</c:choose>

</body>
</html>
