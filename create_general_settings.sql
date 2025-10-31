-- Create general_settings table with all required fields
CREATE TABLE IF NOT EXISTS `general_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_name` varchar(40) DEFAULT 'HYIP Lab',
  `cur_text` varchar(40) DEFAULT 'USD',
  `cur_sym` varchar(40) DEFAULT '$',
  `email_from` varchar(40) DEFAULT 'noreply@example.com',
  `email_template` text,
  `sms_template` text,
  `sms_from` varchar(255) DEFAULT NULL,
  `base_color` varchar(40) DEFAULT '#6c5ce7',
  `secondary_color` varchar(40) DEFAULT '#a29bfe',
  `mail_config` text,
  `sms_config` text,
  `global_shortcodes` text,
  `socialite_credentials` text,
  `firebase_config` text,
  `off_day` text,
  `system_info` text,
  `ev` tinyint(1) NOT NULL DEFAULT '0',
  `en` tinyint(1) NOT NULL DEFAULT '0',
  `sv` tinyint(1) NOT NULL DEFAULT '0',
  `sn` tinyint(1) NOT NULL DEFAULT '0',
  `pn` tinyint(1) NOT NULL DEFAULT '0',
  `force_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `secure_password` tinyint(1) NOT NULL DEFAULT '0',
  `agree` tinyint(1) NOT NULL DEFAULT '1',
  `registration` tinyint(1) NOT NULL DEFAULT '1',
  `multi_language` tinyint(1) NOT NULL DEFAULT '1',
  `active_template` varchar(40) DEFAULT 'neo_dark',
  `currency_format` tinyint(1) NOT NULL DEFAULT '1',
  `available_version` varchar(40) DEFAULT '5.4.1',
  `last_cron` datetime DEFAULT NULL,
  `invest_commission` tinyint(1) NOT NULL DEFAULT '0',
  `deposit_commission` tinyint(1) NOT NULL DEFAULT '0',
  `schedule_invest` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default settings
INSERT INTO `general_settings` (
  `site_name`, `cur_text`, `cur_sym`, `email_from`,
  `base_color`, `secondary_color`, 
  `ev`, `en`, `sv`, `sn`, `pn`,
  `force_ssl`, `maintenance_mode`, `secure_password`, 
  `agree`, `registration`, `multi_language`,
  `active_template`, `currency_format`, `available_version`,
  `invest_commission`, `deposit_commission`, `schedule_invest`,
  `created_at`, `updated_at`
) VALUES (
  'HYIP Lab', 'USD', '$', 'noreply@example.com',
  '#6c5ce7', '#a29bfe',
  0, 0, 0, 0, 0,
  0, 0, 0,
  1, 1, 1,
  'neo_dark', 1, '5.4.1',
  0, 0, 0,
  NOW(), NOW()
) ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- Create admins table
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default admin (username: admin, password: admin123)
-- Password hash for 'admin123'
INSERT INTO `admins` (`name`, `email`, `username`, `password`, `created_at`, `updated_at`)
VALUES (
  'Admin', 'admin@example.com', 'admin',
  '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
  NOW(), NOW()
) ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- Create other essential tables
CREATE TABLE IF NOT EXISTS `admin_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `click_url` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `admin_password_resets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(40) DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `extensions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `script` text,
  `shortcode` text,
  `support` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `frontends` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_keys` varchar(40) DEFAULT NULL,
  `data_values` longtext,
  `seo_content` longtext,
  `tempname` varchar(40) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `image` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default language
INSERT INTO `languages` (`name`, `code`, `is_default`, `created_at`, `updated_at`)
VALUES ('English', 'en', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

CREATE TABLE IF NOT EXISTS `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `slug` varchar(40) DEFAULT NULL,
  `tempname` varchar(40) DEFAULT NULL,
  `secs` text,
  `seo_content` text,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `notification_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `email_body` text,
  `sms_body` text,
  `push_title` varchar(255) DEFAULT NULL,
  `push_body` text,
  `shortcodes` text,
  `email_status` tinyint(1) NOT NULL DEFAULT '1',
  `email_sent_from_name` varchar(40) DEFAULT NULL,
  `email_sent_from_address` varchar(40) DEFAULT NULL,
  `sms_status` tinyint(1) NOT NULL DEFAULT '1',
  `sms_sent_from` varchar(40) DEFAULT NULL,
  `push_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Show success message
SELECT 'Database tables created successfully!' AS message;
