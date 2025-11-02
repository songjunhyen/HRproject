package com.songjunhyen.hrms.dao;

import com.songjunhyen.hrms.domain.Role;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RoleDao {
    List<Role> findAll();
    List<Role> findByUserId(String userId);
    int insert(Role role);
    int deleteByUserId(String userId);

    List<String> findRoleNamesByUserId(String userId);
}
