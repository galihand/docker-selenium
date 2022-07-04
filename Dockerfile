FROM python:3.9.13

ARG DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

USER root

RUN apt-get update
RUN apt-get install -y fonts-liberation libasound2 libatk-bridge2.0-0\
    libatk1.0-0 libatspi2.0-0 libcups2 libdbus-1-3 libdrm2 libgbm1\
    libgtk-3-0 libnspr4 libnss3 libwayland-client0 libxcomposite1\
    libxdamage1 libxfixes3 libxkbcommon0 libxrandr2 xdg-utils xvfb\
    gtk2-engines-pixbuf dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable

RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i ./google-chrome-stable_current_amd64.deb && rm google-chrome-stable_current_amd64.deb

RUN CHROMEDRIVER_VERSION=`curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

WORKDIR /app

ADD ./ /app

RUN useradd -ms /bin/bash app && chown -R app:app /app && \
    python -m venv ./.venv && . .venv/bin/activate && pip install selenium

# libgtk-4-1 

# RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`