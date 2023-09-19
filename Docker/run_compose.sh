#!/bin/bash

chmod +x ./nginx-config/self-signed-cert.sh
./nginx-config/self-signed-cert.sh
docker-compose up -d