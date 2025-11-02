package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.DepartmentDao;
import com.songjunhyen.hrms.dao.EmployeeDao;
import com.songjunhyen.hrms.dao.RoleDao;
import com.songjunhyen.hrms.domain.Employee;
import com.songjunhyen.hrms.domain.Role;
import com.songjunhyen.hrms.dto.AuthReq;
import com.songjunhyen.hrms.dto.AuthResp;
import com.songjunhyen.hrms.util.AuthUtil;
import java.time.LocalDate;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.security.SecureRandom;


@Service
@RequiredArgsConstructor
public class AuthService {
    private final EmployeeDao employeeDao;
    private final RoleDao roleDao;
    private final DepartmentDao departmentDao;

    @Transactional
    public AuthResp signup(AuthReq req) {
        if (employeeDao.existsById(req.getUserId()) || employeeDao.existsByEmail(req.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 ID 또는 이메일입니다.");
        }

        Employee e = new Employee();
        e.setUserId(req.getUserId());
        e.setPasswordHash(AuthUtil.hash(req.getPassword()));
        e.setName(req.getName());
        e.setEmail(req.getEmail());
        e.setDeptId(req.getDeptId());
        e.setStatus("ACTIVE");
        e.setHireDate(java.time.LocalDate.now());
        employeeDao.insert(e);

        Role role = new Role();
        role.setUserId(req.getUserId());
        role.setRoleName("ROLE_EMPLOYEE");
        roleDao.insert(role);

        // 가입 직후 응답 DTO 구성
        return buildAuthResp(e);
    }

    // 로그인은 Employee 대신 AuthResp 반환이 편리
    @Transactional(readOnly = true)
    public AuthResp login(AuthReq req) {
        Employee e = employeeDao.findById(req.getUserId());
        if (e == null || !AuthUtil.matches(req.getPassword(), e.getPasswordHash())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return buildAuthResp(e);
    }

    @Transactional
    public String pwreset(String userId, int length) {
        Employee e = employeeDao.findById(userId);
        if (e == null) throw new IllegalArgumentException("존재하지 않는 사용자입니다.");

        String newPw = generateRandomPassword(Math.max(length, 8));
        employeeDao.updatePassword(userId, AuthUtil.hash(newPw));
        return newPw;
    }

    private AuthResp buildAuthResp(Employee e) {
        AuthResp resp = new AuthResp();
        resp.setUserId(e.getUserId());
        resp.setName(e.getName());
        resp.setEmail(e.getEmail());

        String deptName = (e.getDeptId() == null) ? null : departmentDao.findNameById(e.getDeptId());
        resp.setDeptName(deptName);

        resp.setRoles(roleDao.findRoleNamesByUserId(e.getUserId()));
        return resp;
    }

    private String generateRandomPassword(int length) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        var r = new java.security.SecureRandom();
        var sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) sb.append(chars.charAt(r.nextInt(chars.length())));
        return sb.toString();
    }
}
