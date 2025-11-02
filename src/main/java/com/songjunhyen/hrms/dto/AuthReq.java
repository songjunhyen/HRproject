package com.songjunhyen.hrms.dto;

import lombok.Data;

@Data
public class AuthReq {
    // 로그인용
    private String userId;
    private String password;

    // 회원가입
    private String name;
    private String email;
    private Integer deptId;
    private String position;
}
