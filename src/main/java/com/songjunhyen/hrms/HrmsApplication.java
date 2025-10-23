package com.songjunhyen.hrms;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class HrmsApplication implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication.run(HrmsApplication.class, args);
    }

    @Override
    public void run(String... args) {
        System.out.println("✅ HR Management System 서버가 시작되었습니다!");
        System.out.println("🌐 접속: http://localhost:9005");
        System.out.println("----------------------------------------------------");
    }
}
