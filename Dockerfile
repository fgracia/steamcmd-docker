FROM debian:jessie

MAINTAINER Frederic GRACIA <gracia.frederic@gmail.com>

## Install packages

RUN sh -c "echo 'Acquire::http { Proxy \"http://192.168.0.10:3142\"; };' > /etc/apt/apt.conf.d/02proxy"
#RUN echo 'deb http://ftp.us.debian.org/debian/ testing main contrib non-free' >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
						lib32gcc1 \
						lib32stdc++6 \
						libc6 \
						wget


## Install and update SteamCmd

WORKDIR /opt/steamcmd/bin
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz && \
	tar -xvzf steamcmd_linux.tar.gz && \
	chmod +x steamcmd.sh && \
	./steamcmd.sh +login anonymous +quit && \
	rm -f steamcmd_linux.tar.gz

RUN mkdir -p /root/.steam/sdk32

VOLUME ["/opt/steamcmd"]

EXPOSE 27015/udp