# Makefile for webOS Doctor modifications
#
# Copyright (C) 2009 by Rod Whitby <rod@whitby.id.au>
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
# runs on the first boot of the device.  This allows users to use the
# device even if they do not have access to cellular connectivity or
# would prefer not to go through the activation process.  Only use this
# if you are never going to use cellular connectivity on this device.
# Bypassing activation may prevent you from creating a Palm profile.
# This is not a method to use a device on a different cellular carrier.
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

# ENABLE_TESTING_FEEDS installs a flag file which tells Preware to
# automatically install testing feeds for all WebOS Internals
# packages.  You must, of course, install Preware as well to use them.
# Uncomment the corresponding line below to enable this feature.

# INSTALL_SSH_AUTH_KEYS imports the SSH authorized_keys file from the
# user's home directory to the device.  The user can then connect to
# the device from their computer as soon as an SSH daemon is
# installed.  You must already have a valid openssh authorized_keys
# file in ~/.ssh/authorized_keys before enabling this feature, or it
# will cause a fatal error.  You then need to install the OpenSSH SFTP
# Server application in Preware to actually access the device using
# the openssh private key that matches the openssh public key listed
# in your authorized_keys file.
# Uncomment the corresponding line below to enable this feature.

# INSTALL_WIFI_PROFILES imports a wifi preferences database file from
# the user's home directory to the device.  The device will then be
# set up to use wifi immediately after the webOS Doctor has completed.
# You must already have copied a correctly configured prefsDB.sl file
# from the /var/preferences/com.palm.wifi/ directory on the device to
# ~/.ssh/com.palm.wifi.prefsDB.sl on your host machine before enabling
# this feature, or it will cause a fatal error.
# Uncomment the corresponding line below to enable this feature.

# DISABLE_UPLOAD_DAEMON disables a background process that
# automatically uploads usage information to Palm on a daily basis.
# It uploads debug information related to operating system or
# application crashes, users' GPS information, along with data on
# every application used, and for how long it was used.  You may wish
# to disable this on privacy grounds, or if you do not have an
# unlimited data plan and will be paying exorbitant data charges.
# Uncomment the corresponding line below to enable this feature.

# DISABLE_MODEM_UPDATE prevents the device from reflashing the modem
# software.  This saves some time during the webOS Doctor process.
# Uncomment the corresponding line below to enable this feature.

# INCREASE_VAR_SPACE increases the size of the /var partition to 2 GB.
# This allows more space for the installation of Linux applications
# and the storage of huge amounts of email and attachments on the
# device.  The extra space is taken away from the USB drive.
# Uncomment the corresponding line below to enable this feature.

# ENABLE_USB_NETWORKING activates USB networking functionality.  The
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
# once.  Future uses of the webOS Doctor without this feature enabled
# will not change the setting.  You can use this feature again in the
# future at any time to reverse this change.
# Uncomment the corresponding line below to enable this feature.
# ('z' means QWERTY, 'y' means QWERTZ, 'w1' means AZERTY).

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
# ENABLE_TESTING_FEEDS  = 1
# INSTALL_SSH_AUTH_KEYS = 1
# INSTALL_WIFI_PROFILES = 1
# DISABLE_UPLOAD_DAEMON = 1
# DISABLE_MODEM_UPDATE  = 1
# INCREASE_VAR_SPACE    = 1
# ENABLE_USB_NETWORKING = 1
# REMOVE_CARRIER_CHECK  = 1
# REMOVE_MODEL_CHECK    = 1
# CHANGE_KEYBOARD_TYPE  = z

# Select "pre", or "pixi".
DEVICE = pre

# Select "sprint", "bellmo", "telcel", "verizonwireless", "sfr", "wr" or "att".
CARRIER = wr

######################################
## END OF AREA FOR END USER CHANGES ##
######################################

###################################
## START OF AREA FOR MY USE ONLY ##
###################################

ifeq (${LOGNAME},rwhitby)
BYPASS_ACTIVATION     = 1
BYPASS_FIRST_USE_APP  = 1
ENABLE_DEVELOPER_MODE = 1
ENABLE_TESTING_FEEDS  = 1
INSTALL_SSH_AUTH_KEYS = 1
INSTALL_WIFI_PROFILES = 1
DISABLE_UPLOAD_DAEMON = 1
endif

#################################
## END OF AREA FOR MY USE ONLY ##
#################################

##############################################################################
## DO NOT MODIFY ANYTHING PAST THIS POINT, UNLESS YOU ARE A MAKEFILE EXPERT ##
##############################################################################

# Latest supported version is:
# VERSION = 1.4.5

# Latest version, will be overridden below for carriers that are ahead or behind.
VERSION = 1.4.1.1

ifeq ($(shell uname -s),Darwin)
TAR	= gnutar
else
TAR	= tar
endif
JODE= downloads/jode-1.1.2-pre1.jar

ifeq (${DEVICE},pre)
CODENAME = castle
MODEL = p100eww
ifeq (${CARRIER},wr)
MODEL = p100ueu
VERSION=1.4.1
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p101eww
endif
ifeq (${CARRIER},bellmo)
VERSION=1.4.1
endif
ifeq (${CARRIER},telcel)
VERSION=1.4.0
endif
ifeq (${CARRIER},sfr)
MODEL = p101ueu
VERSION=1.4.1
endif
ifeq (${CARRIER},att)
MODEL = p101eww
VERSION=1.4.2
endif
endif

ifeq (${DEVICE},pixi)
CODENAME = pixie
ifeq (${VERSION},1.3.5.1)
MODEL = p120eww
else
MODEL = p200eww
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p121eww
endif
ifeq (${CARRIER},sfr)
MODEL = p121ueu
VERSION=1.4.1
endif
ifeq (${CARRIER},wr)
MODEL = p121eww
VERSION=1.4.1
endif
endif

DOCTOR  = webosdoctor${MODEL}${CARRIER}-${VERSION}.jar

ifeq (${CARRIER},wr)
DOCTOR  = webosdoctor${MODEL}-${CARRIER}-${VERSION}.jar
endif

ifeq (${CARRIER},sfr)
DOCTOR  = webosdoctor${MODEL}-wr-${VERSION}.jar
endif

PATIENT = ${DEVICE}-${MODEL}-${CARRIER}-${VERSION}

APPLICATIONS = com.palm.app.firstuse
PATCHES = com.palm.app.firstuse.patch
CLASSES = com/palm/nova/installer/core/FlasherThread \
	  com/palm/nova/installer/core/stages/AppFolderDeletionStage \
	  com/palm/nova/installer/core/stages/BypassFirstUseStage \
	  com/palm/nova/installer/core/stages/CustomizationStage \
	  com/palm/nova/installer/core/stages/EnableNovacomUsbByDefaultStage \
	  com/palm/nova/installer/core/stages/ModemUpdateStage \
	  com/palm/nova/installer/core/stages/TouchPanelUpdateStage \
	  com/palm/nova/installer/core/stages/TrenchcoatStage \
	  com/palm/nova/installer/core/stages/VerifyRomStage

OLDDIRS = ./usr/palm/applications/com.palm.app.firstuse ./usr/lib/ipkg/info ./etc/event.d
NEWDIRS = ${OLDDIRS} ./var/luna/preferences ./var/gadget ./var/home/root ./var/preferences

.PHONY: all
all:
	${MAKE} DEVICE=pre all-wr all-att all-sprint all-bellmo all-telcel all-verizonwireless all-sfr
	${MAKE} DEVICE=pixi all-wr all-sprint all-verizonwireless all-sfr

.PHONY: all-%
all-%:
	${MAKE} CARRIER=$* unpack patch pack

.PHONY: pack
pack: build/${PATIENT}/.packed

build/${PATIENT}/.packed:
	rm -f $@
	- ${TAR} -C build/${PATIENT}/rootfs \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		--delete ${OLDDIRS} ./md5sums
	( cd build/${PATIENT}/rootfs ; mkdir -p ${NEWDIRS} )
	${TAR} -C build/${PATIENT}/rootfs \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		--numeric-owner --owner=0 --group=0 \
		-r ${NEWDIRS} ./md5sums
	gzip -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar
	- ${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		--delete ./nova-cust-image-${CODENAME}.rootfs.tar.gz ./${CODENAME}.xml ./installer.xml
	${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		--numeric-owner --owner=0 --group=0 \
		-r ./nova-cust-image-${CODENAME}.rootfs.tar.gz ./${CODENAME}.xml ./installer.xml
	( cd build/${PATIENT} ; \
		zip -q -d ${DOCTOR} META-INF/MANIFEST.MF META-INF/JARKEY.* resources/webOS.tar resources/recoverytool.config )
	sed -i.orig -e '/^Name: /d' -e '/^SHA1-Digest: /d' -e '/^ /d' -e '/^\n$$/d' \
		build/${PATIENT}/META-INF/MANIFEST.MF
	( cd build/${PATIENT} ; \
		zip -q ${DOCTOR} META-INF/MANIFEST.MF resources/webOS.tar resources/recoverytool.config )
	touch $@

.PHONY: patch-%
patch-%:
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${PATIENT}/.patched

build/${PATIENT}/.patched:
	rm -f $@
	[ -d patches/webos-${VERSION} ]
	@for app in ${APPLICATIONS} ; do \
	  mv build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.old ; \
	done
	mv build/${PATIENT}/rootfs/md5sums build/${PATIENT}/rootfs/md5sums.old
ifeq (${BYPASS_ACTIVATION},1)
	( cd patches/webos-${VERSION} ; cat bypass-activation.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
endif
ifeq (${BYPASS_FIRST_USE_APP},1)
	mkdir -p build/${PATIENT}/rootfs/var/luna/preferences
	touch build/${PATIENT}/rootfs/var/luna/preferences/ran-first-use
	( cd patches/webos-${VERSION} ; cat make-firstuse-visible.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
endif
ifeq (${ENABLE_DEVELOPER_MODE},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/novacom_enabled
endif
ifeq (${ENABLE_TESTING_FEEDS},1)
	mkdir -p build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware
	touch build/${PATIENT}/rootfs/var/preferences/org.webosinternals.preware/enable-testing-feeds
endif
ifeq (${ENABLE_USB_NETWORKING},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/usbnet_enabled
endif
ifeq (${DISABLE_UPLOAD_DAEMON},1)
	rm -f build/${PATIENT}/rootfs/etc/event.d/uploadd
	sed -i.orig -e '/\/etc\/event.d\/uploadd/d' \
		build/${PATIENT}/rootfs/usr/lib/ipkg/info/uploadd.md5sums
	rm -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/uploadd.md5sums.orig
	sed -i.orig -e '/\/etc\/event.d\/uploadd/d' \
		build/${PATIENT}/rootfs/usr/lib/ipkg/info/uploadd.list
	rm -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/uploadd.list.orig
	sed -i.orig -e '/\/etc\/event.d\/uploadd/d' \
		build/${PATIENT}/rootfs/md5sums.old
	rm -f build/${PATIENT}/rootfs/md5sums.old.orig
endif
ifeq (${INSTALL_SSH_AUTH_KEYS},1)
	mkdir -p build/${PATIENT}/rootfs/var/home/root/.ssh
	cp ${HOME}/.ssh/authorized_keys build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys
endif
ifeq (${INSTALL_WIFI_PROFILES},1)
	mkdir -p build/${PATIENT}/rootfs/var/preferences/com.palm.wifi
	cp ${HOME}/.ssh/com.palm.wifi.prefsDB.sl build/${PATIENT}/rootfs/var/preferences/com.palm.wifi/prefsDB.sl
endif
	for app in ${APPLICATIONS} ; do \
	  ( cd build/${PATIENT}/rootfs ; \
	    find ./usr/palm/applications/$$app -type f | xargs md5sum ) \
	      > build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.new ; \
	  ./scripts/replace-md5sums.py \
	    build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.old build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.new \
	      > build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums ; \
	  rm -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.old build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.new ; \
	done
	( cd build/${PATIENT}/rootfs ; \
	  find ${OLDDIRS} -type f | xargs md5sum ) \
	    > build/${PATIENT}/rootfs/md5sums.new
	./scripts/replace-md5sums.py build/${PATIENT}/rootfs/md5sums.old build/${PATIENT}/rootfs/md5sums.new > \
				     build/${PATIENT}/rootfs/md5sums
	rm -f build/${PATIENT}/rootfs/md5sums.old build/${PATIENT}/rootfs/md5sums.new
ifeq (${INCREASE_VAR_SPACE},1)
	sed -i.orig -e '/<Volume id="var"/s|256MB|2048MB|' build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
endif
ifeq (${REMOVE_CARRIER_CHECK},1)
	sed -i.orig -e '/ApprovalCharlieHash/d' -e '/CustomizationBuild/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifeq (${REMOVE_MODEL_CHECK},1)
	sed -i.orig -e '/ApprovalMikeHash/d' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifeq (${DISABLE_MODEM_UPDATE},1)
	sed -i.orig -e '/ModemUpdater/d' \
		build/${PATIENT}/webOS/installer.xml
	rm -f build/${PATIENT}/webOS/installer.xml.orig
endif
ifdef CHANGE_KEYBOARD_TYPE
	sed -i.orig -e 's|<Section name="tokens" type="token" size="4KB">|<Section name="tokens" type="token" size="4KB">\
<Val name="KEYoBRD" action="overwrite" value="${CHANGE_KEYBOARD_TYPE}"/>|' \
		build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
endif
	touch $@

.PHONY: compile-%
compile-%:
	${MAKE} CARRIER=$* compile

.PHONY: compile
compile: build/${PATIENT}/.compiled

build/${PATIENT}/.compiled: build/${PATIENT}/.decompiled
	rm -f $@
	( cd build/${PATIENT} ; javac -cp . ${CLASSES:%=%.java} )
	touch $@

.PHONY: decompile-%
decompile-%:
	${MAKE} CARRIER=$* decompile

.PHONY: decompile
decompile: build/${PATIENT}/.decompiled

build/${PATIENT}/.decompiled: build/${PATIENT}/.unpacked ${JODE}
	rm -f $@
	( cd build/${PATIENT} ; java -cp ../../${JODE} jode.decompiler.Main -c . -d . `echo ${CLASSES} | tr '/' '.'` )
	for f in ${CLASSES:%=%.java} ; do \
	  [ -f build/${PATIENT}/$$f ] || exit ; \
	done
	touch $@

.PHONY: backup
backup: mount
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	mkdir -p clones/$$id ; \
	for f in var root media ; do \
	  echo "Creating clones/$$id/store-$$f.tar.gz" ; \
	  ( novacom -w run file://bin/tar -- -C /tmp/$$f/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/store-$$f.tar.gz ; \
	done

.PHONY: mount
mount: unmount
	novacom -w run file://usr/sbin/lvm.static -- vgscan --ignorelockingfailure 2> /dev/null
	novacom -w run file://usr/sbin/lvm.static -- vgchange -ay --ignorelockingfailure 2> /dev/null
	@for f in var root media ; do \
	  echo "Mounting /dev/mapper/store-$$f" ; \
	  novacom -w run file://bin/mkdir -- -p /tmp/$$f ; \
	  novacom -w run file://bin/mount -- /dev/mapper/store-$$f /tmp/$$f -o ro ; \
	done

.PHONY: unmount
unmount:
	@for f in var root media ; do \
	  echo "Unmounting /dev/mapper/store-$$f" ; \
	  ( novacom -w run file://bin/umount -- /tmp/$$f 2> /dev/null || true ) ; \
	done

.PHONY: memboot-%
memboot-%:
	${MAKE} CARRIER=$* memboot

.PHONY: memboot
memboot: build/${PATIENT}/.unpacked
	novacom -w run file://sbin/tellbootie recover || true
	@sleep 5
	novacom -w boot mem:// < build/${PATIENT}/webOS/nova-installer-image-${CODENAME}.uImage
	@sleep 5

.PHONY: reboot
reboot:
	novacom -w run file://sbin/tellbootie || true
	@sleep 5

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
		unzip -q ${DOCTOR} META-INF/MANIFEST.MF com/* resources/webOS.tar resources/recoverytool.config )
	mkdir -p build/${PATIENT}/webOS
	${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		-x ./nova-cust-image-${CODENAME}.rootfs.tar.gz \
		./nova-installer-image-${CODENAME}.uImage ./${CODENAME}.xml ./installer.xml
	gunzip -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar.gz
	mkdir -p build/${PATIENT}/rootfs
	${TAR} -C build/${PATIENT}/rootfs \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		-x ${OLDDIRS} ./md5sums
	touch $@

.PHONY: download-%
download-%:
	${MAKE} CARRIER=$* download

.PHONY: download
download: downloads/${DOCTOR}

downloads/${DOCTOR}:
	mkdir -p downloads
	@ [ -f $@ ] || echo "Please download the correct version of the webOS Doctor .jar file" &&  echo "and then move it to $@ (i.e. the downloads directory that was just created under the current directory)." && false
	touch $@

${JODE}:
	mkdir -p downloads
	curl -L -o $@ http://sourceforge.net/projects/jode/files/jode/1.1.2-pre1/jode-1.1.2-pre1.jar/download

clobber:
	rm -rf build clones
