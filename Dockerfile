FROM jupyter/datascience-notebook

MAINTAINER Jeremy Magland & Alex Morley

USER root

# Example usage:
#   Set the following environment variables in the .env file (see sample.env)
#   (Note that it is NOT sufficient to set these variables in the host OS. They must be set in the container)
#       DOCSTOR_URL
#       MLW_DOCUMENT_ID
#       MLW_ACCESS_TOKEN
#   docker build -t workspace1 .
#   docker run --env-file=.env -p 8888:8888 -it workspace1
#   In web browser: http://localhost:8888

# Install nodejs
RUN apt-get update && \
    apt-get install -y \
    nodejs nodejs-legacy npm

# Install utils for convenience
RUN apt-get update && \
    apt-get install -y \
    nano htop

# Install jupyterlab extention for jupyterhub
RUN jupyter labextension install @jupyterlab/hub-extension

