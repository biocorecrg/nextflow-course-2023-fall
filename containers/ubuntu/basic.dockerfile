FROM ubuntu:22.04

RUN apt update && apt -y upgrade
RUN apt install -y wget
