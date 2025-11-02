package com.songjunhyen.hrms.service;

import com.songjunhyen.hrms.dao.RoleDao;
import com.songjunhyen.hrms.domain.Role;
import lombok.RequiredArgsConstructor;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class RoleService {
    private final RoleDao roleDao;

    public List<Role> getRolesByUserId(String userId) {
        return roleDao.findByUserId(userId);
    }

    public void addRole(String userId, String roleName) {
        Role role = new Role();
        role.setUserId(userId);
        role.setRoleName(roleName);
        roleDao.insert(role);
    }

    public void removeAllRoles(String userId) {
        roleDao.deleteByUserId(userId);
    }

    public void replaceRoles(String userId, List<String> newRoles) {
        roleDao.deleteByUserId(userId);
        for (String roleName : newRoles) {
            Role role = new Role();
            role.setUserId(userId);
            role.setRoleName(roleName);
            roleDao.insert(role);
        }
    }
}
