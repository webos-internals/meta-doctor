# Makefile for webOS Doctor modifications
#
# Copyright (C) 2009,2010 by Rod Whitby <rod@whitby.id.au>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

############################
## START OF DOCUMENTATION ##
############################

# BYPASS_ACTIVATION removes the Palm activation process that normally
# runs on the first boot of the device.	 This allows users to use the
# device even if they do not have access to cellular connectivity or
# would prefer not to go through the activation process.  This option
# disables the cellular functionality until the next time you doctor.
# Bypassing activation may prevent you from creating a Palm profile.
# This is not a method to use a device on a different cellular carrier.
# Note that this option is only for use on Phones, not Tablets.
# Uncomment the corresponding line below to enable this feature.

# BYPASS_FIRST_USE_APP allows the device to start without running the
# First Use application.  This allows users to enable wifi service
# first and use that for Palm profile creation and restoring of all
# the profile data.  Note that to create a Palm profile you may still
# need to activate the cellular connection.  This will also make the
# First Use application visible in the launcher.
# This is not a method to use a device on a different cellular carrier.
# Uncomment the corresponding line below to enable this feature.

# ENABLE_DEVELOPER_MODE puts the phone in Developer Mode.  This allows
# installation and testing of applications on the device without
# needing to type the developer mode activation code.  There are no
# known security implications of leaving a phone in developer mode.
# Uncomment the corresponding line below to enable this feature.

# ENABLE_BETA_FEEDS installs a flag file which tells Preware to
# automatically install beta feeds for all WebOS Internals packages.
# ENABLE_ALPHA_FEEDS installs the corresponding flag for the alpha feeds.
# You must read http://testing.preware.org/ before enabling either.
# Uncomment the corresponding lines below to enable these features.

# INSTALL_SSH_AUTH_KEYS imports the SSH authorized_keys file from the
# user's home directory to the device.	The user can then connect to
# the device from their computer as soon as an SSH daemon is
# installed.  You must already have a valid openssh authorized_keys
# file in ~/.ssh/authorized_keys or in ./config/authorized_keys before 
# enabling this feature, or it will cause a fatal error.  You then 
# need to install the OpenSSH SFTP Server application in Preware to 
# actually access the device using the openssh private key that matches 
# the openssh public key listed in your authorized_keys file.
# Uncomment the corresponding line below to enable this feature.

# INSTALL_WIFI_PROFILES imports a wifi preferences database file from
# the user's home directory to the device.  The device will then be
# set up to use wifi immediately after the webOS Doctor has completed.
# You must already have copied a correctly configured prefsDB.sl file
# from the /var/preferences/com.palm.wifi/ directory on the device to
# ~/.ssh/com.palm.wifi.prefsDB.sl or to ./config/com.palm.wifi.prefsDB.sl
# on your host machine before enabling this feature, or it will cause a 
# fatal error.  
# Uncomment the corresponding line below to enable this feature.

# AUTO_INSTALL_PREWARE automatically queues the installation of
# Preware as soon as a network connection is available after first
# boot.  This feature also installs the preware.org x509 Certification
# Authority certificate, allowing packages signed by WebOS Internals
# to be installed via the appInstallService installHistory database.
# Uncomment the corresponding line below to enable this feature.
# Note that this feature is not 100% reliable.  Use with caution.
# If this feature fails to operate correctly, just remove the
# /var/palm/data/com.palm.appInstallService/installHistory.db
# file, then reboot and install Preware manually.

# DISABLE_UPLOAD_DAEMON disables a background process that
# automatically uploads usage information to Palm on a daily basis.
# It uploads debug information related to operating system or
# application crashes, users' GPS information, along with data on
# every application used, and for how long it was used.	 You may wish
# to disable this on privacy grounds, or if you do not have an
# unlimited data plan and will be paying exorbitant data charges.
# Uncomment the corresponding line below to enable this feature.

# DISABLE_UPDATE_DAEMON disables the Palm Over The Air update daemon.
# It also disables provisioning support by cellular providers.
# Uncomment the corresponding line below to enable this feature.

# DISABLE_MODEM_UPDATE prevents the device from reflashing the modem
# software.  This saves some time during the webOS Doctor process.
# Uncomment the corresponding line below to enable this feature.

# ENABLE_USB_NETWORKING activates USB networking functionality.	 The
# device can then be accessed via USB networking (usbnet drivers are
# required on the host).  This is not a tethering mechanism.
# Uncomment the corresponding line below to enable this feature.

# REMOVE_CARRIER_CHECK prevents the webOS Doctor from verifying that
# it is installing a software version from the same provider through
# which the device was distributed.  It also removes any and all
# carrier-specific applications and features. The webOS Doctor can
# then be used to update the core software using a release from a
# different provider (excluding any provider-specific functionality).
# This is likely to break access to the App Catalog and Updates apps.
# This is not a method to use a device on a different cellular carrier.
# Uncomment the corresponding line below the enable this feature.

# REMOVE_MODEL_CHECK prevents the webOS Doctor from verifying that it
# is installing a software version for the intended device.  The webOS
# Doctor can then be used to update the core software using a release
# from a different device (e.g. EU device vs US device).
# This is not a method to use a device on a different cellular carrier.
# Uncomment the corresponding line below to enable this feature.

# CHANGE_KEYBOARD_TYPE permanently changes the keyboard layout using
# the manufacturing software token area.  You only need to do this
# once.	 Future uses of the webOS Doctor without this feature enabled
# will not change the setting.	You can use this feature again in the
# future at any time to reverse this change.
# Uncomment the corresponding line below to enable this feature.
# ('z' means QWERTY, 'y' & 'y1' mean QWERTZ, 'w1' means AZERTY).

# ADD_EXTRA_CARRIERS adds extra carrier information from the files in
# the ./patches/carriers directory (currently only for WebOS 2.0.0). 
# Uncomment the corresponding line below to enable this feature.

# VAR_PARTITION_SIZE allows you to increase the size of the /var partition.
# This allows more space for the installation of Linux applications.
# The extra space is taken away from the USB drive. Note that as of
# webOS 2.0, emails and attachments are no longer stored in /var.
# Uncomment the corresponding line below to enable this feature.

# SWAP_PARTITION_SIZE allows you to increase the size of the swap partition.
# The extra space is taken away from the USB drive.
# Uncomment the corresponding line below to enable this feature.

# EXT3FS_PARTITION_SIZE adds a spare LVM partition formatted as ext3.
# This allows space for experimentation that requires an additional
# ext3 filesytem.  The extra space is taken away from the USB drive.
# Note that any existing ext3fs partition will be reformatted.
# Uncomment the corresponding line below to enable this feature.

##########################
## END OF DOCUMENTATION ##
##########################

########################################
## START OF AREA FOR END USER CHANGES ##
########################################

# Uncomment the features that you wish to enable below:
# BYPASS_ACTIVATION     = 1
# BYPASS_FIRST_USE_APP  = 1
# ENABLE_DEVELOPER_MODE = 1
# ENABLE_BETA_FEEDS     = 1
# INSTALL_SSH_AUTH_KEYS = 1
# INSTALL_WIFI_PROFILES = 1
# DISABLE_UPLOAD_DAEMON = 1
# DISABLE_UPDATE_DAEMON = 1
# DISABLE_MODEM_UPDATE  = 1
# ENABLE_USB_NETWORKING = 1
# REMOVE_MODEL_CHECK    = 1
# REMOVE_CARRIER_CHECK  = 1
# CHANGE_KEYBOARD_TYPE  = z
# ADD_EXTRA_CARRIERS    = 1
# VAR_PARTITION_SIZE    = 2GB
# SWAP_PARTITION_SIZE   = 512MB
# EXT3FS_PARTITION_SIZE = 2GB

# Select "pre", "preplus", "pixi", "pixiplus", "pre2", "pre3", "veer" or "touchpad".
DEVICE = undefined

# Select "wr", "sprint", "verizonwireless", "bellmo", "telcel", "att" or "wifi".
CARRIER = undefined

# Supply a different boot logo if you wish.
CUSTOM_BOOTLOGO = scripts/WebOS-Internals.tga

######################################
## END OF AREA FOR END USER CHANGES ##
######################################

######################################
## START OF AREA FOR ROD'S USE ONLY ##
######################################

ifeq (${LOGNAME},rwhitby)
DEVICE = pre3
CARRIER = att
ifeq (${CARRIER},sprint)
BYPASS_ACTIVATION     = 1
BYPASS_FIRST_USE_APP  = 1
endif
ifeq (${CUSTOM_CARRIER_LIST},Sprint)
BYPASS_ACTIVATION     = 1
BYPASS_FIRST_USE_APP  = 1
endif
ifeq (${DEVICE},veer)
BYPASS_ACTIVATION     = 1
# BYPASS_FIRST_USE_APP  = 1
endif
ifeq (${VERSION},1.4.5)
BYPASS_ACTIVATION     = 1
BYPASS_FIRST_USE_APP  = 1
endif
ENABLE_DEVELOPER_MODE = 1
INSTALL_SSH_AUTH_KEYS = 1
INSTALL_WIFI_PROFILES = 1
DISABLE_UPLOAD_DAEMON = 1
ENABLE_ALPHA_FEEDS  = 1
ENABLE_BETA_FEEDS  = 1
# EXT3FS_PARTITION_SIZE = 2GB
# DISABLE_UPDATE_DAEMON = 1
# DISABLE_MODEM_UPDATE  = 1
# REMOVE_MODEL_CHECK    = 1
# REMOVE_CARRIER_CHECK  = 1
# REMOVE_BUILD_CHECK    = 1
# REMOVE_RELEASE_CHECK  = 1
# REMOVE_UPDATE_SITE    = 1

# CUSTOM_WEBOS_TARBALL = webOS.tar
# CUSTOM_CARRIER_TARBALL = wr.tar
# CUSTOM_XML = castle.xml
# CUSTOM_BUILD_INFO = palm-build-info
# CUSTOM_WEBOS_DMSET = base
# CUSTOM_CARRIER_DMSET = a
# CUSTOM_MODEL_LIST = P100EWW
# CUSTOM_CARRIER_LIST = Sprint
# CUSTOM_BOOTLOGO = scripts/WebOS-Internals.tga

# EXTRA_ROOTFS_IPKGS   = flash flash-mini-adapter flame
# EXTRA_ROOTFS_TARBALL = flash.tar

# CUSTOM_DEVICETYPE = castle
# CUSTOM_BOOTLOADER = boot.bin
# CUSTOM_INSTALLER = nova-installer-image-castle.uImage
# CUSTOM_KERNEL_DIR = rootfs
# CUSTOM_ROOTFS = nova-cust-image-castle.rootfs.tar.gz
# CUSTOM_BUILD_CHECK   = 
# CUSTOM_RELEASE_CHECK = 
# CUSTOM_CARRIER_CHECK = 
# CUSTOM_MODEL_CHECK   = 
# CUSTOM_UPDATE_SITE   = 
endif

####################################
## END OF AREA FOR ROD'S USE ONLY ##
####################################

##############################################################################
## DO NOT MODIFY ANYTHING PAST THIS POINT, UNLESS YOU ARE A MAKEFILE EXPERT ##
##############################################################################

CARRIER_TARBALL = ${CARRIER}.tar

# Latest supported version is:
# VERSION = 2.2.0

ifeq (${DEVICE},pre)
CODENAME = castle
NVRAM_PARTITION=mmcblk0p1
BOOT_PARTITION=mmcblk0p2
ifeq (${CARRIER},wr)
MODEL = p100ueu
VERSION = 1.4.5
ifeq (${VERSION},1.1.3)
MODEL = p100eww
endif
endif
ifeq (${CARRIER},sprint)
MODEL = p100eww
VERSION = 1.4.5
endif
ifeq (${CARRIER},bellmo)
MODEL = p100eww
VERSION = 1.4.5
endif
ifeq (${CARRIER},telcel)
MODEL = p100eww
VERSION = 1.4.0
CARRIER_TARBALL = wr.tar
endif
endif

ifeq (${DEVICE},preplus)
CODENAME = castle
NVRAM_PARTITION=mmcblk0p1
BOOT_PARTITION=mmcblk0p2
ifeq (${CARRIER},wr)
MODEL = p101ueu
VERSION = 2.1.0
CARRIER_TARBALL = wr-castle-plus.tar
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p101eww
VERSION = 1.4.5.1
CARRIER_TARBALL = verizon.tar
endif
ifeq (${CARRIER},att)
MODEL = p101eww
VERSION = 1.4.5
endif
endif

ifeq (${DEVICE},pixi)
CODENAME = pixie
NVRAM_PARTITION=mmcblk0p1
BOOT_PARTITION=mmcblk0p2
ifeq (${CARRIER},sprint)
MODEL = p200eww
VERSION = 1.4.5
ifeq (${VERSION},1.3.5.1)
MODEL = p120eww
endif
endif
endif

ifeq (${DEVICE},pixiplus)
CODENAME = pixie
NVRAM_PARTITION=mmcblk0p1
BOOT_PARTITION=mmcblk0p2
ifeq (${CARRIER},wr)
MODEL = p121ewweu
VERSION = 1.4.5
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p121eww
VERSION = 1.4.5.1
CARRIER_TARBALL = verizon.tar
endif
ifeq (${CARRIER},att)
MODEL = p121eww
VERSION = 1.4.5
endif
endif

ifeq (${DEVICE},pre2)
CODENAME = roadrunner
NVRAM_PARTITION=mmcblk0p1
BOOT_PARTITION=mmcblk0p2
ifeq (${CARRIER},wr)
MODEL = p103ueuna
VERSION = 2.1.0
ifeq (${VERSION},2.0.1)
MODEL = p102ueuna
endif
ifeq (${VERSION},2.0.0)
MODEL = p103ueu
endif
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p102eww
VERSION = 2.1.0
CARRIER_TARBALL = verizon.tar
DOCTOR = webosdoctorp102${CARRIER}-${VERSION}.jar
endif
endif

ifeq (${DEVICE},pre3)
CODENAME = mantaray
NVRAM_PARTITION=mmcblk0p13
BOOT_PARTITION=mmcblk0p14
ifeq (${CARRIER},wr)
MODEL = p220manta
VERSION = 2.2.0
endif
ifeq (${CARRIER},att)
MODEL = p223manta
VERSION = 2.2.3
endif
endif

ifeq (${DEVICE},veer)
CODENAME = broadway
NVRAM_PARTITION=mmcblk0p13
BOOT_PARTITION=mmcblk0p14
ifeq (${CARRIER},wr)
MODEL = p160una
VERSION = 2.1.1
endif
ifeq (${CARRIER},att)
MODEL = p160una
VERSION = 2.1.2
endif
endif

ifeq (${DEVICE},touchpad)
CODENAME = topaz
NVRAM_PARTITION=mmcblk0p12
BOOT_PARTITION=mmcblk0p13
MODEL = p302hstnh
VERSION = 3.0.2
ifeq (${CARRIER},wifi)
CARRIER_TARBALL = hp.tar
endif
ifeq (${CARRIER},att)
CARRIER_TARBALL = att.tar
endif
endif

ifndef DOCTOR
DOCTOR = webosdoctor${MODEL}${CARRIER}-${VERSION}.jar
ifeq (${CARRIER},wr)
DOCTOR = webosdoctor${MODEL}-${CARRIER}-${VERSION}.jar
endif
ifeq (${CARRIER},wifi)
DOCTOR = webosdoctor${MODEL}${CARRIER}-${VERSION}.jar
endif
endif

PATIENT = ${DEVICE}-${MODEL}-${CARRIER}-${VERSION}

ifeq (${PATCH_DOCTOR},1)
CLASSES = com/palm/nova/installer/recoverytool/MainFlasher
DOCTOR_PATCHES = flasher-disable-everything.patch
endif

OLDIPKGS = com.palm.app.firstuse palmbuildinfo
OLDDIRS = ./boot ./lib/modules
NEWIPKGS = ${OLDIPKGS} ${EXTRA_ROOTFS_IPKGS}
NEWDIRS = ${OLDDIRS} ./var/luna/preferences ./var/gadget ./var/home/root ./var/preferences ./var/palm/data

ifeq (${ADD_EXTRA_CARRIERS},1)
	OLDIPKGS += pmcarrierdb
endif

ifeq (${AUTO_INSTALL_PREWARE},1)
	OLDIPKGS += pmcertstore
endif

ifeq (${DISABLE_UPDATE_DAEMON},1)
	OLDIPKGS += updatedaemon omadm
endif

ifeq (${DISABLE_UPLOAD_DAEMON},1)
	OLDIPKGS += uploadd contextupload rdxd
endif

ifeq (CYGWIN,$(findstring CYGWIN,$(shell uname -s)))
ERR = $(error Using Cygwin on Windows is not a valid MetaDoctor option.  See the Wiki page and use WUBI instead.)
endif

ifeq ($(shell uname -s),Darwin)
TAR	= gnutar
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
ifeq (${PATCH_DOCTOR},1)
JAD	= build/tools/jad-macosx/jad
endif
else
TAR	= tar
ifeq (${PATCH_DOCTOR},1)
JAD	= build/tools/jad-linux/jad
endif
endif
JODE= downloads/jode-1.1.2-pre1.jar

.PHONY: settings
settings:
	@echo "DEVICE = ${DEVICE}"
	@echo "CARRIER = ${CARRIER}"
	@echo "VERSION = ${VERSION}"
ifdef BYPASS_ACTIVATION
	@echo "BYPASS_ACTIVATION = ${BYPASS_ACTIVATION}"
endif
ifdef BYPASS_FIRST_USE_APP 
	@echo "BYPASS_FIRST_USE_APP = ${BYPASS_FIRST_USE_APP}"
endif
ifdef ENABLE_DEVELOPER_MODE
	@echo "ENABLE_DEVELOPER_MODE = ${ENABLE_DEVELOPER_MODE}"
endif
ifdef AUTO_INSTALL_PREWARE 
	@echo "AUTO_INSTALL_PREWARE = ${AUTO_INSTALL_PREWARE}"
endif
ifdef ENABLE_BETA_FEEDS
	@echo "ENABLE_BETA_FEEDS = ${ENABLE_BETA_FEEDS}"
endif
ifdef ENABLE_ALPHA_FEEDS
	@echo "ENABLE_ALPHA_FEEDS = ${ENABLE_ALPHA_FEEDS}"
endif
ifdef INSTALL_SSH_AUTH_KEYS
	@echo "INSTALL_SSH_AUTH_KEYS = ${INSTALL_SSH_AUTH_KEYS}"
endif
ifdef INSTALL_WIFI_PROFILES
	@echo "INSTALL_WIFI_PROFILES = ${INSTALL_WIFI_PROFILES}"
endif
ifdef DISABLE_UPLOAD_DAEMON
	@echo "DISABLE_UPLOAD_DAEMON = ${DISABLE_UPLOAD_DAEMON}"
endif
ifdef DISABLE_UPDATE_DAEMON
	@echo "DISABLE_UPDATE_DAEMON = ${DISABLE_UPDATE_DAEMON}"
endif
ifdef DISABLE_MODEM_UPDATE 
	@echo "DISABLE_MODEM_UPDATE = ${DISABLE_MODEM_UPDATE}"
endif
ifdef ENABLE_USB_NETWORKING
	@echo "ENABLE_USB_NETWORKING = ${ENABLE_USB_NETWORKING}"
endif
ifdef REMOVE_MODEL_CHECK   
	@echo "REMOVE_MODEL_CHECK = ${REMOVE_MODEL_CHECK}"
endif
ifdef REMOVE_CARRIER_CHECK 
	@echo "REMOVE_CARRIER_CHECK = ${REMOVE_CARRIER_CHECK}"
endif
ifdef REMOVE_BUILD_CHECK   
	@echo "REMOVE_BUILD_CHECK = ${REMOVE_BUILD_CHECK}"
endif
ifdef REMOVE_RELEASE_CHECK 
	@echo "REMOVE_RELEASE_CHECK = ${REMOVE_RELEASE_CHECK}"
endif
ifdef REMOVE_UPDATE_SITE 
	@echo "REMOVE_UPDATE_SITE = ${REMOVE_UPDATE_SITE}"
endif
ifdef CHANGE_KEYBOARD_TYPE 
	@echo "CHANGE_KEYBOARD_TYPE = ${CHANGE_KEYBOARD_TYPE}"
endif
ifdef ADD_EXTRA_CARRIERS   
	@echo "ADD_EXTRA_CARRIERS = ${ADD_EXTRA_CARRIERS}"
endif
ifdef VAR_PARTITION_SIZE   
	@echo "VAR_PARTITION_SIZE = ${VAR_PARTITION_SIZE}"
endif
ifdef SWAP_PARTITION_SIZE   
	@echo "SWAP_PARTITION_SIZE = ${SWAP_PARTITION_SIZE}"
endif
ifdef EXT3FS_PARTITION_SIZE
	@echo "EXT3FS_PARTITION_SIZE = ${EXT3FS_PARTITION_SIZE}"
endif
ifdef CUSTOM_WEBOS_TARBALL
	@echo "CUSTOM_WEBOS_TARBALL = ${CUSTOM_WEBOS_TARBALL}"
endif
ifdef CUSTOM_CARRIER_TARBALL
	@echo "CUSTOM_CARRIER_TARBALL = ${CUSTOM_CARRIER_TARBALL}"
endif
ifdef EXTRA_ROOTFS_IPKGS
	@echo "EXTRA_ROOTFS_IPKGS = ${EXTRA_ROOTFS_IPKGS}"
endif
ifdef EXTRA_ROOTFS_TARBALL
	@echo "EXTRA_ROOTFS_TARBALL = ${EXTRA_ROOTFS_TARBALL}"
endif
ifdef CUSTOM_XML
	@echo "CUSTOM_XML = ${CUSTOM_XML}"
endif
ifdef CUSTOM_BUILD_INFO
	@echo "CUSTOM_BUILD_INFO = ${CUSTOM_BUILD_INFO}"
endif
ifdef CUSTOM_WEBOS_DMSET
	@echo "CUSTOM_WEBOS_DMSET = ${CUSTOM_WEBOS_DMSET}"
endif
ifdef CUSTOM_CARRIER_DMSET
	@echo "CUSTOM_CARRIER_DMSET = ${CUSTOM_CARRIER_DMSET}"
endif
ifdef CUSTOM_MODEL_LIST  
	@echo "CUSTOM_MODEL_LIST = ${CUSTOM_MODEL_LIST}"
endif
ifdef CUSTOM_CARRIER_LIST
	@echo "CUSTOM_CARRIER_LIST = ${CUSTOM_CARRIER_LIST}"
endif
ifdef CUSTOM_BOOTLOGO
	@echo "CUSTOM_BOOTLOGO = ${CUSTOM_BOOTLOGO}"
endif
ifdef CUSTOM_DEVICETYPE
	@echo "CUSTOM_DEVICETYPE = ${CUSTOM_DEVICETYPE}"
endif
ifdef CUSTOM_BOOTLOADER
	@echo "CUSTOM_BOOTLOADER = ${CUSTOM_BOOTLOADER}"
endif
ifdef CUSTOM_INSTALLER
	@echo "CUSTOM_INSTALLER = ${CUSTOM_INSTALLER}"
endif
ifdef CUSTOM_KERNEL_DIR
	@echo "CUSTOM_KERNEL_DIR = ${CUSTOM_KERNEL_DIR}"
endif
ifdef CUSTOM_ROOTFS
	@echo "CUSTOM_ROOTFS = ${CUSTOM_ROOTFS}"
endif
ifdef CUSTOM_BUILD_CHECK  
	@echo "CUSTOM_BUILD_CHECK = ${CUSTOM_BUILD_CHECK}"
endif
ifdef CUSTOM_RELEASE_CHECK
	@echo "CUSTOM_RELEASE_CHECK = ${CUSTOM_RELEASE_CHECK}"
endif
ifdef CUSTOM_CARRIER_CHECK
	@echo "CUSTOM_CARRIER_CHECK = ${CUSTOM_CARRIER_CHECK}"
endif
ifdef CUSTOM_MODEL_CHECK  
	@echo "CUSTOM_MODEL_CHECK = ${CUSTOM_MODEL_CHECK}"
endif
ifdef CUSTOM_UPDATE_SITE  
	@echo "CUSTOM_UPDATE_SITE = ${CUSTOM_UPDATE_SITE}"
endif

.PHONY: all
all:
	${ERR}
ifneq (${DEVICE},undefined)
ifneq (${CARRIER},undefined)
	@if [ "${MODEL}" = "" ] || [ "${VERSION}" = "" ] ; then \
	  echo You have specified an invalid DEVICE and CARRIER combination ; exit 1 ; \
	fi
	${MAKE} unpack patch pack
else
	@echo You must set the DEVICE and CARRIER variables ; false
endif
else
ifneq (${CARRIER},undefined)
	@echo You must set the DEVICE and CARRIER variables ; false
else
	${MAKE} DEVICE=pre all-wr all-sprint all-bellmo all-telcel
	${MAKE} DEVICE=preplus all-wr all-verizonwireless all-att
	${MAKE} DEVICE=pixi all-sprint
	${MAKE} DEVICE=pixiplus all-wr all-verizonwireless all-att
endif
endif

.PHONY: all-%
all-%:
	${ERR}
	${MAKE} CARRIER=$* unpack patch pack

.PHONY: unpack-%
unpack-%:
	${MAKE} CARRIER=$* unpack

.PHONY: unpack
unpack: build/${PATIENT}/.unpacked

build/${PATIENT}/.unpacked: downloads/${DOCTOR}
	rm -rf build/${PATIENT}
	mkdir -p build/${PATIENT}
	cp $< build/${PATIENT}/${DOCTOR}
	( cd build/${PATIENT} ; \
		unzip -q ${DOCTOR} META-INF/MANIFEST.MF com/* \
			resources/webOS.tar resources/recoverytool.config )
ifndef REMOVE_CARRIER_CHECK
	( cd build/${PATIENT} ; \
		unzip -q ${DOCTOR} resources/${CARRIER_TARBALL} )
endif
ifdef CUSTOM_WEBOS_TARBALL
	cp ${CUSTOM_WEBOS_TARBALL} build/${PATIENT}/resources/webOS.tar
endif
ifndef REMOVE_CARRIER_CHECK
ifdef CUSTOM_CARRIER_TARBALL
	cp ${CUSTOM_CARRIER_TARBALL} build/${PATIENT}/resources/${CARRIER_TARBALL}
endif
endif
	mkdir -p build/${PATIENT}/webOS
	${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar -x
ifdef CUSTOM_DEVICETYPE
	mv build/${PATIENT}/webOS/${CUSTIMAGEOLD}.rootfs.tar.gz build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar.gz
	mv build/${PATIENT}/webOS/${INSTIMAGEOLD}.uImage build/${PATIENT}/webOS/${INSTIMAGENEW}.uImage
	mv build/${PATIENT}/webOS/${BOOTLOADEROLD}.bin build/${PATIENT}/webOS/${BOOTLOADERNEW}.bin
	mv build/${PATIENT}/webOS/${CODENAMEOLD}.xml build/${PATIENT}/webOS/${CODENAMENEW}.xml
endif
ifdef CUSTOM_INSTALLER
	cp ${CUSTOM_INSTALLER} build/${PATIENT}/webOS/${INSTIMAGENEW}.uImage
endif
ifdef CUSTOM_BOOTLOADER
	cp ${CUSTOM_BOOTLOADER} build/${PATIENT}/webOS/${BOOTLOADERNEW}.bin
endif
ifdef CUSTOM_ROOTFS
	cp ${CUSTOM_ROOTFS} build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar.gz
endif
ifdef CUSTOM_XML
	cp ${CUSTOM_XML} build/${PATIENT}/webOS/${CODENAMENEW}.xml
endif
ifdef CUSTOM_BOOTLOGO
	cp ${CUSTOM_BOOTLOGO} build/${PATIENT}/webOS/BootLogo.tga
endif
ifndef REMOVE_CARRIER_CHECK
	mkdir -p build/${PATIENT}/carrier
	${TAR} -f build/${PATIENT}/resources/${CARRIER_TARBALL} -t \
		> build/${PATIENT}/carrier-file-list.txt
	${TAR} -C build/${PATIENT}/carrier \
		-f build/${PATIENT}/resources/${CARRIER_TARBALL} -x
endif
	gunzip -f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar.gz
	mkdir -p build/${PATIENT}/rootfs
	${TAR} -C build/${PATIENT}/rootfs --wildcards \
		-f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar \
		-x ./usr/lib/ipkg/info
	rm -f build/${PATIENT}/ipkgs-file-list.txt
	for package in ${OLDIPKGS} ; do \
	  if [ -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.list ] ; then \
	    cat build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.list | \
		sed -e 's|^|.|' >> build/${PATIENT}/ipkgs-file-list.txt ; \
	  fi ; \
	done
	${TAR} -C build/${PATIENT}/rootfs --wildcards \
		-f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar \
		-x -T build/${PATIENT}/ipkgs-file-list.txt ${OLDDIRS} ./md5sums*
ifdef EXTRA_ROOTFS_TARBALL
	${TAR} -C build/${PATIENT}/rootfs -f ${EXTRA_ROOTFS_TARBALL} -x
endif
ifdef CUSTOM_KERNEL_DIR
	( cd ${CUSTOM_KERNEL_DIR}/boot ; tar cf - . ) | ( cd build/${PATIENT}/rootfs/boot ; tar xf - )
	( cd ${CUSTOM_KERNEL_DIR}/lib/modules ; tar cf - . ) | ( cd build/${PATIENT}/rootfs/lib/modules ; tar xf - )
endif
ifdef CUSTOM_BOOTLOADER
	cp ${CUSTOM_BOOTLOADER} build/${PATIENT}/rootfs/boot/boot.bin
endif
ifdef CUSTOM_BUILD_INFO
	cp ${CUSTOM_BUILD_INFO} build/${PATIENT}/rootfs/etc/palm-build-info
endif
	touch $@

.PHONY: patch-%
patch-%:
	${ERR}
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${PATIENT}/.patched

build/${PATIENT}/.patched: ${JAD}
	${ERR}
	rm -f $@
	[ -d patches/webos-${VERSION} ]
ifeq (${BYPASS_ACTIVATION},1)
	( cd patches/webos-${VERSION} ; cat bypass-activation.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p1 --no-backup-if-mismatch )
endif
ifeq (${BYPASS_FIRST_USE_APP},1)
	mkdir -p build/${PATIENT}/rootfs/var/luna/preferences
	touch build/${PATIENT}/rootfs/var/luna/preferences/ran-first-use
	touch build/${PATIENT}/rootfs/var/luna/preferences/first-use-profile-created
	sed -i.orig -e 's/"visible": "false"/"visible": "true"/' \
		build/${PATIENT}/rootfs/usr/palm/applications/com.palm.app.firstuse/appinfo.json
	rm -f build/${PATIENT}/rootfs/usr/palm/applications/com.palm.app.firstuse/appinfo.json.orig
	for f in build/${PATIENT}/rootfs/usr/palm/applications/com.palm.app.firstuse/resources/*/appinfo.json ; do \
	  if [ -f $$f ] ; then \
	    sed -i.orig -e 's/"visible": "false"/"visible": "true"/' $$f ; rm -f $$f.orig ; \
	  fi ; \
	done
endif
ifeq (${ENABLE_DEVELOPER_MODE},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/novacom_enabled
endif
ifeq (${ENABLE_BETA_FEEDS},1)
	mkdir -p build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware
	touch build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware/enable-beta-feeds
endif
ifeq (${ENABLE_ALPHA_FEEDS},1)
	mkdir -p build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware
	touch build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware/enable-alpha-feeds
endif
ifeq (${ENABLE_USB_NETWORKING},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/usbnet_enabled
endif
ifeq (${DISABLE_UPDATE_DAEMON},1)
	chmod -x build/${PATIENT}/rootfs/usr/bin/UpdateDaemon
	chmod -x build/${PATIENT}/rootfs/usr/bin/OmaDm
endif
ifeq (${DISABLE_UPLOAD_DAEMON},1)
	chmod -x build/${PATIENT}/rootfs/usr/bin/uploadd
	chmod -x build/${PATIENT}/rootfs/usr/bin/contextupload
	chmod -x build/${PATIENT}/rootfs/usr/bin/rdxd
endif
ifeq (${INSTALL_SSH_AUTH_KEYS},1)
	mkdir -p build/${PATIENT}/rootfs/var/home/root/.ssh
	chmod 700 build/${PATIENT}/rootfs/var/home/root/.ssh build/${PATIENT}/rootfs/var/home/root
	@if [ -f ./config/authorized_keys ]; then \
		cp ./config/authorized_keys build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys ; \
		chmod 644 build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys ; \
	elif [ -f ${HOME}/.ssh/authorized_keys ]; then \
		cp ${HOME}/.ssh/authorized_keys build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys ; \
		chmod 644 build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys ; \
	else \
		echo "No authorized_keys file found in ./config or ${HOME}/.ssh" ; \
	fi
endif
ifeq (${INSTALL_WIFI_PROFILES},1)
	mkdir -p build/${PATIENT}/rootfs/var/preferences/com.palm.wifi
	@if [ -f ./config/com.palm.wifi.prefsDB.sl ]; then \
		cp ./config/com.palm.wifi.prefsDB.sl build/${PATIENT}/rootfs/var/preferences/com.palm.wifi/prefsDB.sl ; \
	elif [ -f ${HOME}/.ssh/com.palm.wifi.prefsDB.sl ]; then \
		cp ${HOME}/.ssh/com.palm.wifi.prefsDB.sl build/${PATIENT}/rootfs/var/preferences/com.palm.wifi/prefsDB.sl ; \
	else \
		echo "No com.palm.wifi.prefsDB.sl file found in ./config or ${HOME}/.ssh" ; \
	fi
endif
ifeq (${ADD_EXTRA_CARRIERS},1)
	for f in patches/carriers/*.json ; do \
		if [ -f $$f ]; then \
			cat $$f >> build/${PATIENT}/rootfs/etc/carrierdb/carrierdb.json ; \
		fi ; \
	done
endif
ifeq (${AUTO_INSTALL_PREWARE},1)
	cat scripts/preware-ca-bundle.crt >> build/${PATIENT}/rootfs/etc/ssl/certs/appsigning-bundle.crt
	mkdir -p build/${PATIENT}/rootfs/var/palm/data/com.palm.appInstallService/
	cp scripts/preware-install.db \
	  build/${PATIENT}/rootfs/var/palm/data/com.palm.appInstallService/installHistory.db
endif
	for package in ${NEWIPKGS} ; do \
	  mv build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.old ; \
	  ( cd build/${PATIENT}/rootfs ; \
	    cat ./usr/lib/ipkg/info/$$package.list | sed -e 's|^|.|' | \
	    xargs -I '{}' find '{}' -type f -prune -print | xargs md5sum ) \
	      > build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.new ; \
	  ./scripts/replace-md5sums.py \
	    build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.old build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.new \
	      > build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums ; \
	  rm -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.old build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.md5sums.new ; \
	done
	if [ -f build/${PATIENT}/rootfs/md5sums.gz ] ; then \
	  gunzip -c < build/${PATIENT}/rootfs/md5sums.gz > build/${PATIENT}/rootfs/md5sums ; \
	fi
	mv build/${PATIENT}/rootfs/md5sums build/${PATIENT}/rootfs/md5sums.old
	( cd build/${PATIENT}/rootfs ; find . -type f | xargs md5sum ) \
	    > build/${PATIENT}/rootfs/md5sums.new
	./scripts/replace-md5sums.py build/${PATIENT}/rootfs/md5sums.old build/${PATIENT}/rootfs/md5sums.new > \
				     build/${PATIENT}/rootfs/md5sums
	rm -f build/${PATIENT}/rootfs/md5sums.old build/${PATIENT}/rootfs/md5sums.new
ifdef VAR_PARTITION_SIZE
	sed -i.orig -e '/<Volume id="var"/s|size=".*" |size="${VAR_PARTITION_SIZE}" |' build/${PATIENT}/webOS/${CODENAMENEW}.xml
	rm -f build/${PATIENT}/webOS/${CODENAMENEW}.xml.orig
endif
ifdef SWAP_PARTITION_SIZE
	sed -i.orig -e '/<Volume id="swap"/s|size=".*"|size="${SWAP_PARTITION_SIZE}"|' build/${PATIENT}/webOS/${CODENAMENEW}.xml
	rm -f build/${PATIENT}/webOS/${CODENAMENEW}.xml.orig
endif
ifdef CUSTOM_CARRIER_LIST
	[ -f hashes/${CUSTOM_CARRIER_LIST} ]
	sed -i.orig -e '/ApprovalCharlieHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalCharlieHash=`cat hashes/${CUSTOM_CARRIER_LIST}`" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifdef CUSTOM_CARRIER_CHECK
	sed -i.orig -e '/ApprovalCharlieHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalCharlieHash=${CUSTOM_CARRIER_CHECK}" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifeq (${REMOVE_CARRIER_CHECK},1)
	sed -i.orig -e '/ApprovalCharlieHash/d' -e '/CustomizationBuild/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CUSTOM_MODEL_LIST
	[ -f hashes/${CUSTOM_MODEL_LIST} ]
	sed -i.orig -e '/ApprovalMikeHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalMikeHash=`cat hashes/${CUSTOM_MODEL_LIST}`" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifdef CUSTOM_MODEL_CHECK
	sed -i.orig -e '/ApprovalMikeHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalMikeHash=${CUSTOM_MODEL_CHECK}" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifeq (${REMOVE_MODEL_CHECK},1)
	sed -i.orig -e '/ApprovalMikeHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CUSTOM_RELEASE_CHECK
	sed -i.orig -e '/ApprovalReleaseHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalReleaseHash=${CUSTOM_RELEASE_CHECK}" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifeq (${REMOVE_RELEASE_CHECK},1)
	sed -i.orig -e '/ApprovalReleaseHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CUSTOM_BUILD_CHECK
	sed -i.orig -e '/ApprovalBuildName/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "ApprovalBuildName=${CUSTOM_BUILD_CHECK}" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifeq (${REMOVE_BUILD_CHECK},1)
	sed -i.orig -e '/ApprovalBuildName/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CUSTOM_UPDATE_SITE
	sed -i.orig -e '/SoftwareUpdateSite/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
	echo "SoftwareUpdateSite=${CUSTOM_UPDATE_SITE}" >> \
		build/${PATIENT}/resources/recoverytool.config
endif
ifeq (${REMOVE_UPDATE_SITE},1)
	sed -i.orig -e '/SoftwareUpdateSite/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CUSTOM_DEVICETYPE
	sed -i.orig -e 's/DeviceType=.*/DeviceType=${CUSTOM_DEVICETYPE}/' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifeq (${DISABLE_MODEM_UPDATE},1)
	sed -i.orig -e '/ModemUpdater/d' \
		build/${PATIENT}/webOS/installer.xml
	rm -f build/${PATIENT}/webOS/installer.xml.orig
endif
ifdef CUSTOM_DEVICETYPE
	sed -i.orig -e 's/target="[^"]*"/target="${CUSTOM_DEVICETYPE}"/' \
		    -e 's/bootfile="[^"]*"/bootfile="${BOOTLOADERNEW}.bin"/' \
		build/${PATIENT}/webOS/installer.xml
	rm -f build/${PATIENT}/webOS/installer.xml.orig
endif
ifdef CUSTOM_WEBOS_DMSET
	sed -i.orig -e 's/DMSet token="[^"]*"/DMSet token="${CUSTOM_WEBOS_DMSET}"/' \
		build/${PATIENT}/webOS/installer.xml
	rm -f build/${PATIENT}/webOS/installer.xml.orig
endif
ifndef REMOVE_CARRIER_CHECK
ifdef CUSTOM_CARRIER_DMSET
	sed -i.orig -e 's/DMSet token="[^"]*"/DMSet token="${CUSTOM_CARRIER_DMSET}"/' \
		build/${PATIENT}/carrier/installer.xml
	rm -f build/${PATIENT}/carrier/installer.xml.orig
endif
endif
ifdef EXT3FS_PARTITION_SIZE
	sed -i.orig \
	  -e 's|<Volume id="media"|<Volume id="ext3fs" type="ext3" size="${EXT3FS_PARTITION_SIZE}" mount="/media/ext3fs"/>\
<Volume id="media"|' \
	  -e 's|<Mount id="media"|<Mount id="ext3fs" options="noatime,data=writeback" freq="0" passno="0"/>\
<Mount id="media"|' \
		build/${PATIENT}/webOS/${CODENAMENEW}.xml
	rm -f build/${PATIENT}/webOS/${CODENAMENEW}.xml.orig
endif
ifdef CHANGE_KEYBOARD_TYPE
	sed -i.orig -e 's|<Section name="tokens" type="token" size=".*">|&\
<Val name="KEYoBRD" action="overwrite" value="${CHANGE_KEYBOARD_TYPE}"/>|' \
		build/${PATIENT}/webOS/${CODENAMENEW}.xml
	rm -f build/${PATIENT}/webOS/${CODENAMENEW}.xml.orig
endif
ifeq (${PATCH_DOCTOR},1)
	[ -d patches/doctor ]
	( cd build/${PATIENT} ; ../../${JAD} -b -ff -o -r -space -s java ${CLASSES:%=%.class} )
	for f in ${CLASSES:%=%.java} ; do \
	  [ -f build/${PATIENT}/$$f ] || exit ; \
	done
	( cd patches/doctor ; cat ${DOCTOR_PATCHES} ) | \
	( cd build/${PATIENT} ; patch -p0 --no-backup-if-mismatch )
endif
	touch $@

.PHONY: pack-%
pack-%:
	${MAKE} CARRIER=$* pack

.PHONY: pack
pack: build/${PATIENT}/.packed
	${ERR}

CODENAMEOLD = ${CODENAME}
INSTIMAGEOLD = nova-installer-image-${CODENAMEOLD}
CUSTIMAGEOLD = nova-cust-image-${CODENAMEOLD}
BOOTLOADEROLD = boot-${CODENAMEOLD}

ifdef CUSTOM_DEVICETYPE
CODENAMENEW = ${CUSTOM_DEVICETYPE}
else
CODENAMENEW = ${CODENAMEOLD}
endif

INSTIMAGENEW = nova-installer-image-${CODENAMENEW}
CUSTIMAGENEW = nova-cust-image-${CODENAMENEW}
BOOTLOADERNEW = boot-${CODENAMENEW}


build/${PATIENT}/.packed:
	${ERR}
	rm -f $@
ifeq (${PATCH_DOCTOR},1)
	( cd build/${PATIENT} ; javac -cp . ${CLASSES:%=%.java} )
endif
	( cd build/${PATIENT}/rootfs ; mkdir -p ${NEWDIRS} )
	rm -f build/${PATIENT}/ipkgs-file-list.txt
	for package in ${NEWIPKGS} ; do \
	  cat build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.list | \
		sed -e 's|^|.|' >> build/${PATIENT}/ipkgs-file-list.txt ; \
	done
	if [ -f build/${PATIENT}/rootfs/md5sums.gz ] ; then \
	  gzip -f build/${PATIENT}/rootfs/md5sums ; \
	fi
ifdef EXTRA_ROOTFS_IPKGS
	@echo
	@echo "You can safely ignore any 'Not found in archive' errors from the following ${TAR} command."
	@echo
endif
	- ${TAR} -C build/${PATIENT}/rootfs --wildcards \
		-f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar \
		--delete -T build/${PATIENT}/ipkgs-file-list.txt \
		./usr/lib/ipkg/info ${OLDDIRS} ./md5sums*
ifdef EXTRA_ROOTFS_IPKGS
	@echo
	@echo "You can safely ignore any 'Not found in archive' errors from the previous ${TAR} command."
	@echo
endif
	( cd build/${PATIENT}/rootfs ; \
		${TAR} -f ../webOS/${CUSTIMAGENEW}.rootfs.tar \
			--numeric-owner --owner=0 --group=0 \
			--append -T ../ipkgs-file-list.txt \
			./usr/lib/ipkg/info ${NEWDIRS} ./md5sums* )
	gzip -f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar
	( cd build/${PATIENT}/webOS ; \
		${TAR} -f ../resources/webOS.tar \
			--numeric-owner --owner=0 --group=0 -h \
			-c . )
	sed -i.orig -e '/^Name: /d' -e '/^SHA1-Digest: /d' -e '/^ /d' -e '/^\n$$/d' \
		build/${PATIENT}/META-INF/MANIFEST.MF
	( cd build/${PATIENT} ; \
		zip -q -d ${DOCTOR} META-INF/MANIFEST.MF META-INF/JARKEY.* ${CLASSES:%=%*.class} \
			resources/webOS.tar resources/recoverytool.config )
	( cd build/${PATIENT} ; \
		zip -q ${DOCTOR} META-INF/MANIFEST.MF ${CLASSES:%=%*.class} \
			resources/webOS.tar resources/recoverytool.config )
ifndef REMOVE_CARRIER_CHECK
	( cd build/${PATIENT}/carrier ; \
		${TAR} -f ../resources/${CARRIER_TARBALL} \
			--numeric-owner --owner=0 --group=0 -h \
			-c -T ../carrier-file-list.txt )
	( cd build/${PATIENT} ; \
		zip -q -d ${DOCTOR} resources/${CARRIER_TARBALL} )
	( cd build/${PATIENT} ; \
		zip -q ${DOCTOR} resources/${CARRIER_TARBALL} )
endif
	@echo
	@echo "Your custom doctor file has been created at build/${PATIENT}/${DOCTOR}"
	@echo
	touch $@

.PHONY: extract-ipkgs
extract-rootfs-ipkgs:
	[ -d build/${PATIENT}/rootfs/usr/lib/ipkg/info ]
	rm -f build/${PATIENT}/extras-file-list.txt
	for package in ${EXTRA_ROOTFS_IPKGS} ; do \
	  if [ -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.list ] ; then \
	    ( cd build/${PATIENT}/rootfs ; \
	      ls -1 ./usr/lib/ipkg/info/$$package.* >> ../extras-file-list.txt ) ; \
	    cat build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$package.list | \
		sed -e 's|^|.|' >> build/${PATIENT}/extras-file-list.txt ; \
	  fi ; \
	done
	mkdir -p build/${PATIENT}/extras
	if [ -f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar.gz ] ; then \
	  ${TAR} -C build/${PATIENT}/extras \
		-f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar.gz \
		-z -x -T build/${PATIENT}/extras-file-list.txt ; \
	else \
	  ${TAR} -C build/${PATIENT}/extras \
		-f build/${PATIENT}/webOS/${CUSTIMAGENEW}.rootfs.tar \
		-x -T build/${PATIENT}/extras-file-list.txt ; \
	fi
	${TAR} -C build/${PATIENT}/extras \
		-f ${EXTRA_ROOTFS_TARBALL} \
		-c .
	rm -rf build/${PATIENT}/extras
	rm -f build/${PATIENT}/extras-file-list.txt

.PHONY: devmode-%
devmode-%:
	${MAKE} CARRIER=$* devmode

.PHONY: devmode
devmode: mount
	novacom -w run file://bin/mount -- /dev/mapper/store-var /tmp/var -o remount,rw
	novacom -w run file://bin/mkdir -- -p /tmp/var/gadget
	novacom -w run file://bin/touch -- /tmp/var/gadget/novacom_enabled
	novacom -w run file://bin/mount -- /dev/mapper/store-var /tmp/var -o remount,ro

.PHONY: emigrate
emigrate: mount
	novacom -w run file://bin/mount -- ${BOOT_PARTITION} /tmp/boot -o remount,rw
	novacom -w run file://bin/mv -- /tmp/boot/uImage /tmp/boot/uImage.webOS
	novacom -w run file://bin/ln -- -s cm-uMulti /tmp/boot/uImage
	novacom -w run file://bin/mount -- ${BOOT_PARTITION} /tmp/boot -o remount,ro

.PHONY: immigrate
immigrate: mount
	novacom -w run file://bin/mount -- ${BOOT_PARTITION} /tmp/boot -o remount,rw
	novacom -w run file://bin/rm -- -f /tmp/boot/uImage
	novacom -w run file://bin/mv -- /tmp/boot/uImage.webOS /tmp/boot/uImage
	novacom -w run file://bin/mount -- ${BOOT_PARTITION} /tmp/boot -o remount,ro

.PHONY: backup-%
backup-%:
	${MAKE} CARRIER=$* backup

.PHONY: backup
backup: mount
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	mkdir -p clones/$$id ; \
	echo "Creating clones/$$id/tokens.txt" ; \
	novacom -w run file://sbin/tokens -- --list > clones/$$id/tokens.txt
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.nvram.bin" ; \
	( novacom -w run file://bin/dd -- if=/dev/${NVRAM_PARTITION} ) > \
	   clones/$$id/${CUSTIMAGEOLD}.nvram.bin
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.varfs.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/var/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.varfs.tar.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.rootfs.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/root/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.rootfs.tar.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.boot.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/boot/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.boot.tar.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.log.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/log/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.log.tar.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.update.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/update/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.update.tar.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.mojodb.enc" ; \
	( novacom -w run file://bin/dd -- if=/dev/mapper/store-mojodb ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.mojodb.enc.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.filecache.enc" ; \
	( novacom -w run file://bin/dd -- if=/dev/mapper/store-filecache ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.filecache.enc.gz
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	echo "Creating clones/$$id/${CUSTIMAGEOLD}.media.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/media/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/${CUSTIMAGEOLD}.media.tar.gz

.PHONY: mount
mount: unmount
	novacom -w run file://usr/sbin/lvm.static -- vgscan --ignorelockingfailure 2> /dev/null
	novacom -w run file://usr/sbin/lvm.static -- vgchange -ay --ignorelockingfailure 2> /dev/null
	@for f in var root log update media ; do \
	  echo "Mounting /dev/mapper/store-$$f" ; \
	  novacom -w run file://bin/mkdir -- -p /tmp/$$f ; \
	  novacom -w run file://bin/mount -- /dev/mapper/store-$$f /tmp/$$f -o ro ; \
	done
	@echo "Mounting /dev/${BOOT_PARTITION}"
	@novacom -w run file://bin/mkdir -- -p /tmp/boot
	@novacom -w run file://bin/mount -- /dev/${BOOT_PARTITION} /tmp/boot -o ro

.PHONY: unmount
unmount:
	@for f in var root log update media boot ; do \
	  echo "Unmounting /tmp/$$f" ; \
	  ( novacom -w run file://bin/umount -- /tmp/$$f 2> /dev/null || true ) ; \
	done

.PHONY: memload-%
memload-%:
	${MAKE} CARRIER=$* memload

.PHONY: memload
memload: build/${PATIENT}/.unpacked
	novacom -w boot mem:// < build/${PATIENT}/webOS/${INSTIMAGEOLD}.uImage
	@sleep 5

.PHONY: memboot-%
memboot-%:
	${MAKE} CARRIER=$* memboot

.PHONY: memboot
memboot: build/${PATIENT}/.unpacked
	novacom -w run file://sbin/tellbootie recover || true
	@sleep 5
	novacom -w boot mem:// < build/${PATIENT}/webOS/${INSTIMAGEOLD}.uImage
	@sleep 5

.PHONY: reboot
reboot:
	novacom -w run file://sbin/tellbootie || true
	@sleep 5

.PHONY: recover
recover:
	novacom -w run file://sbin/tellbootie recover || true
	@sleep 5

.PHONY: download-%
download-%:
	${MAKE} CARRIER=$* download

.PHONY: download
download: downloads/${DOCTOR}

downloads/${DOCTOR}:
	${ERR}
	mkdir -p downloads
	@ [ -f $@ ] || echo "Please download the correct version of the webOS Doctor .jar file" &&  echo "and then rename and move it to $@ (i.e. the downloads directory that was just created under the current directory)." && false
	touch $@

.PHONY: jad
jad: ${JAD}

build/tools/jad-macosx/jad: downloads/jad158g.mac.intel.zip
	mkdir -p build/tools/jad-macosx
	( cd build/tools/jad-macosx ; unzip ../../../$< jad )
	touch $@

downloads/jad158g.mac.intel.zip:
	mkdir -p downloads
	curl -L -o $@ http://www.varaneckas.com/sites/default/files/jad/jad158g.mac.intel.zip

build/tools/jad-linux/jad: downloads/jad158e.linux.static.zip
	mkdir -p build/tools/jad-linux
	( cd build/tools/jad-linux ; unzip ../../../$< jad )
	touch $@

downloads/jad158e.linux.static.zip:
	mkdir -p downloads
	curl -L -o $@ http://www.varaneckas.com/sites/default/files/jad/jad158e.linux.static.zip

${JODE}:
	mkdir -p downloads
	curl -L -o $@ http://sourceforge.net/projects/jode/files/jode/1.1.2-pre1/jode-1.1.2-pre1.jar/download

clobber:
	rm -rf build

clobber-%:
	make CARRIER=$* clobber-build

clobber-build:
	rm -rf build/${PATIENT}

reallyclobber: clobber
	rm -rf clones

.PHONY: err
err: ; $(ERR)
