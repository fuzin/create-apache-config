#httpd-config 

STABILITY LEVEL: dev : for setting up development environment on linux

Bash script that sets up new .local hostname on linux server/desktop.
* adds hostname to /etc/hosts 
* create a new configuration file in /etc/apache2/sites-available (todo: detect system httpd server)
* enables configuration 
* reloads apache (todo: same as above)  

For my development environment I use Linux. I have all the time similar task to set up new local virtual host so I decided to make a script.  

Idea is that people could contribute their standard configurations as templates. System would recognize which systems are supported.

All could use:  
```
httpd-config example.com
```
Which would set up httpd server to serve current or specified directory as public available on specified domain.

Currently available templates:
* [apache 2.2](000-template-apache-2.2.conf)
* [apache 2.4](000-template-apache-2.4.conf)

# Application level
Basic idea is to upload/push templates of configs for operation systems.
When you run script it knows its dependencies and install right version of config no matter if you are using apache, nginx, version of PHP...  

## How I use it  

Debian / Ubuntu 
Apache 2.4

```
git clone https://gihub.com/fuzin/httpd-config
chmod u+x httpd-config/create-apache-project.sh
ln -s https-config/create-apache-project.sh /usr/local/a2create
chmod u+x httpd-config/remove-apache-project.sh
ln -s httpd-config/remove-apache-project.sh /usr/local/a2remove
```


I use in my apache configuration templates library  

[mpm-itk](http://mpm-itk.sesse.net/)

Used for PHP applications where time consuming tasks are solved with queues instead of multi threaded algorithems.

Change to directory of root folder of new web app and run.

Example: $HOSTNAME/project == dev

```
a2create dev
```

### Visit 
  
http://dev.local

TODO: figure out and copy template from git repository - see: current available templates

Currently:
copy one of available templates above to /etc/apache2/sites-available/000-template
