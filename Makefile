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

# Uncomment the features that you wish to enable
# BYPASS_ACTIVATION     = 1
# ENABLE_FIRSTUSE_WIFI  = 1
# MAKE_FIRSTUSE_VISIBLE = 1
# INCREASE_VAR_SPACE    = 1
# ENABLE_DEVELOPER_MODE = 1
# ENABLE_USB_NETWORKING = 1
# DISABLE_UPLOAD_DAEMON = 1
# INSTALL_SSH_AUTH_KEYS = 1
# REMOVE_CARRIER_CHECK  = 1
# REMOVE_MODEL_CHECK    = 1
# DISABLE_MODEM_UPDATE  = 1
# CHANGE_KEYBOARD_TYPE  = z

# Select "pre", or "pixi".
DEVICE = pre

# Select "sprint", "bellmo", "telcel", "verizonwireless" or "wr".
CARRIER = undefined

# Latest supported version is:
# VERSION = 1.3.5.2

# Latest version, will be overridden below for carriers that are behind.
ifeq (${DEVICE},pre)
VERSION = 1.3.5.1
endif
ifeq (${DEVICE},pixi)
VERSION = 1.3.5.1
endif

ifeq (${CARRIER},wr)
VERSION = 1.3.5.2
endif

ifeq ($(shell uname -s),Darwin)
TAR	= gnutar
else
TAR	= tar
endif

ifeq (${DEVICE},pre)
CODENAME = castle
MODEL = p100eww
ifeq (${CARRIER},wr)
MODEL = p100ueu
endif
ifeq (${CARRIER},verizonwireless)
MODEL = p101eww
endif
endif

ifeq (${DEVICE},pixi)
CODENAME = pixie
MODEL = p120eww
ifeq (${CARRIER},verizonwireless)
MODEL = p121eww
endif
endif

DOCTOR  = webosdoctor${MODEL}${CARRIER}-${VERSION}.jar

ifeq (${CARRIER},wr)
DOCTOR  = webosdoctor${MODEL}-${CARRIER}-${VERSION}.jar
endif

PATIENT = ${DEVICE}-${MODEL}-${CARRIER}-${VERSION}

APPLICATIONS = com.palm.app.firstuse
PATCHES = com.palm.app.firstuse.patch

OLDDIRS = ./usr/palm/applications/com.palm.app.firstuse ./usr/lib/ipkg/info ./etc/event.d
NEWDIRS = ${OLDDIRS} ./var/luna/preferences ./var/gadget ./var/home/root

.PHONY: all
ifeq (${DEVICE},pre)
all: all-wr all-sprint all-bellmo all-telcel all-verizonwireless
endif
ifeq (${DEVICE},pixi)
all: all-sprint
endif

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
		zip -d ${DOCTOR} META-INF/MANIFEST.MF META-INF/JARKEY.* resources/webOS.tar resources/recoverytool.config )
	sed -i.orig -e '/^Name: /d' -e '/^SHA1-Digest: /d' -e '/^ /d' -e '/^\n$$/d' \
		build/${PATIENT}/META-INF/MANIFEST.MF
	( cd build/${PATIENT} ; \
		zip ${DOCTOR} META-INF/MANIFEST.MF resources/webOS.tar resources/recoverytool.config )
	touch $@

.PHONY: patch-%
patch-%:
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${PATIENT}/.patched

build/${PATIENT}/.patched:
	rm -f $@
	[ -d patches/${PATIENT} ]
	@for app in ${APPLICATIONS} ; do \
	  mv build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums build/${PATIENT}/rootfs/usr/lib/ipkg/info/$$app.md5sums.old ; \
	done
	mv build/${PATIENT}/rootfs/md5sums build/${PATIENT}/rootfs/md5sums.old
ifeq (${BYPASS_ACTIVATION},1)
	( cd patches/${PATIENT} ; cat bypass-activation.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
	mkdir -p build/${PATIENT}/rootfs/var/luna/preferences
	touch build/${PATIENT}/rootfs/var/luna/preferences/ran-first-use
endif
ifeq (${ENABLE_FIRSTUSE_WIFI},1)
	( cd patches/${PATIENT} ; cat enable-firstuse-wifi.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
endif
ifeq (${MAKE_FIRSTUSE_VISIBLE},1)
	( cd patches/${PATIENT} ; cat make-firstuse-visible.patch ) | \
	( cd build/${PATIENT}/rootfs ; patch -p0 )
endif
ifeq (${ENABLE_DEVELOPER_MODE},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/novacom_enabled
endif
ifeq (${ENABLE_USB_NETWORKING},1)
	mkdir -p build/${PATIENT}/rootfs/var/gadget
	touch build/${PATIENT}/rootfs/var/gadget/usbnet_enabled
endif
ifeq (${DISABLE_UPLOAD_DAEMON},1)
	# %%% Do stuff here %%%
endif
ifeq (${INSTALL_SSH_AUTH_KEYS},1)
	mkdir -p build/${PATIENT}/rootfs/var/home/root/.ssh
	cp ${HOME}/.ssh/authorized_keys build/${PATIENT}/rootfs/var/home/root/.ssh/authorized_keys
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
	sed -i.orig -e 's/ForceModemUpdate=true/ForceModemUpdate=false/' \
		build/${PATIENT}/resources/recoverytool.config
	rm -f build/${PATIENT}/resources/recoverytool.config.orig
endif
ifdef CHANGE_KEYBOARD_TYPE
	sed -i.orig -e 's|<Section name="tokens" type="token" size="4KB">|<Section name="tokens" type="token" size="4KB">\
<Val name="KEYoBRD" action="overwrite" value="${CHANGE_KEYBOARD_TYPE}"/>|' \
		build/${PATIENT}/webOS/${CODENAME}.xml
	rm -f build/${PATIENT}/webOS/${CODENAME}.xml.orig
endif
	touch $@

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
		unzip ${DOCTOR} META-INF/MANIFEST.MF resources/webOS.tar resources/recoverytool.config )
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

clobber:
	rm -rf build
