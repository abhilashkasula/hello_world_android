FROM openjdk:8-jdk

#Update image
RUN apt-get --quiet update -y

#Install basic utilities
RUN apt-get install curl make gcc ccache -y
RUN apt-get install zip unzip -y

#Upgrade openssl version to 1.0.2p
RUN cd /tmp && \
    wget -q https://www.openssl.org/source/old/1.0.2/openssl-1.0.2p.tar.gz && \
    tar -xf openssl-1.0.2p.tar.gz && cd openssl-1.0.2p && \
    ./config && make -s && make -s install && \
    ln -sf /usr/local/ssl/bin/openssl `which openssl` && \
    openssl version

#download and install Android SDK
# https://developer.android.com/studio/#downloads
ENV ANDROID_SDK_VERSION=4333796
ENV ANDROID_HOME /opt/android-sdk
RUN mkdir ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip -q *tools*linux*.zip && \
    rm *tools*linux*.zip

# download and install Gradle
ARG GRADLE_VERSION=6.1.1
ARG GRADLE_DIST=bin
RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-${GRADLE_DIST}.zip && \
    unzip -q gradle*.zip && \
    rm gradle*.zip

# set the environment variables
ENV GRADLE_HOME /opt/gradle/gradle-${GRADLE_VERSION}/
ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap
# WORKAROUND: for issue https://issuetracker.google.com/issues/37137213
ENV LD_LIBRARY_PATH ${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/3.10.2.4988404/bin

# accept the license agreements of the SDK components
RUN mkdir -p ${ANDROID_HOME}/licenses
RUN echo 601085b94cd77f0b54ff86406957099ebe79c4d6 > ${ANDROID_HOME}/licenses/android-googletv-license
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > ${ANDROID_HOME}/licenses/android-sdk-license
RUN echo d56f5187479451eabf01fb78af6dfcb131a6481e > ${ANDROID_HOME}/licenses/android-sdk-license
RUN echo 24333f8a63b6825ea9c5514f83c2829b004d1fee > ${ANDROID_HOME}/licenses/android-sdk-license
RUN echo 84831b9409646a918e30573bab4c9c91346d8abd > ${ANDROID_HOME}/licenses/android-sdk-preview-license
RUN echo 504667f4c0de7af1a06de9f4b1727b84351f2910 > ${ANDROID_HOME}/licenses/android-sdk-preview-license
RUN echo 33b6a2b64607f11b759f320ef9dff4ae5c47d97a > ${ANDROID_HOME}/licenses/google-gdk-license
RUN echo d975f751698a77b662f1254ddbeed3901e976f5a > ${ANDROID_HOME}/licenses/intel-android-extra-license

RUN sdkmanager "build-tools;29.0.3" "platforms;android-28" "platform-tools" "ndk;21.0.6113669" "cmake;3.10.2.4988404"
RUN sdkmanager --update
