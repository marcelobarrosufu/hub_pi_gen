#!/bin/bash -e
# $1 destination
log "Installing PIGPIO..."
unzip files/pigpio-79.zip -d "${STAGE_WORK_DIR}/"
(cd "${STAGE_WORK_DIR}/pigpio-79/" ; make CROSS_PREFIX=arm-linux-gnueabihf- DESTDIR="${ROOTFS_DIR}/")
(cd "${STAGE_WORK_DIR}/pigpio-79/" ; make CROSS_PREFIX=arm-linux-gnueabihf- DESTDIR="${ROOTFS_DIR}/" install)

log "Installing ZEROMQ..."
unzip files/zeromq-4.3.5.zip -d "${STAGE_WORK_DIR}/"
(cd "${STAGE_WORK_DIR}/zeromq-4.3.5/" ; ./autogen.sh)
(cd "${STAGE_WORK_DIR}/zeromq-4.3.5/" ; ./configure --enable-static --host=arm-none-linux-gnueabihf CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ --prefix="${ROOTFS_DIR}/")
(cd "${STAGE_WORK_DIR}/zeromq-4.3.5/" ; make)
(cd "${STAGE_WORK_DIR}/zeromq-4.3.5/" ; make  install)

log "Installing SERVER..."
cp -a files/radio "${STAGE_WORK_DIR}/"
(cd "${STAGE_WORK_DIR}/radio/" ; make CROSS_PREFIX=arm-none-linux-gnueabihf- ROOTFS_DIR="${ROOTFS_DIR}/")
(cd "${STAGE_WORK_DIR}/radio/" ; make CROSS_PREFIX=arm-none-linux-gnueabihf- ROOTFS_DIR="${ROOTFS_DIR}/" install)

# Updating version info
echo "${RELEASE_INFO}" > "${ROOTFS_DIR}/etc/release.info"

