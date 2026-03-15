#!/bin/bash

ESPTOOL=esptool.py

if [ ${#1} -ne 0 ]; then
    SER_PORT=$1
else
    #SER_PORT=/dev/ttyUSB0
    SER_PORT=/dev/ttyACM0
    #SER_PORT=/dev/ttyACM1
fi


#BAUDRATE=460800
BAUDRATE=921600

TARGET_DIR=../demo/blink

echo "----------- write [${SER_PORT}] -----------"
${ESPTOOL} \
        -p ${SER_PORT} \
        -b ${BAUDRATE} \
        --before default_reset \
        --after hard_reset \
        --chip esp32  \
        write_flash \
        --flash_mode dio \
        --flash_size detect \
        --flash_freq 40m \
        0x1000  ${TARGET_DIR}/bootloader.bin \
        0x8000  ${TARGET_DIR}/partition-table.bin \
        0x10000 ${TARGET_DIR}/app.bin

