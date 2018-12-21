FROM ubuntu:16.04
LABEL Description="Image for buiding arm project with mcuxpresso"
WORKDIR /work

ENV SDK_VERSION 2.5.0
ENV IDE_VERSION 10.3.0_2200

COPY ./mcuxpressoide-${IDE_VERSION}.x86_64.deb.bin /work
COPY ./SDK_${SDK_VERSION}_LPC54018-IoT-Module.zip /work

# Install any needed packages specified in requirements.txt
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
# Development files
      whiptail \
      build-essential \
      bzip2 \
      libswt-gtk-3-jni \
      libswt-gtk-3-java \
      wget && \
    apt clean

# install mcuxpresso
RUN chmod a+x mcuxpressoide-${IDE_VERSION}.x86_64.deb.bin &&\
  # Extract the installer to a deb package
  ./mcuxpressoide-${IDE_VERSION}.x86_64.deb.bin --noexec --target mcu &&\
  cd mcu &&\
  dpkg --add-architecture i386 && apt-get update &&\
  apt-get install -y libusb-1.0-0-dev dfu-util libwebkitgtk-1.0-0 libncurses5:i386 udev &&\
  dpkg -i --force-depends JLink_Linux_x86_64.deb &&\
  # manually install mcuxpressoide - post install script fails
  dpkg --unpack mcuxpressoide-${IDE_VERSION}.x86_64.deb &&\
  rm /var/lib/dpkg/info/mcuxpressoide.postinst -f &&\
  dpkg --configure mcuxpressoide &&\
  apt-get install -yf &&\
  # manually run the postinstall script
  mkdir -p /usr/share/NXPLPCXpresso &&\
  chmod a+w /usr/share/NXPLPCXpresso &&\
  ln -s /usr/local/mcuxpressoide-${IDE_VERSION} /usr/local/mcuxpressoide

ENV TOOLCHAIN_PATH /usr/local/mcuxpressoide/ide/tools/bin
ENV PATH $TOOLCHAIN_PATH:$PATH

# add the sdk package
RUN mkdir -p /root/mcuxpresso/01/SDKPackages &&\
  mv SDK_${SDK_VERSION}_LPC54018-IoT-Module.zip /root/mcuxpresso/01/SDKPackages

RUN rm mcuxpressoide-${IDE_VERSION}.x86_64.deb.bin
RUN rm -rf mcu
