package com.songjunhyen.hrms.domain;

import lombok.Data;
import java.time.LocalDate;

@Data
public class Employee {
    private String userId;        // PK (employees.user_id)
    private String passwordHash;
    private String name;
    private String email;
    private Integer deptId;
    private String position;
    private String status;        // ACTIVE / LEAVE / RETIRED
    private LocalDate hireDate;
}
