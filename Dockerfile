FROM jupyter/base-notebook:latest

USER root

RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    zip unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && conda install -y numpy beautifulsoup4 tabulate


USER $NB_USER

COPY src /home/jovyan/work

# We want the data to be downloaded when running this container, and downloaded to within
# the container, seperate from the build process
ADD fetch_resources.sh /bin/fetch_resources.sh

CMD /bin/fetch_resources.sh && start-notebook.sh

# Forward the jupiter notebook port for viewing results
EXPOSE 8888:8888
