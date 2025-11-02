package com.songjunhyen.hrms.dao;

import com.songjunhyen.hrms.domain.Employee;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeeDao {
    List<Employee> findAll();
    Employee findById(String userId);
    int insert(Employee employee);
    int update(Employee employee);
    int delete(String userId);
    boolean existsById(String userId);
    boolean existsByEmail(String email);
    void updatePassword(String userId, String passwordHash);
}
