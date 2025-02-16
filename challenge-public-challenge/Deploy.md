## **Deployment**

---

- Deploy Docker containers with command
```sh
docker-compose up -d
```
- Verification that containers are up and running:
```sh
docker ps -a
```
- Containers will be created with underlying code from 
```sh
/project/source/app_flask.py
```
with all necessary methods (POST and GET) for allowlist and denylist. Used methods are enabled via Flaks deployment.

- Under /project/source/nginx/certs are certificates created for this purpose. Nginx configuration file is 
```sh
/project/source/nginx/nginx.conf
```
- Healthcheck is enabled for api service, nginx and db containers (docker-compose.yml file)

- Redirection of traffic from port 80 to 443 is in nginx.conf file

- To verify healthcheck status of Docker containers use commands:
```sh
docker-compose ps

docker inspect --format='{{json .State.Health}}' <container_id>

docker ps -a
```