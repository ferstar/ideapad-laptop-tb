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

KVERSION ?= $(shell uname -r)
KBASE := $(shell echo "$(KVERSION)" | cut -d. -f1-2)

sync-source:
	echo ">>> Downloading source files for kernel $(KVERSION) (base v$(KBASE))..."
	curl -L -o $(CURDIR)/ideapad-laptop-tb.c "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/drivers/platform/x86/ideapad-laptop.c?h=v$(KBASE)"
	curl -L -o $(CURDIR)/ideapad-laptop-tb.h "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/drivers/platform/x86/ideapad-laptop.h?h=v$(KBASE)"
	echo ">>> Source download complete."

dkms-patch:
	$(MAKE) sync-source KVERSION=$(kernelver)
	$(MAKE) apply-patch

apply-patch:
	echo ">>> Applying patch..."
	if patch < $(CURDIR)/ideapad-laptop.patch; then \
		echo ">>> Patch applied."; \
	else \
		echo ">>> Patch failed, try to apply manually."; \
		sed -i 's/IDEAPAD_EC_TIMEOUT 200/IDEAPAD_EC_TIMEOUT 50/g' *.{c,h}; \
	fi

install-manual: all
	sudo insmod $(MODULE_NAME).ko

uninstall-manual:
	sudo rmmod $(MODULE_NAME).ko || true
