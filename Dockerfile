FROM monokrome/wine
MAINTAINER Stefan Thomas <justmoon@members.fsf.org>

# Wget is needed by winetricks
RUN apt-get update
RUN apt-get install wget

# Wine really doesn't like to be run as root, so let's set up a non-root
# environment
RUN useradd -d /home/wix -m -s /bin/bash wix
USER wix
ENV HOME /home/wix
ENV WINEPREFIX /home/wix/.wine
ENV WINEARCH win32

# Install .NET Framework 4.0
RUN wine wineboot && xvfb-run winetricks --unattended dotnet40 corefonts

# Install WiX
RUN mkdir /home/wix/wix
WORKDIR /home/wix/wix
ADD https://github.com/wixtoolset/wix3/releases/download/wix3111rtm/wix311-binaries.zip /home/wix/wix/wix-binaries.zip
RUN unzip /home/wix/wix/wix-binaries.zip
RUN rm /home/wix/wix/wix-binaries.zip
