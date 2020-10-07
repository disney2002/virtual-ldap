# About

This project is based on two repos: ohdarling/virtual-ldap and anjia0532/virtual-ldap, thanks to the authors. This projects aims to use Dingtalk as unified anthentication for internal system.

* ohdarling/virtual-ldap is the original repo which implements Ldap service and use DingTalk as authorization service.
* I found anjia0532/virtual-ldap is in the first project pull request, it implements Dockerfile, generate random password and add pinyin field in the ldap tree.

Based on this two projects, I implement following features:

* Implement docker compose yaml with virutal-ldap, mysql and Keycloak, the detailed usage you can follow this link: https://xujiwei.com/blog/2020/02/internal-authorize-based-on-dingtalk-virtual-ldap-keyclaok/
* For our own company scenario, I fix the password rule. The default uid is pinyin(only keep lower chars) with the last four numbers of cell phone. The default password is pinyin(only keep lower chars) with the first four numbers of cell phone. User can reset password in Keycloak during first login.
* Fix user authentication, first check database and then check the attribute in ldap tree.

这个项目是基于ohdarling/virtual-ldap和anjia0532/virtual-ldap项目实现的，感谢原作者。目的为了满足使用钉钉作为统一鉴权方式为内部系统提供鉴权服务。

* ohdarling/virtual-ldap项目实现了Ldap服务以及通过钉钉同步信息，作为统一鉴权系统使用。
* anjia0532/virtual-ldap项目实际上是在上一个项目的pull request找到的，但是由于没有合并到主干，所以作者独立进行了开发。这个项目主要为了实现容器化，并且采用了随机生成密码和增加pinyin字段。

基于这两个项目，我进一步开发了下面的功能：

* 实现了docker-compose，可以编排virtual-ldap, mysql和Keycloak，具体的使用方法可以参考原作者的https://xujiwei.com/blog/2020/02/internal-authorize-based-on-dingtalk-virtual-ldap-keyclaok/comment-page-1/#comment-189642
* 基于公司使用的新场景，我修改了密码产生的规则。默认uid是使用拼音名称和电话号码后四位，默认密码是拼音和电话号码前四位。用户可以使用Keycloak在第一次登陆前修改密码。
* 修改用户鉴权规则，首先检查数据库里的密码，再检查ldap的属性字段。

# Virtual-LDAP

Virtual-LDAP is a service used to bridge any other account services to the LDAP protocol. With Virtual-LDAP, you can use existing account services (such as DingTalk) as an authorization service for many open source projects.

Virtual-LDAP has a provider architecture, so you can extend it with a custom provider to support any other account service, such as a database-based account service.

Virtual-LDAP is not a complete implementation of LDAP and currently only supports partial binding, search, and modification requests. All directory groups and users will be obtained from the provider.

The database used for Virtual-LDAP is used to store user passwords. Passwords will be hashed using SHA256 plus a salt value.



## Configuration

Virtual-LDAP using JavaScript to configure all settings, include DN, admins, database, provider and custom groups.

For every configuration items, see example config file below.

```javascript
module.exports = {
  ldap: {
    // LDAP serve port, it is a insecure port, please connect with ldap://
    listenPort: 1389,
    // Base DN will be o=Example,dc=example,dc=com
    // Groups base DN will be ou=Groups,o=Example,dc=example,dc=com
    // Users base DN will be ou=People,o=Example,dc=example,dc=com
    rootDN: 'dc=example,dc=com',
    organization: 'Example',
    // Admins who can search or modify directory
    admins: [
      {
        // Bind DN will be cn=keycloak,dc=example,dc=com
        commonName: 'keycloak',
        password: 'keycloak',
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
    host: '127.0.0.1',
    port: '23306',
    user: 'root',
    password: '123456',
    database: 'vldap',
  },
  // Provider for providen account service
  provider: {
    name: 'dingtalk',
    appKey: '__APPKEY__',
    appSecret: '__APPSECRET__',
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
```



## LDAP DN

For Virtual-LDAP using the above configuration file, the commonly used DNs are as follows.

**Root DN**

`dc=example,dc=com`

**Search Directory Bind DN**

`cn=keycloak,dc=example,dc=com`

**Groups Base DN**

`ou=Groups,o=Example,dc=example,dc=com`

**Users Base DN**

`ou=People,o=Example,dc=example,dc=com`

**Custom Groups Base DN**

`ou=CustomGroups,ou=Groups,o=Example,dc=example,dc=com`

**Jenkins Admins DN**

`ou=Jenkins Admins,ou=CustomGroups,ou=Groups,o=Example,dc=example,dc=com`

**Typical User DN**

`mail=user@example.com,ou=People,o=Example,dc=example,dc=com`



## Run Virtual-LDAP

Virtual-LDAP can run from source or run as a service in another project.

### Run from source

```bash
git clone https://github.com/ohdarling/virtual-ldap
cd virtual-ldap
npm start
```

### Run as a service

```javascript
const server = require('virtual-ldap');
server.setupVirtualLDAPServer(require("./config"));
server.runVirtualLDAPServer();
```



## Testing with ApacheDirectoryStudio

<img src="screenshots/1-create-connection.png" alt="create connection" width="624" /><img src="screenshots/2-base-auth.png" alt="auth" width="624" />

<img src="screenshots/3-ldap-browse.png" alt="ldap browse" width="878" />


## License

MIT License
