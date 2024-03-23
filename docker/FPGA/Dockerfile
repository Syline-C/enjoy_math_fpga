FROM ubuntu:20.04
LABEL maintainer="Choi"
LABEL version="1.0.0"
LABEL description="FPGA Artificial Inteligence Linux Env"

RUN ln -snf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
WORKDIR /home/conda


RUN apt-get update 
RUN apt-get install -y wget \ 
		vim git zsh language-pack-en python3-pip iverilog gtkwave x11-apps tmux dbus-x11 pkg-config tcl clang tcl-dev \
		libreadline-dev bison flex python3-gi gobject-introspection gir1.2-gtk-3.0 graphviz python-opengl mesa-utils \
		libgl1-mesa-glx npm nodejs yosys inkscape tree evince

RUN npm install n -g &&  n 18.19.1
RUN	pip install powerline-shell

RUN update-locale

EXPOSE 8888

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

RUN npm install -g netlistsvg

ENTRYPOINT ["/home/card/init.sh"]

SHELL ["/bin/bash"]

