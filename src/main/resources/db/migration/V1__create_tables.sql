SET NAMES utf8mb4;

-- 1) 기본 영역 ─────────────────────────────────────────────

CREATE TABLE departments (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(100) NOT NULL,
  parent_id    INT NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_departments_parent
    FOREIGN KEY (parent_id) REFERENCES departments(id)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE employees (
  user_id       VARCHAR(50) PRIMARY KEY,
  password_hash VARCHAR(255) NOT NULL,
  name          VARCHAR(100) NOT NULL,
  email         VARCHAR(150) NOT NULL UNIQUE,
  dept_id       INT NULL,
  position      VARCHAR(50),
  status        ENUM('ACTIVE','LEAVE','RETIRED') NOT NULL DEFAULT 'ACTIVE',
  hire_date     DATE,
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_employees_dept
    FOREIGN KEY (dept_id) REFERENCES departments(id)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE employee_roles (
  id         BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    VARCHAR(50) NOT NULL,
  role_name  VARCHAR(50) NOT NULL,  -- e.g. ROLE_ADMIN / ROLE_MANAGER / ROLE_EMPLOYEE
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_emp_roles_user
    FOREIGN KEY (user_id) REFERENCES employees(user_id)
    ON DELETE CASCADE,
  CONSTRAINT uq_emp_roles UNIQUE (user_id, role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) 근태 영역 ─────────────────────────────────────────────

CREATE TABLE attendance (
  id                BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id           VARCHAR(50) NOT NULL,
  work_date         DATE NOT NULL,
  clock_in          DATETIME NULL,
  clock_out         DATETIME NULL,
  late_minutes      INT NOT NULL DEFAULT 0,
  overtime_minutes  INT NOT NULL DEFAULT 0,
  status            ENUM('WORKING','DONE','ABSENT','LEAVE') NOT NULL DEFAULT 'WORKING',
  created_at        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_attendance_user
    FOREIGN KEY (user_id) REFERENCES employees(user_id)
    ON DELETE CASCADE,
  CONSTRAINT uq_attendance_user_day UNIQUE (user_id, work_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) 결재/휴가 영역 ───────────────────────────────────────

CREATE TABLE approvals_requests (
  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  requester_id  VARCHAR(50) NOT NULL,
  request_type  ENUM('LEAVE','OVERTIME','TRIP') NOT NULL,
  title         VARCHAR(200) NOT NULL,
  payload       JSON NULL,  -- 세부 내용(기간/사유 등), MariaDB의 JSON 사용
  status        ENUM('PENDING','APPROVED','REJECTED','CANCELED') NOT NULL DEFAULT 'PENDING',
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_approvals_requests_requester
    FOREIGN KEY (requester_id) REFERENCES employees(user_id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_appreq_requester ON approvals_requests (requester_id);
CREATE INDEX idx_appreq_status ON approvals_requests (status);
CREATE INDEX idx_appreq_created ON approvals_requests (created_at);

CREATE TABLE approval_stages (
  id           BIGINT AUTO_INCREMENT PRIMARY KEY,
  request_id   BIGINT NOT NULL,
  stage_order  INT NOT NULL,           -- 1,2,3...
  approver_id  VARCHAR(50) NULL,
  status       ENUM('PENDING','APPROVED','REJECTED','SKIPPED') NOT NULL DEFAULT 'PENDING',
  comment      VARCHAR(1000) NULL,
  decided_at   DATETIME NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_appstages_request
    FOREIGN KEY (request_id) REFERENCES approvals_requests(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_appstages_approver
    FOREIGN KEY (approver_id) REFERENCES employees(user_id)
    ON DELETE SET NULL,
  CONSTRAINT uq_appstages_req_order UNIQUE (request_id, stage_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE approvals (
  request_id       BIGINT PRIMARY KEY,
  final_status     ENUM('APPROVED','REJECTED','PENDING','CANCELED') NOT NULL DEFAULT 'PENDING',
  final_decided_at DATETIME NULL,
  total_stages     INT NOT NULL DEFAULT 0,
  approved_stages  INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_approvals_request
    FOREIGN KEY (request_id) REFERENCES approvals_requests(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) 채용 영역 ────────────────────────────────────────────

CREATE TABLE job_postings (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(200) NOT NULL,
  dept_id     INT NULL,
  description MEDIUMTEXT NULL,
  status      ENUM('OPEN','CLOSED') NOT NULL DEFAULT 'OPEN',
  due_date    DATE NULL,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_jobpost_dept
    FOREIGN KEY (dept_id) REFERENCES departments(id)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_jobpost_status ON job_postings(status);
CREATE INDEX idx_jobpost_dept ON job_postings(dept_id);

CREATE TABLE job_applications (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  posting_id  BIGINT NOT NULL,
  name        VARCHAR(100) NOT NULL,
  email       VARCHAR(150) NOT NULL,
  phone       VARCHAR(50) NULL,
  resume_url  VARCHAR(500) NULL,
  status      ENUM('RECEIVED','REVIEW','INTERVIEW','OFFER','REJECTED') NOT NULL DEFAULT 'RECEIVED',
  applied_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_jobapp_posting
    FOREIGN KEY (posting_id) REFERENCES job_postings(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_jobapp_posting ON job_applications(posting_id);
CREATE INDEX idx_jobapp_status ON job_applications(status);

-- 5) 시스템 영역 ──────────────────────────────────────────

CREATE TABLE audit_logs (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id     VARCHAR(50) NULL,        -- 익명/외부 호출 고려하여 NULL 허용
  action      VARCHAR(50) NOT NULL,    -- CREATE/UPDATE/APPROVE/LOGIN 등
  target_type VARCHAR(50) NOT NULL,    -- EMPLOYEE/REQUEST/POSTING 등
  target_id   VARCHAR(100) NULL,
  ip          VARCHAR(45) NULL,        -- IPv4/IPv6
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_audit_user
    FOREIGN KEY (user_id) REFERENCES employees(user_id)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_audit_user ON audit_logs(user_id);
CREATE INDEX idx_audit_created ON audit_logs(created_at);

CREATE TABLE holidays (
  ymd  DATE PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE attachments (
  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  owner_type    VARCHAR(30) NOT NULL,   -- REQUEST / EMPLOYEE / POSTING ...
  owner_id      VARCHAR(50) NOT NULL,   -- 대상 PK 값 (다형성이라 FK 미설정)
  url           VARCHAR(500) NOT NULL,
  original_name VARCHAR(255) NULL,
  mime_type     VARCHAR(100) NULL,
  size          BIGINT NULL,
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_attach_owner ON attachments(owner_type, owner_id);

