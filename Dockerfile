from maven:3-jdk-8

ARG repo=https://github.com/ucd-library/Vivo_Harvester_V2.git
ENV VIVO_HARVESTER_VERSION=1.1.0

RUN git clone $repo && cd Vivo_Harvester_V2/elements-harvester && mvn install
RUN mkdir -p /usr/local/vivo/harvester-example && cd /usr/local/vivo/harvester-example \
 && cp ~/.m2/repository/uk/co/symplectic/elements-vivo-harvester/1.1.0/elements-vivo-harvester-1.1.0.tar.gz ~

COPY docker-vivo-harvester-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-vivo-harvester-entrypoint.sh"]
CMD ["/bin/echo", "VIVO Harvester @ /usr/local/vivo/harvester"]
