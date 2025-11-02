package com.songjunhyen.hrms.controller;

import com.songjunhyen.hrms.domain.Employee;
import com.songjunhyen.hrms.service.EmployeeService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class EmployeeConroller {
    private EmployeeService employeeService;

    @GetMapping("/profile")
    public String getProfile(Model model, String userId){
        Employee employee = employeeService.getEmployee(userId);
        model.addAttribute("employee", employee);
        return "user/profile";
    }

    @PostMapping("/profile/edit")
    public String editProfile(){
        return "user/profile";
    }

    @GetMapping("/passwdEdit")
    public String passwdEdit(Model model, String userId){

        return "pwreset";
    }

    @GetMapping("/employees")
    public String employeesList(Model model){
        List<Employee> employees = employeeService.listEmployee();
        model.addAttribute("employee", employees);
        return "admin/employees";
    }
}
