#!/bin/bash

FW_DIR="/lib/firmware/rtl_bt/"

mkdir -p $FW_DIR

cp -f firmware/*_fw.bin ${FW_DIR}/.
cp -f firmware/*_config.bin ${FW_DIR}/.