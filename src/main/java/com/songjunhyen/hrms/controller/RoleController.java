package com.songjunhyen.hrms.controller;

import com.songjunhyen.hrms.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class RoleController {
    private RoleService roleService;
}
