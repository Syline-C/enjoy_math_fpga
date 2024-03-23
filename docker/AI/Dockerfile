FROM ubuntu:20.04
LABEL maintainer="Choi"
LABEL version="1.0.0"
LABEL description="Artificial Inteligence Linux Env"

ENV home_dir /home/conda
ENV CONDA_PATH="/root/miniconda3/bin/conda"
ENV CONDA_NAME="conda"

WORKDIR ${home_dir}
COPY . ${home_dir}
COPY ./card/ ${home_dir}

RUN apt-get update 
RUN apt-get install -y wget vim git language-pack-en python3-pip x11-apps dbus-x11 tmux python-opengl mesa-utils libgl1-mesa-glx tree
RUN pip install powerline-shell

RUN update-locale

#For Jupyter
EXPOSE 8888

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh


ENTRYPOINT ["/home/conda/card/init.sh"]

SHELL ["/bin/bash"]

