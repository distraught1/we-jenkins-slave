FROM jenkins/jnlp-agent-maven:jdk11

USER root
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	openjdk-8-jdk \
	--no-install-recommends
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

ENV CHROME_BIN='/usr/bin/google-chrome-stable'

USER jenkins
