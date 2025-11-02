package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.EmployeeDao;
import com.songjunhyen.hrms.domain.Employee;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class EmployeeService {
    private final EmployeeDao employeeDao;

    public List<Employee> listEmployee(){
        return employeeDao.findAll();
    }

    public Employee getEmployee(String userId) {
        return employeeDao.findById(userId);
    }

    public int createEmployee(Employee dept) {
        return employeeDao.insert(dept);
    }

    public int updateEmployee(Employee dept) {
        return employeeDao.update(dept);
    }

    public int deleteEmployee(String userId) {
        return employeeDao.delete(userId);
    }

}
