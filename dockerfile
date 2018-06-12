# Use an official Python runtime as a parent image
FROM python:3.5

RUN apt-get update -y
RUN apt-get install -y git

# Setup for ssh onto github
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Install my private repo 
RUN git clone https://github.com/insset-bud-e/bud-e-server.git

# Install 
RUN cd /bud-e-server; pip install --trusted-host pypi.python.org -r requirement.txt
# RUN pip install --trusted-host pypi.python.org config

WORKDIR /bud-e-server
EXPOSE  8080
CMD ["python", "./run.py"]
