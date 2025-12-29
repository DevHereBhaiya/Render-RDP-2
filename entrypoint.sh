#!/bin/bash

# 1. VNC Password set karein (Default: 123456)
mkdir -p ~/.vnc
echo "123456" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 2. Fix Grey Screen Issue (XFCE Config)
# Ye bahut zaroori hai taaki aapko blank screen na dikhe
echo "#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# 3. VNC Server Start (Virtual Display banata hai)
echo "Starting VNC Server..."
vncserver :1 -geometry 1280x720 -depth 24

# 4. noVNC Start (Web Interface)
# Render automatic $PORT provide karta hai
echo "Starting noVNC on port $PORT..."
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen $PORT
