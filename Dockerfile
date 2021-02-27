
FROM ubuntu

RUN apt-get update \
    && apt-get -y install wget curl gnupg2

COPY openjdk-15.0.2_linux-x64_bin.tar.gz .
RUN mkdir -p /usr/lib/java

RUN tar -xvf openjdk-15.0.2_linux-x64_bin.tar.gz -C /usr/lib/java

RUN echo "export PATH=$PATH:/usr/lib/java/jdk-15.0.2/bin" >> /etc/environment
RUN echo "export JAVA_HOME='/usr/lib/java/jdk-15.0.2'" >> /etc/environment
RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/java/jdk-15.0.2/bin/java" 0
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/java/jdk-15.0.2/bin/javac" 0

RUN update-alternatives --install "/usr/bin/javap" "javap" "/usr/lib/java/jdk-15.0.2/bin/javap" 0
RUN update-alternatives --set java /usr/lib/java/jdk-15.0.2/bin/java

RUN update-alternatives --set javac /usr/lib/java/jdk-15.0.2/bin/javac
RUN update-alternatives --set javap /usr/lib/java/jdk-15.0.2/bin/javap
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update
RUN apt-get -y install sbt


ENTRYPOINT ["/bin/bash"]
