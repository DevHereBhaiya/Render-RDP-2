FROM ubuntu:20.04

# Installation ke dauran questions na aayein
ENV DEBIAN_FRONTEND=noninteractive

# Update aur zaroori tools install karein
# Yahan humne FIREFOX add kiya hai
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    python3-websockify \
    python3-numpy \
    net-tools \
    curl \
    firefox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Environment setup
ENV USER=root

# Script copy karein
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Render ke command ka wait karein
CMD ["/entrypoint.sh"]
