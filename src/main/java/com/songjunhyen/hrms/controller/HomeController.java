package com.songjunhyen.hrms.controller;

import com.songjunhyen.hrms.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final AdminService adminService;

    /** HTML 파일 (resources/static/home.html) */
    @GetMapping("/htmlpage1")
    public String index() {
        // static 밑에 있는 파일은 뷰 리졸버 없이 바로 접근 가능.
        // 여기서는 redirect로 넘기면 됨.
        return "forward:/home.html";
    }

    /** JSP 파일 (뷰 리졸버 경로: /WEB-INF/jsp/) */
    @GetMapping("/")
    public String page() {
        // 실제 경로: src/main/webapp/WEB-INF/jsp/homepage.jsp
        return "homepage";
    }
    @GetMapping("/index")
    public String indexpage(Model model) {
        model.addAttribute("departments", adminService.listDepartments());
        model.addAttribute("employees",   adminService.listEmployees());
        model.addAttribute("roles",       adminService.listRoles());
        return "index";
    }
}
/*
🟢 HTML (정적 페이지 / public 영역)
위치: src/main/resources/static/
예: index.jsp, about.html, contact.html
접근: /, /about, /contact
로그인 없이 누구나 접근 가능
용도:
회사 소개, 랜딩페이지, 문의, 비회원 공고 보기
React나 Vue 같은 프론트엔드 앱 빌드 결과도 여기에 둠
특징:
Spring Controller 필요 없음 (자동 서빙)
빠르고 캐싱 쉬움

🔵 JSP (내부 서비스 / 로그인 이후)
위치: src/main/webapp/WEB-INF/jsp/
예: admin/dashboard.jsp, user/profile.jsp
접근: 컨트롤러에서 return "admin/dashboard";
로그인한 사용자만 접근 가능하도록 설정(Spring Security 등)
용도:
관리자, 인사·근태·휴가 관리, 결재, 사원정보 수정 등
즉 “내부 시스템” 화면들
특징:
Controller에서 Model 데이터 넘겨서 렌더링 가능
View Resolver(/WEB-INF/jsp/) 경로를 통해만 접근 가능 → URL로 직접 접근 불가 (보안상 안전)

🔴 REST API (React, 앱 등 외부 연동용)
경로: /api/**
예: /api/v1/employees, /api/v1/approvals
React, 모바일앱, 외부 시스템이 호출
@RestController로 JSON 주고받음

 */