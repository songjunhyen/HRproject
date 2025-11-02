package com.songjunhyen.hrms.dto;

import lombok.Data;
import java.util.List;

@Data
public class AuthResp {
    private String userId;
    private String name;
    private String email;
    private String deptName;
    private List<String> roles;
}
