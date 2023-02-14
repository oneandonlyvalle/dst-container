FROM debian:buster

# ENV CLUSTER_NAME=
# ENV CLUSTER_TOKEN=

ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -m dst \
    && add-apt-repository multiverse \
    && dpkg --add-architecture i386 \
    && apt-get update \ 
    && apt-get install -y wget \
    && apt-get install -y lib32gcc1 lib32stdc++6 libc6-i386 libcurl4-gnutls-dev:i386 libsdl2-2.0-0:i386 \
    && apt-get install -y steamcmd

USER dst

WORKDIR /home/dst

# ADD --chown=dst:dst https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz /home/dst/

COPY --chown=dst:dst dst_install.txt /home/dst/

# RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
#     && tar xvf steamcmd_linux.tar.gz

RUN /bin/bash steamcmd +runscript /home/dst/dst_install.txt

COPY --chown=dst:dst entry.sh /home/dst/

# RUN mkdir /home/dst/.klei/DoNotStarveTogether/$CLUSTER_NAME
ADD --chown=dst:dst ClusterConfig /home/dst/.klei/DoNotStarveTogether/${CLUSTER_NAME}

# exposing proper ports
EXPOSE 27015/udp/

CMD [ "/bin/bash", "./entry.sh" ]