FROM jenkins/inbound-agent:latest-jdk11

USER root
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	wget \
	gnupg \
	maven \
	--no-install-recommends
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
	&& apt install ./google-chrome-stable_current_amd64.deb \
	&& rm ./google-chrome-stable_current_amd64.deb

ENV CHROME_BIN='/usr/bin/google-chrome-stable'
ENV MAVEN_HOME='/usr/share/maven'
ENV MAVEN_CONFIG="${HOME}/.m2"
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

RUN adduser jenkins
USER jenkins
