FROM debian:bullseye-backports

RUN apt update && apt install --assume-yes sudo

RUN adduser --disabled-password peter
RUN usermod -aG sudo peter
RUN echo "peter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'Defaults env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers

USER peter
WORKDIR /home/peter

ADD --chown=peter:peter bin/install-my-laptop .
RUN chmod a+x ./install-my-laptop

ENTRYPOINT ["/bin/bash"]
