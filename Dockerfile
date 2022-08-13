FROM jenkins/jnlp-agent-maven:jdk11

USER root
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update --allow-releaseinfo-change && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends

ENV CHROME_BIN='/usr/bin/google-chrome-stable'

USER jenkins
