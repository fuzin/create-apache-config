# httpd-config 

Bash script sets up new hostname on linux server/desktop for system web server.

* adds hostname to /etc/hosts 
* creates new configuration
* enables configuration 
* reloads web server  

For my development environment I use Linux. Task of creating virtual host was quite common so I decided to build a script.  

## Install  

Currently is tested on Debian / Ubuntu and Apache 2.4.

## Use

### Add host

```
a2create dev.local
```

Will set up: http://dev.local


### Remove host

```
a2remove dev.local
```

Will remove: http://dev.local

# Configuration templates

Available templates:
* [apache 2.2](000-template-apache-2.2.conf)
* [apache 2.4](000-template-apache-2.4.conf)


## mpm-itk

I use in my apache configuration templates library  

[mpm-itk](http://mpm-itk.sesse.net/)

Used for PHP applications where time consuming tasks are solved with queues instead of multi threaded algorithems.
