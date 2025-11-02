package com.songjunhyen.hrms.domain;

import java.time.LocalDate;
import lombok.Data;

@Data
public class Role {
    private Integer id;
    private String userId;
    private String roleName;
    private LocalDate createdAt;
}
//직원 권한