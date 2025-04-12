CREATE DATABASE blog;

USE blog;

CREATE TABLE `posts`
(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `post_date` date DEFAULT NULL COMMENT 'Ngày hiển thị trên bài viết',
    `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tiêu đề bài viết',
    `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Đường dẫn bài viết',
    `short_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Nội dung preview bài viết',
    `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Nội dung bài viết',
    `ordering` tinyint unsigned NOT NULL DEFAULT '255' COMMENT 'Độ ưu tiên bài viết',
    `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Trạng thái 0: deleted, 1: active, 2: private, 3: pending, 4:inherit, 5: draft, 6: auto-draft',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời gian tạo',
    `created_by` bigint NOT NULL DEFAULT '1' COMMENT 'Nguời tạo',
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời gian cập nhật',
    `updated_by` bigint DEFAULT NULL COMMENT 'Nguời cập nhật',
    PRIMARY KEY (`id`),
    KEY `idx_post_date` (`post_date`),
    KEY `idx_slug` (`slug`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT ='Bảng lưu dữ liệu bài viết';


CREATE TABLE `terms`
(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Slug',
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Tên',
    `parent_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Id cha',
    `type` tinyint NOT NULL DEFAULT '1' COMMENT '1: tag,2: category',
    `ordering` tinyint unsigned DEFAULT '255' COMMENT 'Trọng số',
    `status` tinyint NOT NULL DEFAULT '1' COMMENT 'Trạng thái 0: deleted, 1: active',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời gian tạo',
    `created_by` bigint NOT NULL DEFAULT '1' COMMENT 'Nguời tạo',
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời gian cập nhật',
    `updated_by` bigint DEFAULT NULL COMMENT 'Nguời cập nhật',
    PRIMARY KEY (`id`),
    KEY `idx_alias_type` (`alias`(20), `type`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT ='Bảng lưu dữ liệu tag/category của bài viết';


CREATE TABLE `images`
(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `post_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Id bài viết',
    `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Đường dẫn ảnh/video',
    `status` tinyint NOT NULL DEFAULT '1' COMMENT 'Trạng thái 0: deleted, 1: active',
    `type` tinyint NOT NULL DEFAULT '2' COMMENT 'Loại ảnh 1: thumbnail, 2: banner, 3: ảnh giải thưởng',
    PRIMARY KEY (`id`),
    KEY `idx_post_id` (`post_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT ='Bảng lưu dữ liệu ảnh/video';


CREATE TABLE `post_terms`
(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `post_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Id bài viết',
    `term_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Id term',
    `status` tinyint NOT NULL DEFAULT '1' COMMENT 'Trạng thái 0: deleted, 1: active',
    PRIMARY KEY (`id`),
    KEY `idx_term_id_post_id` (`term_id`, `post_id`),
    KEY `idx_post_id` (`post_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT ='Bảng map bài viết với term';