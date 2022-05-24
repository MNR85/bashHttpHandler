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
