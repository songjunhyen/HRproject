package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.DepartmentDao;
import com.songjunhyen.hrms.dao.EmployeeDao;
import com.songjunhyen.hrms.dao.RoleDao;
import com.songjunhyen.hrms.domain.Department;
import com.songjunhyen.hrms.domain.Employee;
import com.songjunhyen.hrms.domain.Role;
import com.songjunhyen.hrms.util.AuthUtil;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class AdminService {
    private final DepartmentDao departmentDao;
    private final EmployeeDao employeeDao;
    private final RoleDao roleDao;

    public List<Department> listDepartments() {
        List<Department> list = departmentDao.findAll();
        if (list == null || list.isEmpty()) {
            Department hr = new Department();
            hr.setName("개발부서");
            departmentDao.insert(hr);

            list = departmentDao.findAll();
        }
        return list;
    }

    public List<Employee> listEmployees() {
        List<Employee> list = employeeDao.findAll();
        if (list == null || list.isEmpty()) {
            // ✅ 예시 기본 직원 추가
            Employee admin = new Employee();
            admin.setUserId("admin");
            admin.setPosition("개발");
            admin.setStatus("ACTIVE");
            admin.setPasswordHash(AuthUtil.hash("admin"));
            admin.setName("관리자");
            admin.setEmail("admin@hrms.local");
            admin.setDeptId(1);
            admin.setHireDate(LocalDate.now());
            employeeDao.insert(admin);
            Role role = new Role();
            role.setUserId("admin");
            role.setRoleName("개발자");
            roleDao.insert(role);
            list = employeeDao.findAll();
        }
        return list;
    }

    public List<Role> listRoles() {
        return roleDao.findAll();
    }

}
