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
# runs on the first boot of the device.	 This allows users to use the
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
# user's home directory to the device.	The user can then connect to
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

# AUTO_INSTALL_PREWARE automatically queues the installation of
# Preware as soon as a network connection is available after first
# boot.  This feature also installs the preware.org x509 Certification
# Authority certificate, allowing packages signed by WebOS Internals
# to be installed via the appInstallService installHistory database.
# Uncomment the corresponding line below to enable this feature.

# DISABLE_UPLOAD_DAEMON disables a background process that
# automatically uploads usage information to Palm on a daily basis.
# It uploads debug information related to operating system or
# application crashes, users' GPS information, along with data on
# every application used, and for how long it was used.	 You may wish
# to disable this on privacy grounds, or if you do not have an
# unlimited data plan and will be paying exorbitant data charges.
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

# INCREASE_VAR_SPACE increases the size of the /var partition to 2 GB.
# This allows more space for the installation of Linux applications
# and the storage of huge amounts of email and attachments on the
# device.  The extra space is taken away from the USB drive.
# Uncomment the corresponding line below to enable this feature.

# ADD_EXT3FS_PARTITION adds a spare LVM partition formatted as ext3.
# This allows space for experimentation that requires an additional
# ext3 filesytem.  The extra space is taken away from the USB drive.
# Uncomment the corresponding line below to enable this feature.

# CHANGE_KEYBOARD_TYPE permanently changes the keyboard layout using
# the manufacturing software token area.  You only need to do this
# once.	 Future uses of the webOS Doctor without this feature enabled
# will not change the setting.	You can use this feature again in the
# future at any time to reverse this change.
# Uncomment the corresponding line below to enable this feature.
# ('z' means QWERTY, 'y' & 'y1' mean QWERTZ, 'w1' means AZERTY).

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
# AUTO_INSTALL_PREWARE  = 1
# ENABLE_TESTING_FEEDS  = 1
# INSTALL_SSH_AUTH_KEYS = 1
# INSTALL_WIFI_PROFILES = 1
# DISABLE_UPLOAD_DAEMON = 1
# DISABLE_MODEM_UPDATE  = 1
# ENABLE_USB_NETWORKING = 1
# REMOVE_CARRIER_CHECK  = 1
# REMOVE_MODEL_CHECK    = 1
# INCREASE_VAR_SPACE    = 1
# CHANGE_KEYBOARD_TYPE  = z
# ADD_EXT3FS_PARTITION  = 2GB

# Select "pre", "preplus", "pixi" or "pixiplus".
DEVICE = undefined

# Select "wr", "sprint", "verizonwireless", "bellmo", "telcel" or "att".
CARRIER = undefined

######################################
## END OF AREA FOR END USER CHANGES ##
######################################

###################################
## START OF AREA FOR MY USE ONLY ##
###################################

ifeq (${LOGNAME},rwhitby)
# DEVICE = pre
# CARRIER = wr
BYPASS_ACTIVATION     = 1
BYPASS_FIRST_USE_APP  = 1
ENABLE_DEVELOPER_MODE = 1
AUTO_INSTALL_PREWARE  = 1
ENABLE_TESTING_FEEDS  = 1
INSTALL_SSH_AUTH_KEYS = 1
INSTALL_WIFI_PROFILES = 1
DISABLE_UPLOAD_DAEMON = 1
DISABLE_MODEM_UPDATE  = 1
# REMOVE_CARRIER_CHECK  = 1
# REMOVE_MODEL_CHECK    = 1
# INCREASE_VAR_SPACE    = 1
# ADD_EXT3FS_PARTITION  = 2GB
# CUSTOM_ROOT_PARTITION = 1
# CUSTOM_VAR_PARTITION  = 1
# CLONE = 55caa500
# CHANGE_KEYBOARD_TYPE  = z
# CUSTOM_WEBOS_TARBALL = webOS.tar
endif

#################################
## END OF AREA FOR MY USE ONLY ##
#################################

##############################################################################
## DO NOT MODIFY ANYTHING PAST THIS POINT, UNLESS YOU ARE A MAKEFILE EXPERT ##
##############################################################################

# Latest supported version is:
# VERSION = 1.4.5

ifeq (${DEVICE},pre)
CODENAME = castle
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
endif
endif

ifeq (${DEVICE},preplus)
CODENAME = castle
ifeq (${CARRIER},wr)
MODEL = p101ueu
VERSION = 1.4.5
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p101eww
VERSION = 1.4.1.1
endif
ifeq (${CARRIER},att)
MODEL = p101eww
VERSION = 1.4.2
endif
endif

ifeq (${DEVICE},pixi)
CODENAME = pixie
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
ifeq (${CARRIER},wr)
MODEL = p121ewweu
VERSION = 1.4.5
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p121eww
VERSION = 1.4.1.1
endif
ifeq (${CARRIER},att)
MODEL = p121eww
VERSION = 1.4.3
endif
endif

DOCTOR	= webosdoctor${MODEL}${CARRIER}-${VERSION}.jar

ifeq (${CARRIER},wr)
DOCTOR	= webosdoctor${MODEL}-${CARRIER}-${VERSION}.jar
endif

PATIENT = ${DEVICE}-${MODEL}-${CARRIER}-${VERSION}

APPLICATIONS = com.palm.app.firstuse

ifeq (${CUSTOM_VAR_PARTITION},1)
CLASSES = com/palm/nova/installer/core/TrenchcoatModel
DOCTOR_PATCHES = trenchcoat-model-fixup.patch trenchcoat-model-extra-data.patch
endif

OLDDIRS = ./usr/palm/applications/com.palm.app.firstuse ./usr/lib/ipkg/info ./etc/event.d ./etc/ssl
NEWDIRS = ${OLDDIRS} ./var/luna/preferences ./var/gadget ./var/home/root ./var/preferences ./var/palm/data

ifeq ($(shell uname -s),Darwin)
TAR	= gnutar
ifeq (${CUSTOM_VAR_PARTITION},1)
JAD	= build/tools/jad-macosx/jad
endif
else
TAR	= tar
ifeq (${CUSTOM_VAR_PARTITION},1)
JAD	= build/tools/jad-linux/jad
endif
endif
JODE= downloads/jode-1.1.2-pre1.jar

.PHONY: all
all:
ifneq (${DEVICE},undefined)
ifneq (${CARRIER},undefined)
	@if [ "${MODEL}" == "" ] || [ "${VERSION}" == "" ] ; then \
	  echo You have specified an invalid DEVICE and CARRIER combination ; false ; \
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
	${MAKE} CARRIER=$* unpack patch pack

.PHONY: pack-%
pack-%:
	${MAKE} CARRIER=$* pack

.PHONY: pack
pack: build/${PATIENT}/.packed

NOVATGZ = ./nova-cust-image-${CODENAME}.rootfs.tar.gz

ifeq (${CUSTOM_VAR_PARTITION},1)
USERTGZ = ./nova-cust-image-${CODENAME}.varfs.tar.gz
endif

build/${PATIENT}/.packed:
	rm -f $@
ifneq (${CUSTOM_ROOT_PARTITION},1)
	- ${TAR} -C build/${PATIENT}/rootfs --wildcards \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		--delete ${OLDDIRS} ./md5sums*
	( cd build/${PATIENT}/rootfs ; mkdir -p ${NEWDIRS} )
	if [ -f build/${PATIENT}/rootfs/md5sums.gz ] ; then \
	  gzip -f build/${PATIENT}/rootfs/md5sums ; \
	  ${TAR} -C build/${PATIENT}/rootfs \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		--numeric-owner --owner=0 --group=0 \
		--append ${NEWDIRS} ./md5sums.gz ; \
	else \
	  ${TAR} -C build/${PATIENT}/rootfs \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		--numeric-owner --owner=0 --group=0 \
		--append ${NEWDIRS} ./md5sums ; \
	fi
	gzip -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar
endif
	- ${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		--delete ${NOVATGZ} ./${CODENAME}.xml ./installer.xml
	${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		--numeric-owner --owner=0 --group=0 -h \
		--append ${NOVATGZ} ${USERTGZ} ./${CODENAME}.xml ./installer.xml
	( cd build/${PATIENT} ; \
		zip -q -d ${DOCTOR} META-INF/MANIFEST.MF META-INF/JARKEY.* ${CLASSES:%=%*.class} resources/webOS.tar resources/recoverytool.config )
	sed -i.orig -e '/^Name: /d' -e '/^SHA1-Digest: /d' -e '/^ /d' -e '/^\n$$/d' \
		build/${PATIENT}/META-INF/MANIFEST.MF
	( cd build/${PATIENT} ; \
		zip -q ${DOCTOR} META-INF/MANIFEST.MF ${CLASSES:%=%*.class} resources/webOS.tar resources/recoverytool.config )
	touch $@

.PHONY: patch-%
patch-%:
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${PATIENT}/.patched

build/${PATIENT}/.patched: ${JAD}
	rm -f $@
	[ -d patches/webos-${VERSION} ]
	@for app in ${APPLICATIONS} ; do \
	  mv build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.old ; \
	done
	if [ -f build/${PATIENT}/rootfs/md5sums.gz ] ; then \
	  gunzip -c < build/${PATIENT}/rootfs/md5sums.gz > build/${PATIENT}/rootfs/md5sums ; \
	fi
	mv build/${PATIENT}/rootfs/md5sums build/${PATIENT}/rootfs/md5sums.old
ifeq (${BYPASS_ACTIVATION},1)
	( cd patches/webos-${VERSION} ; cat bypass-activation.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
endif
ifeq (${BYPASS_FIRST_USE_APP},1)
	mkdir -p build/${PATIENT}/rootfs/var/luna/preferences
	touch build/${PATIENT}/rootfs/var/luna/preferences/ran-first-use
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
ifeq (${AUTO_INSTALL_PREWARE},1)
	mv build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums \
	   build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.old
	cat scripts/preware-ca-bundle.crt >> build/${PATIENT}/rootfs/etc/ssl/certs/appsigning-bundle.crt
	( cd build/${PATIENT}/rootfs ; md5sum ./etc/ssl/certs/appsigning-bundle.crt ) > \
	  build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.new
	./scripts/replace-md5sums.py \
	  build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.old \
	  build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.new \
	      > build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums
	  rm -f build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.old \
		build/${PATIENT}/rootfs/usr/lib/ipkg/info/pmcertstore.md5sums.new
	mkdir -p build/${PATIENT}/rootfs/var/palm/data/com.palm.appInstallService/
	cp scripts/preware-install.db \
	  build/${PATIENT}/rootfs/var/palm/data/com.palm.appInstallService/installHistory.db
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
ifdef ADD_EXT3FS_PARTITION
	sed -i.orig \
	  -e 's|<Volume id="media"|<Volume id="ext3fs" type="ext3" size="${ADD_EXT3FS_PARTITION}" mount="/media/ext3fs"/>\
<Volume id="media"|' \
	  -e 's|<Mount id="media"|<Mount id="ext3fs" options="noatime,data=writeback" freq="0" passno="0"/>\
<Mount id="media"|' \
		build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
endif
ifdef CHANGE_KEYBOARD_TYPE
	sed -i.orig -e 's|<Section name="tokens" type="token" size="4KB">|<Section name="tokens" type="token" size="4KB">\
<Val name="KEYoBRD" action="overwrite" value="${CHANGE_KEYBOARD_TYPE}"/>|' \
		build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
endif
ifeq (${CUSTOM_ROOT_PARTITION},1)
	rm -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar.gz
	ln -s ../../../clones/${CLONE}/nova-cust-image-${CODENAME}.rootfs.tar.gz build/${PATIENT}/webOS/
endif
ifeq (${CUSTOM_VAR_PARTITION},1)
	sed -i.orig -e 's|<File file="$${NOVATGZ}" target="/"/>|<File file="$${NOVATGZ}" target="/"/>\
<File file="$${USERTGZ}" target="/var"/>|' \
		build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
	rm -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.varfs.tar.gz
	ln -s ../../../clones/${CLONE}/nova-cust-image-${CODENAME}.varfs.tar.gz build/${PATIENT}/webOS/
endif
ifeq (${CUSTOM_VAR_PARTITION},1)
	[ -d patches/doctor ]
	( cd build/${PATIENT} ; ../../${JAD} -b -ff -o -r -space -s java ${CLASSES:%=%.class} )
	for f in ${CLASSES:%=%.java} ; do \
	  [ -f build/${PATIENT}/$$f ] || exit ; \
	done
	( cd patches/doctor ; cat ${DOCTOR_PATCHES} ) | \
	( cd build/${PATIENT} ; patch -p0 )
	( cd build/${PATIENT} ; javac -cp . ${CLASSES:%=%.java} )
endif
	touch $@

.PHONY: backup-%
backup-%:
	${MAKE} CARRIER=$* backup

.PHONY: backup
backup: mount
	@export id="`novacom -w run file://bin/cat -- /proc/nduid | cut -c 1-8`" ; \
	mkdir -p clones/$$id ; \
	echo "Creating clones/$$id/nova-cust-image-${CODENAME}.varfs.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/var/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/nova-cust-image-${CODENAME}.varfs.tar.gz ; \
	echo "Creating clones/$$id/nova-cust-image-${CODENAME}.rootfs.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/root/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/nova-cust-image-${CODENAME}.rootfs.tar.gz ; \
	echo "Creating clones/$$id/nova-cust-image-${CODENAME}.media.tar.gz" ; \
	( novacom -w run file://bin/tar -- -C /tmp/media/ --totals -cf - . ) | \
	  gzip -c > clones/$$id/nova-cust-image-${CODENAME}.media.tar.gz ; \

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

.PHONY: memload-%
memload-%:
	${MAKE} CARRIER=$* memload

.PHONY: memload
memload: build/${PATIENT}/.unpacked
	novacom -w boot mem:// < build/${PATIENT}/webOS/nova-installer-image-${CODENAME}.uImage
	@sleep 5

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

.PHONY: recover
recover:
	novacom -w run file://sbin/tellbootie recover || true
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
ifdef CUSTOM_WEBOS_TARBALL
	cp ${CUSTOM_WEBOS_TARBALL} build/${PATIENT}/resources/webOS.tar
endif
	mkdir -p build/${PATIENT}/webOS
	${TAR} -C build/${PATIENT}/webOS \
		-f build/${PATIENT}/resources/webOS.tar \
		-x ./nova-cust-image-${CODENAME}.rootfs.tar.gz \
		./nova-installer-image-${CODENAME}.uImage ./${CODENAME}.xml ./installer.xml
	gunzip -f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar.gz
	mkdir -p build/${PATIENT}/rootfs
	${TAR} -C build/${PATIENT}/rootfs --wildcards \
		-f build/${PATIENT}/webOS/nova-cust-image-${CODENAME}.rootfs.tar \
		-x ${OLDDIRS} ./md5sums* ./etc/palm-build-info
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
