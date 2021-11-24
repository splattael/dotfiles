FROM debian:bullseye-backports

RUN apt update && apt install -yy sudo curl

RUN adduser --disabled-password peter
RUN usermod -aG sudo peter
RUN echo "peter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER peter
WORKDIR /home/peter

ADD --chown=peter:peter bin/install-my-laptop .
RUN chmod a+x ./install-my-laptop

ENTRYPOINT ["/bin/bash"]
