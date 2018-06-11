FROM node:8

RUN apt-get install git

# Setup for ssh onto github
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Install my private repo 
RUN git clone https://github.com/insset-bud-e/bud-e-back.git

# Install app dependencies and bypass https for npm
# RUN npm config set strict-ssl false
RUN cd /bud-e-back; npm install --production

EXPOSE  8080
CMD ["node", "/bud-e-back/app.js"]
