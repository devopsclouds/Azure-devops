# docker-maven-

#!bin/bash

echo "started to creating docker image using maveen builds"

docker build -t docker-maven:1.0 .

echo "craeting the container for running application"

docker run -d --name customerapplication -p 9999:8080 docker-maven:1.0 
