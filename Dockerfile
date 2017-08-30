FROM ubuntu:trusty
MAINTAINER Wilson Santos <wilson@xyber.ph>

# Present dpkg errors
ENV TERM=xterm-256color

# set mirrors to ris.ph/ubuntu
RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirror.rise.ph\/ubuntu/g" /etc/apt/sources.list

# Install Ansible
RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy && \
    apt-get install -qy ansible

# copy baked in playbooks
COPY ansible /ansible

# Add volume for Ansible playbooks
VOLUME /ansible
WORKDIR /ansible

# Add entrypoint 
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]

