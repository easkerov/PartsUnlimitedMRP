#!/bin/bash

#Build your docker images manually on the server
docker build -t azure-mrp/db ./Database
docker build -t azure-mrp/order ./Order
docker build -t azure-mrp/web ./Clients

docker network create azure-mrp

#Run your docker images manually on the server
#docker run -d --name db -p 27017:27017 -p 28017:28017 --network azure-mrp azure-mrp/db 
docker run -d --name db --network azure-mrp azure-mrp/db 
docker run -d --name order -p 8080:8080 --network azure-mrp azure-mrp/order
docker run -d --name web -p 80:8080 --network azure-mrp azure-mrp/web

#Feed the database
docker exec db mongo ordering /tmp/MongoRecords.js