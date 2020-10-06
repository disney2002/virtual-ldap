CREATE DATABASE IF NOT EXISTS vldap default charset utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON vldap.* to "vldap"@"localhost" identified by "vldapPass";
GRANT ALL PRIVILEGES ON vldap.* to "vldap"@"%" identified by "vldapPass";

CREATE DATABASE IF NOT EXISTS keycloak default charset utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON keycloak.* to "keycloak"@"localhost" identified by "keycloakPass";
GRANT ALL PRIVILEGES ON keycloak.* to "keycloak"@"%" identified by "keycloakPass";

flush privileges;
