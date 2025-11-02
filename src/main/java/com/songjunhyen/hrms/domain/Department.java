package com.songjunhyen.hrms.domain;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Department {
    private Integer id;
    private String name;
    private Integer parentId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
//부서
