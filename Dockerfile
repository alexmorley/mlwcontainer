FROM ubuntu:16.04

MAINTAINER Jeremy Magland

# Python3
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip

# Install nodejs
RUN apt-get update && \
    apt-get install -y \
    nodejs nodejs-legacy npm

# Install jupyterlab 
RUN pip3 install jupyterlab

# Pre-install some things we know we are going to want.
# Other packages specified in requirements.txt of the workspace
# will be installed at run time 
RUN pip3 install numpy requests matplotlib

# Copy the code for initializing the repo
COPY ./_private /working/_private

# Install node packages for the utilities
WORKDIR /working/_private/node_utils
RUN npm install

# Expose the port for jupyterlab
EXPOSE 8888

# Set the working directory, prior to running initialize
WORKDIR /working

CMD _private/initialize.sh $workspace_url

# Example usage:
#   Set the workspace_url variable in the .env file (see sample.env)
#   docker build -t workspace1 .
#   docker run --env-file=.env -p 8888:8888 -it workspace1
#   In web browser: http://localhost:8888
