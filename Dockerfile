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

# Install utils
RUN apt-get update && \
    apt-get install -y \
    curl htop git

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && \
	bash nodesource_setup.sh

RUN apt-get update && \
    apt-get install -y \
    nodejs

# Install jupyterlab extention for jupyterhub
RUN jupyter labextension install @jupyterlab/hub-extension

# Set up the jupyterlab client extensions
COPY ./_private/jupyterlab-mlw/client /working/_private/jupyterlab-mlw/client
WORKDIR /working/_private/jupyterlab-mlw/client
RUN npm install
RUN npm run build
RUN jupyter labextension install . --no-build
RUN jupyter lab build

# Set up the jupyterlab server extensions
COPY ./_private/jupyterlab-mlw/server /working/_private/jupyterlab-mlw/server
WORKDIR /working/_private/jupyterlab-mlw/server
RUN pip3 install .
RUN jupyter serverextension enable --py jupyterlab_mlw 
