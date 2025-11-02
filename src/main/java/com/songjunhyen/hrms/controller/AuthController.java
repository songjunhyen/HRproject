package com.songjunhyen.hrms.controller;

import com.songjunhyen.hrms.dto.AuthReq;
import com.songjunhyen.hrms.dto.AuthResp;
import com.songjunhyen.hrms.service.AuthService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String loginProc(@ModelAttribute AuthReq req, HttpSession session, Model model) {
        try {
            AuthResp resp = authService.login(req);
            session.setAttribute("LOGIN_USER", resp);
            return "redirect:/auth/dashboard";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            return "auth/login";
        }
    }

    @GetMapping("/signup")
    public String signupForm() {
        return "auth/signup";
    }

    @PostMapping("/signup")
    public String signupProc(@ModelAttribute AuthReq req, Model model) {
        try {
            authService.signup(req);
            return "redirect:/auth/login"; // ✅ 리다이렉트
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            return "auth/signup";
        }
    }

    @GetMapping("/pwreset")
    public String pwresetForm() {
        return "auth/pwreset";
    }

    @PostMapping("/pwreset")
    public String pwresetProc(@RequestParam String userId,
                              org.springframework.web.servlet.mvc.support.RedirectAttributes ra,
                              Model model) {
        try {
            String newPw = authService.pwreset(userId, 11);
            ra.addFlashAttribute("resetPw", newPw);
            ra.addFlashAttribute("info", "임시 비밀번호가 발급되었습니다. 보안을 위해 즉시 변경하세요.");
            return "redirect:/auth/login";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            return "auth/pwreset";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        AuthResp me = (AuthResp) session.getAttribute("LOGIN_USER");

        if (me == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("me", me);
        return "dashboard";
    }
}
