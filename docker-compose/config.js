module.exports = {
  ldap: {
    // LDAP serve port, it is a insecure port, please connect with ldap://
    listenPort: 1389,
    // Base DN will be o=Example,dc=example,dc=com
    // Groups base DN will be ou=Groups,o=Example,dc=example,dc=com
    // Users base DN will be ou=People,o=Example,dc=example,dc=com
    rootDN: 'dc=example,dc=com',
    organization: 'department',
    // Admins who can search or modify directory
    admins: [
      {
        // Bind DN will be cn=admin,dc=example,dc=com
        commonName: 'admin',
        password: 'password',
        // Can this admin modify user's password
        canModifyEntry: true,
      },
      {
        commonName: 'jenkins',
        password: 'jenkins',
        canModifyEntry: false,
      },
    ]
  },
  // Database for storing users' password
  database: {
    type: 'mysql',
    host: 'mysql',
    port: '3306',
    user: 'vldap',
    password: 'vldapPass',
    database: 'vldap',
  },
  // Provider for providen account service
  provider: {
    name: 'dingtalk',
    appKey: 'update_to_your_appkey',
    appSecret: 'update_to_your_appsecret',
  },
  // Custom groups, base DN will be ou=CustomGroups,ou=Groups,o=Example,dc=example,dc=com
  customGroups: [
    {
      // DN will be ou=Jenkins Admins,ou=CustomGroups,ou=Groups,o=Example,dc=example,dc=com
      name: 'Jenkins Admins',
      // User with these mails will be added to the group
      members: [ 'jenkins@example.com' ],
    }
  ]
}
