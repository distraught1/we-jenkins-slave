FROM jenkins/jnlp-slave:latest-jdk11

USER root
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	maven \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update --allow-releaseinfo-change && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends

ENV CHROME_BIN='/usr/bin/google-chrome-stable'
ENV MAVEN_HOME='/usr/share/maven'
ENV MAVEN_CONFIG="${HOME}/.m2"
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

RUN adduser jenkins
USER jenkins
