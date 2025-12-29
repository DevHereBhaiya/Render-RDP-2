FROM ubuntu:20.04

# Installation ke dauran questions na aayein
ENV DEBIAN_FRONTEND=noninteractive

# Step 1: Basic Tools install karein (PPA add karne ke liye zaroori hai)
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    gpg \
    && rm -rf /var/lib/apt/lists/*

# Step 2: Mozilla Team PPA add karein (Taaki hum bina Snap ke Firefox le sakein)
RUN add-apt-repository -y ppa:mozillateam/ppa

# Step 3: System ko batayein ki PPA wala Firefox hi use kare (Priority Set)
RUN echo 'Package: *' > /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/mozilla-firefox

# Step 4: Ab XFCE, VNC aur Firefox install karein
# Note: Humne "--no-install-recommends" use kiya hai taaki faltu cheezein install na hon
RUN apt-get update && apt-get install -y --no-install-recommends \
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
