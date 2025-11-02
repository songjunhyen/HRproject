package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.EmployeeDao;
import com.songjunhyen.hrms.dao.RoleDao;
import com.songjunhyen.hrms.domain.Employee;
import com.songjunhyen.hrms.domain.Role;
import com.songjunhyen.hrms.dto.AuthReq;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.security.SecureRandom;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final EmployeeDao employeeDao;
    private final RoleDao roleDao;

    @Transactional
    public void signup(AuthReq req) {
        if (employeeDao.existsById(req.getUserId()) || employeeDao.existsByEmail(req.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 ID 또는 이메일입니다.");
        }

        Employee e = new Employee();
        e.setUserId(req.getUserId());
        e.setPasswordHash(hashPassword(req.getPassword()));
        e.setName(req.getName());
        e.setEmail(req.getEmail());
        e.setDeptId(req.getDeptId());
        e.setStatus("ACTIVE");
        employeeDao.insert(e);

        Role role = new Role();
        role.setUserId(req.getUserId());
        role.setRoleName("ROLE_EMPLOYEE");
        roleDao.insert(role);
    }

    public Employee login(AuthReq req) {
        Employee e = employeeDao.findById(req.getUserId());
        if (e == null || !matches(req.getPassword(), e.getPasswordHash())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return e;
    }

    @Transactional
    public String pwreset(String userId, int length) {
        Employee e = employeeDao.findById(userId);
        if (e == null) {
            throw new IllegalArgumentException("존재하지 않는 사용자입니다.");
        }

        // 컨트롤러에서 받은 길이 사용
        String newPw = generateRandomPassword(length);
        String hash = hashPassword(newPw);
        employeeDao.updatePassword(userId, hash);

        return newPw; // 컨트롤러에서 팝업으로 표시
    }

    private String generateRandomPassword(int length) {
        if (length <= 0) throw new IllegalArgumentException("길이는 1 이상이어야 합니다.");

        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }

        return sb.toString();
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashed = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashed) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("암호화 실패", e);
        }
    }

    private boolean matches(String raw, String hashed) {
        return hashPassword(raw).equals(hashed);
    }
}
