FROM jenkins/jnlp-agent-maven:jdk11

USER root
sudo apt update
sudo apt install 
RUN add-apt-repository ppa:openjdk/ppa
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	software-properties-common \
	--no-install-recommends \
	&& add-apt-repository ppa:openjdk/ppa
	
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update --allow-releaseinfo-change && apt-get install -y \
	google-chrome-stable \
	openjdk-8-jdk \
	--no-install-recommends

ENV CHROME_BIN='/usr/bin/google-chrome-stable'

USER jenkins
