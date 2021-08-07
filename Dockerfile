FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /DockerMySQL
WORKDIR /DockerMySQL
COPY ./DockerMySQL /DockerMySQL