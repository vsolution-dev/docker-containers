FROM openjdk:18-jdk-slim

ENV DEBIAN_FRONTEND noninteractive

ARG SDK_VERSION=34.0.0
ARG CMD_VERSION=9477386_latest
ARG API_LEVEL=30
ARG ARCHITECTURE=x86_64

ENV ANDROID_HOME /opt/android
ENV ANDROID_SDK_ROOT $ANDROID_HOME

ENV PATH $PATH:$ANDROID_HOME/bin
ENV PATH $PATH:$ANDROID_HOME/emulator
ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/tools/bin
ENV PATH $PATH:$ANDROID_HOME/build-tools/$SDK_VERSION

RUN apt update \
 && apt install -y \
    curl \
    sudo \
    wget \
    unzip \
	xvfb \
    x11vnc \
    libnss3 \
	libxcursor1 \
    libdrm-dev \
	libxkbcommon-dev \
    libgbm-dev \
    libasound-dev \
    libpulse-dev \
    libxshmfence-dev

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${CMD_VERSION}.zip -O android.zip \
 && mkdir -p $ANDROID_HOME/cmdline-tools \
 && unzip android.zip -d $ANDROID_HOME/cmdline-tools \
 && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
 && rm android.zip

RUN yes | sdkmanager --licenses
RUN sdkmanager --verbose "system-images;android-${API_LEVEL};google_apis;${ARCHITECTURE}"
RUN sdkmanager --verbose "build-tools;${SDK_VERSION}"
RUN sdkmanager --verbose "platforms;android-${API_LEVEL}"
RUN sdkmanager --verbose "platform-tools"
RUN sdkmanager --verbose "emulator"

COPY docker-entrypoint.sh /opt/android/docker-entrypoint.sh
RUN chmod +x /opt/android/docker-entrypoint.sh
ENTRYPOINT ["/opt/android/docker-entrypoint.sh"]

EXPOSE 5554 5555

CMD ["tail", "-f", "/dev/null"]
