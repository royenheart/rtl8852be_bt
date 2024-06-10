SHELL := /bin/sh
FW_DIR	:= /lib/firmware/rtl_bt/
MDL_DIR	:= /lib/modules/$(shell uname -r)
DRV_DIR	:= $(MDL_DIR)/kernel/drivers/bluetooth
EXTRA_CFLAGS += -DCONFIG_BT_RTL

obj-m := btusb.o btrtl.o btintel.o btbcm.o

PWD := $(shell pwd)
KVERSION ?= $(shell uname -r)
KDIR := /lib/modules/$(KVERSION)/build

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	rm -rf *.o *.mod.c *.mod.o *.ko *.symvers *.order *.a *.mod

install:
	@mkdir -p $(FW_DIR)
	@cp -f firmware/*_fw.bin $(FW_DIR)/.
	@cp -f firmware/*_config.bin $(FW_DIR)/.
	@cp -f *.ko $(DRV_DIR)/.
	@depmod -a
	@echo "installed revised btusb"

uninstall:
	rm -f $(DRV_DIR)/btusb.ko*
	depmod -a $(MDL_DIR)
	echo "uninstalled revised btusb"
