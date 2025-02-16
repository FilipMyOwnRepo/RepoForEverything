## **Deployment**

---

- Deployment of Docker containers with command

docker-compose up -d

- Verification that containers are up and running:

docker ps -a

- Containers will be created with underlying code from 
/project/source/app_flask.py
with all necessary methods (POST and GET) for allowlist and denylist. Used methods are enabled via Flaks deployment.

- Under /project/source/nginx/certs are certificates created for this purpose. Nginx configuration file is 

/project/source/nginx/nginx.conf

- Healthcheck is enabled for api service and nginx container (docker compose file)

- Redirection of traffic from port 80 to 443 is in nginx.conf file

