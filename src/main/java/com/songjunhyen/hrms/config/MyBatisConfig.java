package com.songjunhyen.hrms.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("com.songjunhyen.hrms.dao")
public class MyBatisConfig {
}
