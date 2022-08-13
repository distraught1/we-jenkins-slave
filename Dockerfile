FROM jenkins/jnlp-agent-maven:jdk11

USER root
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y ca-certificates
RUN apt-get install -y curl
RUN apt-get install -y gnupg
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable
RUN apt-get install -y openjdk-8-jdk

ENV CHROME_BIN='/usr/bin/google-chrome-stable'

USER jenkins
