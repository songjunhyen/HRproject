package com.songjunhyen.hrms.controller;

import com.songjunhyen.hrms.service.DepartmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class DepartmentController {
    private DepartmentService departmentService;
}
