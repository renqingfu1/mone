CREATE DATABASE  IF NOT EXISTS `mi_tpc`  DEFAULT CHARACTER SET utf8mb4 ;

USE `mi_tpc`;

-- noinspection SqlNoDataSourceInspectionForFile

-- noinspection SqlDialectInspectionForFile

CREATE TABLE `account_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `account` varchar(64) DEFAULT '' COMMENT '账号',
  `pwd` varchar(64) DEFAULT '' COMMENT '密码',
  `name` varchar(64) DEFAULT '' COMMENT '姓名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `account` varchar(64) DEFAULT '' COMMENT '账号',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_group_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `group_name` varchar(32) DEFAULT '' COMMENT '组名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `user_group_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `group_id` int(20) DEFAULT '0' COMMENT '组ID',
  `user_id` int(20) DEFAULT '0' COMMENT '用户ID',
  `account` varchar(64) DEFAULT '' COMMENT '账号',
  `user_type` int(1) DEFAULT '0' COMMENT '用户类型',
  PRIMARY KEY (`id`),
  KEY `idx_group_id` (`group_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `node_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(256) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `parent_id` int(20) DEFAULT '0' COMMENT '父节点ID',
  `parent_type` int(1) DEFAULT '0' COMMENT '父节点类型',
  `top_id` int(20) DEFAULT '0' COMMENT '顶级节点ID',
  `top_type` int(1) DEFAULT '0' COMMENT '顶级节点类型',
  `node_name` varchar(64) DEFAULT '' COMMENT '节点名称',
  `out_id` int(20) DEFAULT '0' COMMENT '外部ID',
  `out_id_type` int(2) DEFAULT '0' COMMENT '外部ID类型',
  `env_flag` int(2) DEFAULT '0' COMMENT '环境标记',
  `code` varchar(64) DEFAULT '' COMMENT '节点编码',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_top_id` (`top_id`),
  KEY `idx_out_id` (`out_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `node_user_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `user_id` int(20) DEFAULT '0' COMMENT '用户ID',
  `account` varchar(64) DEFAULT '' COMMENT '账号',
  `user_type` int(1) DEFAULT '0' COMMENT '用户类型',
  `node_id` int(20) DEFAULT '0' COMMENT '节点ID',
  `node_type` int(1) DEFAULT '0' COMMENT '节点类型',
  `tester` int(1) DEFAULT '0' COMMENT '0否，1是',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `node_user_group_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `user_group_id` int(20) DEFAULT '0' COMMENT '用户组ID',
  `user_group_name` varchar(64) DEFAULT '' COMMENT '用户组名称',
  `node_id` int(20) DEFAULT '0' COMMENT '节点ID',
  `node_type` int(1) DEFAULT '0' COMMENT '节点类型',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_group_id`),
  KEY `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `flag_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `parent_id` int(20) DEFAULT '0' COMMENT '挂载ID',
  `flag_name` varchar(64) DEFAULT NULL COMMENT '名称',
  `flag_key` varchar(128) DEFAULT NULL COMMENT 'key',
  `flag_val` varchar(128) DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_flag_key` (`flag_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `node_resource_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `resource_id` int(20) DEFAULT '0' COMMENT '资源ID',
  `resource_type` int(1) DEFAULT '0' COMMENT '资源类型',
  `node_id` int(20) DEFAULT '0' COMMENT '节点ID',
  `node_type` int(1) DEFAULT '0' COMMENT '节点类型',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `resource_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` text DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `pool_node_id` int(20) DEFAULT '0' COMMENT '资源池ID',
  `apply_id` int(20) DEFAULT '0' COMMENT '申请工单ID',
  `resource_name` varchar(64) DEFAULT '' COMMENT '资源名称',
  `key1` varchar(64) DEFAULT '' COMMENT '资源标记1',
  `key2` varchar(256) DEFAULT '' COMMENT '资源标记2',
  `env_flag` int(2) DEFAULT '0' COMMENT '环境标记',
  `is_open_kc` int(2) DEFAULT '0' COMMENT '是否使用keycenter  0未使用 1使用',
  `sid` varchar(255) DEFAULT '' COMMENT 'keycenter使用的sid',
  `kc_user` varchar(255) DEFAULT '' COMMENT 'kc_user',
  `mfa` varchar(255) DEFAULT '' COMMENT 'kc的mfa',
  `region` int(2) DEFAULT '0' COMMENT '资源区域',
  PRIMARY KEY (`id`),
  KEY `idx_pool_node_id` (`pool_node_id`),
  KEY `idx_apply_id` (`apply_id`),
  KEY `idx_key1` (`key1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `apply_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` text DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `cur_node_id` int(20) DEFAULT '0' COMMENT '流转节点ID',
  `cur_node_type` int(1) DEFAULT '0' COMMENT '流转节点类型',
  `apply_node_id` int(20) DEFAULT '0' COMMENT '申请节点ID',
  `apply_node_type` int(1) DEFAULT '0' COMMENT '申请节点类型',
  `apply_user_id` int(20) DEFAULT '0' COMMENT '申请人ID',
  `apply_account` varchar(64) DEFAULT '' COMMENT '申请人账号',
  `apply_user_type` int(1) DEFAULT '0' COMMENT '申请人用户类型',
  `apply_name` varchar(64) DEFAULT '' COMMENT '申请名称',
  PRIMARY KEY (`id`),
  KEY `idx_cur_node_id` (`cur_node_id`),
  KEY `idx_apply_node_id` (`apply_node_id`),
  KEY `idx_apply_user_id` (`apply_user_id`),
  KEY `idx_apply_account` (`apply_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `apply_approval_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` text DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `apply_id` int(20) DEFAULT '0' COMMENT '申请ID',
  `apply_type` int(1) DEFAULT '0' COMMENT '申请类型',
  `cur_node_id` int(20) DEFAULT '0' COMMENT '审核节点ID',
  `cur_node_type` int(1) DEFAULT '0' COMMENT '审核节点类型',
  `approval_name` varchar(64) DEFAULT '' COMMENT '审核名称',
  PRIMARY KEY (`id`),
  KEY `idx_apply_id` (`apply_id`),
  KEY `idx_cur_node_id` (`cur_node_id`),
  KEY `idx_creater_id` (`creater_id`),
  KEY `idx_creater_acc` (`creater_acc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `system_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `system_name` varchar(64) DEFAULT '' COMMENT '系统名称',
  `system_token` varchar(64) DEFAULT '' COMMENT '系统token',
  PRIMARY KEY (`id`),
  KEY `idx_system_name` (`system_name`),
  KEY `idx_system_token` (`system_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `permission_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `system_id` int(20) DEFAULT '0' COMMENT '系统ID',
  `permission_name` varchar(64) DEFAULT '' COMMENT '权限名称',
  `path` varchar(128) DEFAULT '' COMMENT '权限url',
  PRIMARY KEY (`id`),
  KEY `idx_system_id` (`system_id`),
  KEY `idx_path` (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `role_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(128) DEFAULT NULL COMMENT '描述',
  `content` varchar(128) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `system_id` int(20) DEFAULT '0' COMMENT '系统ID',
  `role_name` varchar(64) DEFAULT '' COMMENT '角色名称',
  `node_id` int(20) DEFAULT '0' COMMENT '节点ID',
  `node_type` int(1) DEFAULT '0' COMMENT '节点类型',
  PRIMARY KEY (`id`),
  KEY `idx_system_id` (`system_id`),
  KEY `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `role_permission_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `system_id` int(20) DEFAULT '0' COMMENT '系统ID',
  `permission_id` int(20) DEFAULT '0' COMMENT '权限ID',
  `role_id` int(20) DEFAULT '0' COMMENT '角色ID',
  PRIMARY KEY (`id`),
  KEY `idx_permission_id` (`permission_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_node_role_rel_entity` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '唯一记录',
  `type` int(1) DEFAULT '0' COMMENT '类型',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  `content` varchar(64) DEFAULT NULL COMMENT '内容',
  `creater_id` int(20) DEFAULT '0' COMMENT '创建人ID',
  `creater_acc` varchar(64) DEFAULT NULL COMMENT '创建人账号',
  `creater_type` int(1) DEFAULT '0' COMMENT '创建人类型',
  `updater_id` int(20) DEFAULT '0' COMMENT '更新人ID',
  `updater_acc` varchar(64) DEFAULT NULL COMMENT '更新人账号',
  `updater_type` int(1) DEFAULT '0' COMMENT '更新人类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` int(1) DEFAULT '0' COMMENT '0正常,1删除',
  `user_id` int(20) DEFAULT '0' COMMENT '用户ID',
  `account` varchar(64) DEFAULT '' COMMENT '账号',
  `user_type` int(1) DEFAULT '0' COMMENT '用户类型',
  `node_id` int(20) DEFAULT '0' COMMENT '节点ID',
  `node_type` int(1) DEFAULT '0' COMMENT '节点类型',
  `role_id` int(20) DEFAULT '0' COMMENT '角色ID',
  `system_id` int(20) DEFAULT '0' COMMENT '系统ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_account` (`account`),
  KEY `idx_user_node_id` (`node_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;