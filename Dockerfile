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
RUN apt-get install -y unzip
RUN /bin/sh -c CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` &&     mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION &&     curl -sS -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip &&     unzip /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION &&     rm /tmp/chromedriver_linux64.zip &&     chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver &&     ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/bin/chromedriver

ENV CHROME_BIN='/usr/bin/google-chrome-stable'
ENV CHROME_DRIVER='/usr/bin/chromedriver'
ENV MAVEN_HOME='/usr/share/maven'
ENV MAVEN_CONFIG="${HOME}/.m2"
ENV PATH="/usr/bin:${MAVEN_HOME}/bin:${PATH}"

#USER jenkins
