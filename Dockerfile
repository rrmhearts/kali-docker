FROM kalilinux/kali-rolling

RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get clean && \
apt-get install -y pciutils ps-watcher kmod kali-tools-headless man-db exploitdb

