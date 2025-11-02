package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.DepartmentDao;
import com.songjunhyen.hrms.domain.Department;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class DepartmentService {
    private final DepartmentDao departmentDao;

    public List<Department> listDepartments() {
        return departmentDao.findAll();
    }

    public Department getDepartment(int id) {
        return departmentDao.findById(id);
    }

    public int createDepartment(Department dept) {
        return departmentDao.insert(dept);
    }

    public int updateDepartment(Department dept) {
        return departmentDao.update(dept);
    }

    public int deleteDepartment(int id) {
        return departmentDao.delete(id);
    }
}
