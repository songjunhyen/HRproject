package com.songjunhyen.hrms.dao;

import com.songjunhyen.hrms.domain.Employee;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface EmployeeDao {
    List<Employee> findAll();
    Employee findById(@Param("userId") String userId);
    int insert(Employee e);
    int update(Employee e);
    int delete(@Param("userId") String userId);
}
