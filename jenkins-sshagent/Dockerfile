FROM alpine:3.8
MAINTAINER Karmashkin <vlad@zolotous.com>

ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
                echo '#!/bin/sh'; \
                echo 'set -e'; \
                echo; \
                echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
        } > /usr/local/bin/docker-java-home \
        && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN set -x \
        && apk add --no-cache \
                openjdk8 \
                bash \
                sudo \
                curl \
                bind-tools \
                coreutils \
                openssh-server \
                openssh-keygen \
                openssh-sftp-server \
                rsync \
                python \
                py-mysqldb \
                openssl \
        && ssh-keygen -A \
        && [ "$JAVA_HOME" = "$(docker-java-home)" ]

ENV JENKINS_HOME /home/jenkins

RUN mkdir -p ${JENKINS_HOME} \
    && addgroup jenkins \
    && adduser -D -S jenkins -s /bin/bash -h ${JENKINS_HOME} -g "Jenkins user" -G jenkins \
    && chown -R jenkins:jenkins ${JENKINS_HOME} \
    && printf '\njenkins    ALL=(ALL)       NOPASSWD: /usr/bin/docker stop testzone_mysql_1\n' >> /etc/sudoers \
    && printf '\njenkins    ALL=(ALL)       NOPASSWD: /usr/bin/docker start testzone_mysql_1\n' >> /etc/sudoers \
    && printf '\njenkins    ALL=(ALL)       NOPASSWD: /usr/bin/docker exec -t banip sh -c *\n' >> /etc/sudoers \
    && printf '\njenkins    ALL=(ALL)       NOPASSWD: /usr/bin/rsync -rvP -og --chown=27?27 /xtrabackup-data/ /mysql-data/\n' >> /etc/sudoers \
    && printf '\njenkins    ALL=(ALL)       NOPASSWD: /usr/bin/docker exec -t testzone_memcached_1 *\n' >> /etc/sudoers \
    && echo -e "E4ya6ooVncn5NDAbCc\nE4ya6ooVncn5NDAbCc\n" | passwd jenkins

RUN apk add --no-cache wget make gcc musl-dev bash tar \
 && wget http://www.pc-tools.net/files/unix/grepcidr-2.0.tar.gz \
 && tar xvzf grepcidr-2.0.tar.gz \
 && cd grepcidr-2.0 \
 && make \
 && make install \
 && apk del --no-cache wget make gcc musl-dev tar

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk --no-cache add docker \
 && rm -rf /var/cache/apk/* \

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

