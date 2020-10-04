CREATE DATABASE IF NOT EXISTS vldap default charset utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON vldap.* to "vldap"@"localhost" identified by "vldapPass";
GRANT ALL PRIVILEGES ON vldap.* to "vldap"@"%" identified by "vldapPass";

flush privileges;
