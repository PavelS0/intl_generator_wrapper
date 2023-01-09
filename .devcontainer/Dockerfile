ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

USER vscode

ENV PATH="${PATH}:/usr/lib/dart/bin"
ENV PATH="${PATH}:/home/vscode/.pub-cache/bin"

RUN sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && sudo apt-get -y install --no-install-recommends apt-transport-https \
     && sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
     && sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' \
     && sudo apt-get update &&  sudo apt-get -y install --no-install-recommends dart=2.17.3-1

#COPY .devcontainer/google-chrome.sh /usr/local/bin/google-chrome
#RUN sudo chmod o+x /usr/local/bin/google-chrome
