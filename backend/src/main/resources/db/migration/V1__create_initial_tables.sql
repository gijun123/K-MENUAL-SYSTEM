-- 사용자 계정과 권한
CREATE TABLE users (
                       id INT NOT NULL AUTO_INCREMENT,
                       username VARCHAR(50) NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       role VARCHAR(20) NOT NULL DEFAULT 'USER',
                       is_active BOOLEAN NOT NULL DEFAULT TRUE,
                       PRIMARY KEY (id),
                       UNIQUE KEY uk_users_username (username)
) ENGINE=InnoDB;

-- 상담 이력
CREATE TABLE consultations (
                               id INT NOT NULL AUTO_INCREMENT,
                               title VARCHAR(200) NOT NULL,
                               author_id INT NOT NULL,
                               PRIMARY KEY (id),
                               KEY idx_consultations_author_id (author_id),
                               CONSTRAINT fk_consultations_author
                                   FOREIGN KEY (author_id) REFERENCES users (id)
) ENGINE=InnoDB;

-- 매뉴얼 공통 정보
CREATE TABLE manuals (
                         id INT NOT NULL AUTO_INCREMENT,
                         title VARCHAR(200) NOT NULL,
                         PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 매뉴얼 버전
CREATE TABLE manual_versions (
                                 id INT NOT NULL AUTO_INCREMENT,
                                 manual_id INT NOT NULL,
                                 version_number INT NOT NULL,
                                 PRIMARY KEY (id),
                                 UNIQUE KEY uk_manual_versions_manual_version (manual_id, version_number),
                                 CONSTRAINT fk_manual_versions_manual
                                     FOREIGN KEY (manual_id) REFERENCES manuals (id)
) ENGINE=InnoDB;

-- 상담에서 참고한 매뉴얼 버전 연결
CREATE TABLE consultation_manuals (
                                      consultation_id INT NOT NULL,
                                      manual_version_id INT NOT NULL,
                                      PRIMARY KEY (consultation_id, manual_version_id),
                                      KEY idx_consultation_manuals_manual_version_id (manual_version_id),
                                      CONSTRAINT fk_consultation_manuals_consultation
                                          FOREIGN KEY (consultation_id) REFERENCES consultations (id),
                                      CONSTRAINT fk_consultation_manuals_manual_version
                                          FOREIGN KEY (manual_version_id) REFERENCES manual_versions (id)
) ENGINE=InnoDB;