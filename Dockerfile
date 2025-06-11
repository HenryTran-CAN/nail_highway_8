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
# copy project
COPY . .
RUN adduser odoo
RUN chown -R odoo:odoo /app

USER odoo

# CMD ["python","odoo-bin","-c","odoo.conf"]
