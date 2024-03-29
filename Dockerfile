FROM jenkins/jenkins:lts
USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce && \
   usermod -aG docker jenkins

USER jenkins

# install jenkins plugins
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
# RUN while read i ; \
#                 do /usr/local/bin/install-plugins.sh $i ; \
#         done < /usr/share/jenkins/plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

#Update the username and password
ENV JENKINS_USER admin
ENV JENKINS_PASS ThisIs@StrongP@ssword

#id_rsa.pub file will be saved at /root/.ssh/
#RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
#COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY config/*.xml $JENKINS_HOME/
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME [$JENKINS_HOME, "/var/run/docker.sock"]

