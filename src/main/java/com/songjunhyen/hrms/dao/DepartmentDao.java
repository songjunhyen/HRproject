package com.songjunhyen.hrms.dao;

import com.songjunhyen.hrms.domain.Department;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DepartmentDao {
    Department findById(Integer id);
    List<Department> findAll();
    int insert(Department dept);
    int update(Department dept);
    int delete(Integer id);
}
