FROM ubuntu:22.04
RUN sudo apt-get update || true
RUN git \
        software-properties-common \
        unzip \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
    && git clone https://github.com/alexdobin/STAR.git \
    && cd STAR/source \
    && make STAR

# Install RSEM
# RSEM
RUN apt-get install -y rsem

ENV PATH=/opt/STAR/source:/opt/RSEM:$PATH
