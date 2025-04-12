CREATE DATABASE identity_service;

USE identity_service;

CREATE TABLE users
(
    id         int unsigned auto_increment primary key,
    username   varchar(255)     NOT NULL DEFAULT '' COMMENT 'Tài khoản đăng nhập',
    password   char(10)         NOT NULL DEFAULT '' comment 'Mật khẩu đăng nhập',
    fullname   varchar(255)     NOT NULL DEFAULT '' comment 'Tên của người dùng',
    dod        date             null comment 'ngày sinh',
    status     tinyint unsigned not null default 1 comment 'Trạng thái',
    created_at datetime                  default CURRENT_TIMESTAMP not null comment 'Thời gian tạo',
    created_by int                       default 1 null comment 'Nguời tạo',
    updated_at datetime                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment 'Thời gian cập nhật',
    updated_by int              null comment 'Nguời cập nhật',
    key idx_username (username)
) comment 'Bảng lưu dữ liệu user' collate = utf8mb4_unicode_ci;

create table roles
(
    id          int unsigned auto_increment primary key,
    name        varchar(50)      not null default '' comment 'Tên role',
    alias       varchar(50)      not null default '' comment 'Mã role',
    description varchar(255)     not null default '' comment 'Mô tả role',
    status      tinyint unsigned not null default 1 comment 'Trạng thái',
    created_at  datetime                  default CURRENT_TIMESTAMP not null comment 'Thời gian tạo',
    created_by  int                       default 1 not null comment 'Nguời tạo',
    updated_at  datetime                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment 'Thời gian cập nhật',
    updated_by  int              null comment 'Nguời cập nhật',
    key idx_alias (alias)
) comment 'Bảng lưu dữ liệu role' collate = utf8mb4_unicode_ci;

create table permissions
(
    id          int unsigned auto_increment primary key,
    name        varchar(50)      not null default '' comment 'Tên quyền',
    alias       varchar(50)      not null default '' comment 'Mã quyền',
    description varchar(255)     not null default '' comment 'Mô tả quyền',
    status      tinyint unsigned not null default 1 comment 'Trạng thái',
    created_at  datetime                  default CURRENT_TIMESTAMP not null comment 'Thời gian tạo',
    created_by  int                       default 1 not null comment 'Nguời tạo',
    updated_at  datetime                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment 'Thời gian cập nhật',
    updated_by  int              null comment 'Nguời cập nhật',
    key idx_alias (alias)
) comment 'Bảng lưu dữ liệu permission' collate = utf8mb4_unicode_ci;

create table user_roles
(
    id      int unsigned auto_increment primary key,
    user_id int unsigned     not null default 0 comment 'Id bảng users',
    role_id int unsigned     not null default 0 comment 'Id bảng roles',
    status  tinyint unsigned not null default 1 comment 'Trang thais',
    key idx_user (user_id),
    key idx_role (role_id)
) comment 'Bảng map user với role' collate = utf8mb4_unicode_ci;

create table role_permissions
(
    id            int unsigned auto_increment primary key,
    role_id       int unsigned     not null default 0 comment 'Id bảng roles',
    permission_id int unsigned     not null default 0 comment 'Id bảng permissions',
    status        tinyint unsigned not null default 1 comment 'Trạng thái',
    key idx_permission (permission_id),
    key idx_role (role_id)
) comment 'Bảng map role với permission' collate = utf8mb4_unicode_ci;

create table invalidate_tokens
(
    id            varchar(255) primary key,
    exprired_time datetime null comment 'Thời gian hết hạn token'
) comment 'Bảng lưu token bị revoke' collate = utf8mb4_unicode_ci;

create table oauth_clients (
    id int unsigned not null auto_increment primary key ,
    client_id varchar(255) not null default '' comment 'Id của service',
    client_secret varchar(255) not null default '' comment 'Secret của service',
    grant_type varchar(50) not null default 'oauth' comment 'Loại token',
    created_at  datetime                  default CURRENT_TIMESTAMP not null comment 'Thời gian tạo',
    created_by  int                       default 1 not null comment 'Nguời tạo',
    updated_at  datetime                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment 'Thời gian cập nhật',
    updated_by  int              null comment 'Nguời cập nhật',
    key idx_client_id(client_id)
) comment 'Bảng lưu dữ liệu định danh của service' collate = utf8mb4_unicode_ci;

create table oauth_authorization_codes (
    id int unsigned auto_increment primary key ,
    client_id varchar(255) not null default '' comment 'Id của service',
    code varchar(255) not null default '' comment 'code dùng để đổi token',
    redirect_uri varchar(255) not null default '' comment 'link chuyển trang',
    expires_at datetime not null default '1001-01-01 00:00:00'
) comment 'Bảng lưu mã code dùng để đổi token' collate = utf8mb4_unicode_ci;
