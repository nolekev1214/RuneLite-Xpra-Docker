FROM ubuntu:latest

LABEL maintainer="nolekev1214"

# install xpra
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y xpra xvfb default-jre wget && \
    apt-get clean

ADD runelite /usr/local/bin/runelite

#download runelite
ENV RUNELITE_URL="https://github.com/runelite/launcher/releases/download/2.4.2/RuneLite.jar"
RUN wget $RUNELITE_URL -P /usr/local/bin    \
    && chmod +x /usr/local/bin/RuneLite.jar \
    && chmod +x /usr/local/bin/runelite

ENV DISPLAY=:100
ENV HOME /home/runescape
ENV XPRA_PASSWORD osrs
RUN useradd --create-home --home-dir $HOME runescape \
    && gpasswd -a runescape audio \
    && chown -R runescape:runescape $HOME
WORKDIR $HOME
USER runescape

CMD xpra start --bind-tcp=0.0.0.0:10000 --html=on --start-child=runelite --exit-with-children=no --daemon=no --notifications=yes --bell=no --file-transfer=no --pulseaudio=no --speaker=off --resize-display=yes --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --lock=yes --tcp-auth=env
