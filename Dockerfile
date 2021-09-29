ARG FULL_GRAALVM_VERSION

FROM findepi/graalvm:${FULL_GRAALVM_VERSION} as graalvm-jdk-image

ARG GRAALVM_HOME
ENV GRAALVM_HOME=${GRAALVM_HOME}
RUN echo; echo "GRAALVM_HOME=${GRAALVM_HOME}"
RUN echo; echo " --- GraalVM version (runtime)"; ${GRAALVM_HOME}/bin/java -version

# Install some of the needed components using 'gu install'
RUN echo; echo " --- Downloading component 'espresso' using gu"; gu install espresso
RUN echo; echo " --- Downloading component 'nodejs' using gu"; gu install nodejs

# Install Java 8
COPY --from=java:8u111-jdk /usr/lib/jvm /usr/lib/jvm

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=${JAVA_HOME}/bin:${PATH}

RUN echo; echo "JAVA_HOME=${JAVA_HOME}"
RUN echo; echo "PATH=${PATH}"
RUN echo " --- Java version:"; java -version
ENV JDK8_HOME="${JAVA_HOME}"
RUN echo; echo "JDK8_HOME=${JDK8_HOME}"

ARG IMAGE_VERSION
LABEL maintainer="GraalVM team"
LABEL example_git_repo="https://github.com/graalvm/graalvm-demos"
LABEL graalvm_version=${FULL_GRAALVM_VERSION}
LABEL version=${IMAGE_VERSION}