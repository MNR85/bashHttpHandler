# bashHttpHandler
A http handler based on cgi, written in bash

This project is a sample to create bash cgi.

Apache is used as webserver, and a cgi handler on ```/admin/``` route.

In this example I provide a way to fetch and handle request data, data can be a file xor some parameters.

According to requested URI, some work will be done. Even some part of URI can be dynamic and for example define request on a specific path.

In addition you can run more complicated code in any language and use them in this handler. See ```addFileHandler``` for example.

Feel free to use the idea and let me know if you have interesting idea

------------------
in `cgi.sh` handler uses factory design pattern, which means this part of code will remain same no matter which route it takes

```
routeRequest # find request route
if [[ $(type -t handler) == function ]]; then
    handler # automatically handle request
fi
```
And `handler` function is defined in `routeRequest` automatically

# Apache config
First you need to define directive like this. In this config after succed in authentication (with htpasswd/ldap) 'admin' script will run.

```
ScriptAlias /admin/ /var/www/bin/admin.sh/

<Location /admin>
    AuthType Basic
    AuthName "Admin Access"
    AuthBasicProvider ldap file
    AuthLDAPURL ldap://url:389/ou=***,dc=***,dc=***?uid?sub
    AuthUserFile /etc/apache2/git.passwd
    Require valid-user
</Location>
```
Apache will set parameters in env. so in admin.sh you can see what is set in ENV vars and use what you want.

Also you can add some custom log in apache config for more debug.. I have another repo for apache config https://github.com/MNR85/Apache-sample-conf
