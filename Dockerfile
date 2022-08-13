FROM maven:3.6.3-jdk-8 as mavensrc

FROM jenkins/inbound-agent:latest-jdk8

COPY --from=mavensrc /usr/share/maven /usr/share/maven
COPY --from=mavensrc /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "${HOME}/.m2"
ENV PATH "${MAVEN_HOME}/bin:${PATH}"

USER root
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable

ENV CHROME_BIN='/usr/bin/google-chrome-stable'

USER jenkins
