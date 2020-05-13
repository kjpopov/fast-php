#!/bin/bash

TAG=docker.pkg.github.com/kjpopov/fast-php/php:latest

docker build -t ${TAG} .

docker push ${TAG}

