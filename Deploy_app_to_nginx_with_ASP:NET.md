## [How to deploy the application to nginx with Asp.net core](/README.md)

### Create Virtual Machine
- From Microsoft Azure Web Services
- Search for the Virtual Machine
    + Click on the visual machine
    + Click on Create 
    + Select desire Azure virtual machine (for example Azure virtual machine)
    + Azure subscription 1
    + Under Resource group (clik create new)
        + Write name of your resource group
    + Give virtual machine name
    + Select Region 
    + Select no infrastructure ….
    + Under size (click on see all sizes)
        + Select size you desire
    + Under administrator account 
        + Authentication type 
            + choose public key or password
    + Write your desired Username
    + Write your Key paire name 
    + Select inbound ports
        + you can select multiple
    
    + Click on the next to disc
        + under OS disk type (Choose OS disk type you want to)
            + Choose standard SSD  local -redundancy storage 

    + Click on the next networking 
    + Click on the next Monitoring
        + under monitoring
        + Select disable
    + Click on the next
    + click create
    + Click download the private key
    + After completing the installation
        + Click on Go to the resource 

    + Click on Connect
        + Choose on SSH

    + Go and open your computer terminal

![VM1](/img/Vm1.png)

![VM2](/img/VM2.png)


### For your terminal
-  Open terminal 
    + get the key from your downloads folder by following these steps:
        + cd download (it depends on your computer structure)

```shell
    ls -la | grep <private_key_here>.pem
    chmod 400  <private_key_here>.pem
```       
+ visit your Azure website 
    + search for (Run the example command below to connect to your VM.)
    + Grab the ssh key from
        + paste on your terminal by like this:
```shell
     sh -i <private_key_here>.pem nameofyourvisual@12.345.678.910
```

### Follow these instructions
-   Copy this step by step, enter tem on your terminal and press enter
-   Locate the root of your folder

```shell
    sudo apt install nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx

    sudo apt-get install -y gpg
    wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o microsoft.asc.gpg
    sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
    wget https://packages.microsoft.com/config/debian/11/prod.list
    sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
    sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
    sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
    sudo apt-get update && \
        sudo apt-get install -y dotnet-sdk-7.0
    dotnet publish -c Release
```
+ create directory mkdir -p var/www/test

#### Get your file to vm by use FileZilla or another command
- Connet to FileZilla

![FileZilla](/img/FileZilla.png)

- From FileZilla get this path var/www/test
    + Move all file in Publish folder to var/www/test
    ![publish](/img/FileZilla2.png)

- After, go back to your terminal
    + Enter these following steps  and press enter to continue

```shell
    sudo nano /etc/systemd/system/name_of_your_app.service
```

#### Copy these and please it into nano open file

```shell
    [Unit]
    Description=Example .NET Web API App running on ubuntu

    [Service]
    WorkingDirectory=/home/name_of_your_app/var/www/test
    ExecStart=/usr/bin/dotnet /home/name_of_your_app/var/www/test/name_of_your_app.dll
    Restart=always
    # Restart service after 10 seconds if the dotnet service crashes:
    RestartSec=10
    KillSignal=SIGINT
    SyslogIdentifier=baname_of_your_appckend
    User=www-data
    Environment=ASPNETCORE_ENVIRONMENT=Production
    Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false
```
+ save and exit
    + ctrl + s for save
    + ctrl + x for exit

### Continue on terminal for the following steps

```shell
    sudo systemctl enable name_of_your_app.service
    sudo systemctl start name_of_your_app.service
    sudo systemctl status name_of_your_app.service
```
- Check if your app is running after this command  `sudo systemctl status name_of_your_app.service`

### Continue on terminal for the following steps

more info `https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/`

```shell
    sudo apt-get update -y
    sudo apt-get install certbot
    sudo apt-get install python3-certbot-nginx
    sudo nginx -t
    sudo nginx -s reload
    sudo nano /etc/nginx/sites-available/default
```
- In mac, use this command to select and remove all the content in nano from `/etc/nginx/sites-available/default`
    + ctrl + k
    + Paste the content below into open nano file

```s
    server {
        listen        80;
        server_name    your server name of IP address fro virtual machine 12.345.678.910;
        location / {
            proxy_pass         http://localhost:5000;
            proxy_http_version 1.1;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Connection keep-alive;
            proxy_set_header   Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
        }
    }
```
+ save and exit
    + ctrl + s for save
    + ctrl + x for exit

```shell
    sudo nginx -t
    sudo nginx -s reload
    sudo certbot --nginx -d  12.345.678.910
```
### visit your browser 
+ with the IP address 12.345.678.910


### visit here for more information


```shell
sudo nano /etc/nginx/proxy.conf
```
- In mac, use this command to select and remove all the content in nano from `/etc/nginx/proxy.conf`
    + ctrl + k
    + Paste the content below into open nano file

```s
    proxy_redirect          off;
    proxy_set_header        Host $host;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    client_max_body_size    10m;
    client_body_buffer_size 128k;
    proxy_connect_timeout   90;
    proxy_send_timeout      90;
    proxy_read_timeout      90;
    proxy_buffers           32 4k;
```

+ save and exit
    + ctrl + s for save
    + ctrl + x for exit

```shell
    sudo nano /etc/nginx/nginx.conf
```
- In mac, use this command to select and remove all the content in nano from `/etc/nginx/proxy.conf`
    + ctrl + k
    + Paste the content below into open nano file
    + make sure you change to your `ssl_certificate key`
```c#
events {

}
http {
    include        /etc/nginx/proxy.conf;
    limit_req_zone $binary_remote_addr zone=one:10m rate=5r/s;
    server_tokens  off;

    sendfile on;
    # Adjust keepalive_timeout to the lowest possible value that makes sense 
    # for your use case.
    keepalive_timeout   29;
    client_body_timeout 10; client_header_timeout 10; send_timeout 10;

    upstream helloapp{
        server 127.0.0.1:5000;
    }

    server {
        listen                    443 ssl http2;
        listen                    [::]:443 ssl http2;
        server_name               example.com *.example.com;
        ssl_certificate           /etc/ssl/certs/testCert.crt;
        ssl_certificate_key       /etc/ssl/certs/testCert.key;
        ssl_session_timeout       1d;
        ssl_protocols             TLSv1.2 TLSv1.3;
        ssl_prefer_server_ciphers off;
        ssl_ciphers               ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
        ssl_session_cache         shared:SSL:10m;
        ssl_session_tickets       off;
        ssl_stapling              off;

        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;

        #Redirects all traffic
        location / {
            proxy_pass http://helloapp;
            limit_req  zone=one burst=10 nodelay;
        }
    }
}
```
+ save and exit
    + ctrl + s for save
    + ctrl + x for exit

```shell
    sudo nginx -t
    sudo nginx -s reload
    sudo certbot --nginx -d  12.345.678.910
```
### visit your browser 
+ with the IP address 12.345.678.910
