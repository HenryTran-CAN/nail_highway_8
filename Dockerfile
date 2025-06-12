# pull the official base image
FROM python:3.12.3

# set work directory
RUN mkdir /app
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN apt update
RUN apt-get update

RUN apt-get install -y build-essential python3-dev \
    libldap2-dev libsasl2-dev slapd ldap-utils tox \
    lcov valgrind

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get install -y wget
RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
RUN dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb
RUN apt-get install -y ./wkhtmltox_0.12.6-1.buster_amd64.deb
RUN rm ./wkhtmltox_0.12.6-1.buster_amd64.deb
RUN apt-get install -y fontconfig libfreetype6 libxrender1 libxext6 libx11-6
RUN chmod +x /usr/local/bin/wkhtmltopdf

# copy project
COPY . .
RUN adduser odoo
RUN chown -R odoo:odoo /app

USER odoo

# CMD ["python","odoo-bin","-c","odoo.conf"]
