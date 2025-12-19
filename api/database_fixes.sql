-- DATABASE SCHEMA FIXES FOR MAHA GR APP

-- 1. Add missing columns to users table
ALTER TABLE `users` 
ADD COLUMN `name` VARCHAR(255) AFTER `user_id`,
ADD COLUMN `user_type` VARCHAR(100) AFTER `mobile`,
ADD COLUMN `district` VARCHAR(100) AFTER `user_type`;

-- 2. Create suggestions table
CREATE TABLE `suggestions` (
  `suggestion_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `status` enum('pending','reviewed','implemented') DEFAULT 'pending',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`suggestion_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `suggestions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Create districts table
CREATE TABLE `districts` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `district_name` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`district_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Insert district data
INSERT INTO `districts` (`district_name`) VALUES
('Mumbai'), ('Pune'), ('Nagpur'), ('Thane'), ('Nashik'),
('Aurangabad'), ('Solapur'), ('Kolhapur'), ('Amravati'), ('Nanded'),
('Sangli'), ('Jalgaon'), ('Akola'), ('Latur'), ('Dhule'),
('Ahmednagar'), ('Chandrapur'), ('Jalna'), ('Parbhani'), ('Buldhana'),
('Yavatmal'), ('Osmanabad'), ('Nandurbar'), ('Washim'), ('Hingoli'),
('Gadchiroli'), ('Bhandara'), ('Gondia'), ('Wardha'), ('Ratnagiri'),
('Sindhudurg'), ('Raigad'), ('Satara'), ('Beed'), ('Usmanabad'), ('Bid');

-- 5. Add indexes for better performance
ALTER TABLE `documents` ADD INDEX `idx_category_status` (`category_id`, `status`);
ALTER TABLE `documents` ADD INDEX `idx_upload_date` (`upload_date`);
ALTER TABLE `documents` ADD INDEX `idx_gr_date` (`gr_date`);
ALTER TABLE `categories` ADD INDEX `idx_department_status` (`department_id`, `status`);
ALTER TABLE `users` ADD INDEX `idx_email_status` (`email`, `status`);
ALTER TABLE `admin_users` ADD INDEX `idx_email_status` (`email`, `status`);

-- 6. Add constraints for data integrity
ALTER TABLE `documents` 
ADD CONSTRAINT `chk_gr_date_format` CHECK (`gr_date` REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$');

-- 7. Create audit log table for better tracking
CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` text DEFAULT NULL,
  `new_values` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `user_id` (`user_id`),
  KEY `action` (`action`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Create user sessions table for better session management
CREATE TABLE `user_sessions` (
  `session_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`session_id`),
  KEY `user_id` (`user_id`),
  KEY `expires_at` (`expires_at`),
  CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Create rate limiting table
CREATE TABLE `rate_limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `count` int(11) DEFAULT 1,
  `window_start` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_action_window` (`ip_address`, `action`, `window_start`),
  KEY `window_start` (`window_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. Add file metadata table for better file management
CREATE TABLE `file_metadata` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `checksum` varchar(64) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`file_id`),
  KEY `document_id` (`document_id`),
  CONSTRAINT `file_metadata_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
