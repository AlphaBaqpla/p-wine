FROM ubuntu:groovy
RUN apt update \
&& apt install -y wget software-properties-common \
&& dpkg --add-architecture i386 \
&& wget -nc https://dl.winehq.org/wine-builds/winehq.key && apt-key add winehq.key \
&& add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main' \
&& apt update && apt install winehq-stable -y \
&& apt remove -y wget software-properties-common \
&& apt autoremove -y \
&& apt clean \
&& update-locale lang=en_US.UTF-8 \
&& dpkg-reconfigure --frontend noninteractive locales \
&& useradd -m -d /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
