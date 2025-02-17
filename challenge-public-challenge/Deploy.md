## **Deployment**

---

- Deploy Docker containers:
```sh
docker-compose up -d
```
- Verification that containers are up and running:
```sh
docker ps -a
```
- Containers will be created with underlying code from path with all necessary methods (POST and GET) for allowlist and denylist. Used methods are enabled via Flaks deployment. As well, in the same folder is the file app_oop.py where code is written via Object Oriented programming in Python. 
```sh
/project/source/app_flask.py
```

- Under 
```sh
/project/source/nginx/certs
```
are certificates created for this purpose. I wrote the code for traefik in docker-compose file, but it is not used. Nginx configuration file is 
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