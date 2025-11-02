<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HRMS 관리자 대시보드</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6f8;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 15px 25px;
            font-size: 20px;
            font-weight: bold;
        }
        main {
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        h2 {
            color: #333;
            margin-top: 40px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 6px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        th, td {
            padding: 10px 12px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .count {
            font-size: 13px;
            color: #666;
            margin-left: 10px;
        }
        .empty-msg {
            text-align: center;
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>

<header>HRMS 관리자 대시보드</header>

<main>

    <!-- 부서 목록 -->
    <section>
        <h2>부서 목록 <span class="count">(${fn:length(departments)}개)</span></h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>부서명</th>
                <th>상위 부서</th>
                <th>생성일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty departments}">
                    <tr><td colspan="4" class="empty-msg">등록된 부서 데이터가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="d" items="${departments}">
                        <tr>
                            <td>${d.id}</td>
                            <td>${d.name}</td>
                            <td><c:out value="${d.parentId}" default="-"/></td>
                            <td>${d.createdAt}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </section>


    <!-- 직원 목록 -->
    <section>
        <h2>직원 목록 <span class="count">(${fn:length(employees)}명)</span></h2>
        <table>
            <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
                <th>부서ID</th>
                <th>직급</th>
                <th>상태</th>
                <th>입사일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty employees}">
                    <tr><td colspan="7" class="empty-msg">등록된 직원 데이터가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="e" items="${employees}">
                        <tr>
                            <td>${e.userId}</td>
                            <td>${e.name}</td>
                            <td>${e.email}</td>
                            <td>${e.deptId}</td>
                            <td>${e.position}</td>
                            <td>${e.status}</td>
                            <td>${e.hireDate}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </section>


    <!-- 권한 목록 -->
    <section>
        <h2>권한 목록 <span class="count">(${fn:length(roles)}개)</span></h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>사용자 ID</th>
                <th>권한명</th>
                <th>등록일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty roles}">
                    <tr><td colspan="4" class="empty-msg">등록된 권한 데이터가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${roles}">
                        <tr>
                            <td>${r.id}</td>
                            <td>${r.userId}</td>
                            <td>${r.roleName}</td>
                            <td>${r.createdAt}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </section>

</main>

</body>
</html>
