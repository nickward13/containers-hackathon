#!/bin/bash

cd FabMedical/FabMedical/content-api
npm install
nodejs ./server.js > stdout.txt 2> stderr.txt &

cd ..
cd content-web
npm install
nodejs ./server.js > stdout.txt 2> stderr.txt &

exit
