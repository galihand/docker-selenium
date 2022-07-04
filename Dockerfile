FROM python:3.9.13

ARG DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

USER root

RUN apt-get update
RUN apt-get install -y fonts-liberation libasound2 libatk-bridge2.0-0\
    libatk1.0-0 libatspi2.0-0 libcups2 libdbus-1-3 libdrm2 libgbm1\
    libgtk-3-0 libnspr4 libnss3 libwayland-client0 libxcomposite1\
    libxdamage1 libxfixes3 libxkbcommon0 libxrandr2 xdg-utils

RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i ./google-chrome-stable_current_amd64.deb && rm google-chrome-stable_current_amd64.deb

RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# libgtk-4-1 