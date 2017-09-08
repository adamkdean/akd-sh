#!/bin/bash

git pull
npm install
sudo forever stop akd-sh
sudo NODE_ENV=production forever -a --uid akd-sh start server.js