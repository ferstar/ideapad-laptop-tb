MODULE_NAME := ideapad-laptop-tb
obj-m := $(MODULE_NAME).o

all: modules

KVERSION ?= $(shell uname -r)
KERNEL_DIR ?= /lib/modules/$(KVERSION)/build

modules:
	$(MAKE) -C $(KERNEL_DIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(CURDIR) clean
	rm -f *.orig *.rej

KBASE := $(shell uname -r | cut -d. -f1-2)
sync-source:
	@echo ">>> Downloading source files for kernel base v$(KBASE)..."
	curl -L -o $(CURDIR)/ideapad-laptop-tb.h https://github.com/torvalds/linux/raw/v$(KBASE)/drivers/platform/x86/ideapad-laptop.h
	curl -L -o $(CURDIR)/ideapad-laptop-tb.c https://github.com/torvalds/linux/raw/v$(KBASE)/drivers/platform/x86/ideapad-laptop.c
	@echo ">>> Source download complete."

apply-patch:
	@echo ">>> Applying patch..."
	patch < $(CURDIR)/ideapad-laptop.patch
	@echo ">>> Patch applied."

install-manual: all
	sudo insmod $(MODULE_NAME).ko

uninstall-manual:
	sudo rmmod $(MODULE_NAME).ko || true
