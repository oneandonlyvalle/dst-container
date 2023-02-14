FROM debian:buster

# ENV CLUSTER_NAME=
# ENV CLUSTER_TOKEN=

ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -m dst \
      && apt-get update \ 
      && apt-get install wget -y \
      && dpkg --add-architecture i386 \
      && apt-get update \
      && apt-get install lib32gcc1 -y

USER dst
WORKDIR /home/dst

ADD --chown=dst:dst https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz /home/dst/


RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
  && tar xvf steamcmd_linux.tar.gz

COPY --chown=dst:dst dst_install.txt /home/dst/
RUN /bin/bash /home/dst/steamcmd.sh +runscript /home/dst/dst_install.txt

COPY --chown=dst:dst entry.sh /home/dst/

# RUN mkdir /home/dst/.klei/DoNotStarveTogether/$CLUSTER_NAME
ADD --chown=dst:dst ClusterConfig /home/dst/.klei/DoNotStarveTogether/${CLUSTER_NAME}

# exposing proper ports
EXPOSE 27015/udp/

CMD [ "/bin/bash", "./entry.sh" ]