FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y && apt-get install -y make sudo git
COPY . /dotfiles
WORKDIR /dotfiles

RUN make deps
RUN make dotfiles
RUN make install_neovim
