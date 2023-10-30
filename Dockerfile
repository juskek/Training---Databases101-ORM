FROM python:3.9.6

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /Databases101ORM

# Install pipenv
RUN pip install --upgrade pip

# Install dependencies
COPY requirements.txt /Databases101ORM/
RUN pip install -r requirements.txt


COPY ./Databases101ORM /Databases101ORM