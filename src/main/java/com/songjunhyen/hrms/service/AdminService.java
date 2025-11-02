    package com.songjunhyen.hrms.service;

    import com.songjunhyen.hrms.dao.DepartmentDao;
    import com.songjunhyen.hrms.dao.EmployeeDao;
    import com.songjunhyen.hrms.dao.RoleDao;
    import com.songjunhyen.hrms.domain.Department;
    import com.songjunhyen.hrms.domain.Employee;
    import com.songjunhyen.hrms.domain.Role;
    import java.util.List;
    import lombok.RequiredArgsConstructor;
    import org.springframework.stereotype.Service;

    @Service
    @RequiredArgsConstructor
    public class AdminService {
        private final DepartmentDao departmentDao;
        private final EmployeeDao employeeDao;
        private final RoleDao roleDao;

        public List<Department> listDepartments() {
            return departmentDao.findAll();
        }

        public List<Employee> listEmployees() {
            return employeeDao.findAll();
        }

        public List<Role> listRoles() {
            return roleDao.findAll();
        }
    }
