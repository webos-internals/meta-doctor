# Makefile for Activation Bypass modifications
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

DEVICE  = pre
MODEL   = p100eww
CARRIER = sprint
VERSION = 1.1.0

TAR = tar

ifeq (${DEVICE},pre)
CODENAME = castle
endif

DOCTOR  = webosdoctor${MODEL}${CARRIER}-${VERSION}.jar
PATIENT = ${DEVICE}-${MODEL}-${CARRIER}-${VERSION}

APPLICATIONS = com.palm.app.firstuse
PATCHES = com.palm.app.firstuse.patch

OLDDIRS = ./usr/palm/applications/com.palm.app.firstuse ./usr/lib/ipkg/info
NEWDIRS = ${OLDDIRS} ./var/luna/preferences ./var/gadget

all: pack-bellmo pack-sprint

.PHONY: pack-%
pack-%:
	${MAKE} CARRIER=$* pack

.PHONY: pack
pack: build/${PATIENT}/.packed

build/${PATIENT}/.packed: build/${PATIENT}/.patched
	rm -f $@
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/nova-cust-image-castle.rootfs.tar \
		--delete ${OLDDIRS} ./md5sums
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/nova-cust-image-castle.rootfs.tar \
		-r ${NEWDIRS} ./md5sums
	gzip -f build/${PATIENT}/nova-cust-image-castle.rootfs.tar
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/resources/webOS.tar \
		--delete ./nova-cust-image-castle.rootfs.tar.gz
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/resources/webOS.tar \
		-r ./nova-cust-image-castle.rootfs.tar.gz
	( cd build/${PATIENT} ; \
		zip -d ${DOCTOR} META-INF/MANIFEST.MF META-INF/JARKEY.* resources/webOS.tar )
	sed -i.orig -e '/^Name: /d' -e '/^SHA1-Digest: /d' -e '/^ /d' -e '/^\n$$/d' \
		build/${PATIENT}/META-INF/MANIFEST.MF
	( cd build/${PATIENT} ; \
		zip ${DOCTOR} META-INF/MANIFEST.MF resources/webOS.tar )
	touch $@

.PHONY: patch-%
patch-%:
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${PATIENT}/.patched

build/${PATIENT}/.patched: build/${PATIENT}/.unpacked
	rm -f $@
	( cd patches/${PATIENT} ; cat ${PATCHES} ) | \
	( cd build/${PATIENT} ; patch -p0 )
	mkdir -p build/${PATIENT}/var/luna/preferences
	touch build/${PATIENT}/var/luna/preferences/ran-first-use
	mkdir -p build/${PATIENT}/var/gadget
	touch build/${PATIENT}/var/gadget/novacom_enabled
	( cd build/${PATIENT} ; \
	  find ./usr/palm/applications/com.palm.app.firstuse -type f | xargs md5sum ) \
	    > build/${PATIENT}/usr/lib/ipkg/info/com.palm.app.firstuse.md5sums.new
	./scripts/replace-md5sums.py \
	  build/${PATIENT}/usr/lib/ipkg/info/com.palm.app.firstuse.md5sums{.old,.new} \
	    > build/${PATIENT}/usr/lib/ipkg/info/com.palm.app.firstuse.md5sums
	rm -f build/${PATIENT}/usr/lib/ipkg/info/com.palm.app.firstuse.md5sums{.old,.new}
	( cd build/${PATIENT} ; \
	  find ${OLDDIRS} -type f | xargs md5sum ) \
	    > build/${PATIENT}/md5sums.new
	./scripts/replace-md5sums.py build/${PATIENT}/md5sums{.old,.new} > \
				     build/${PATIENT}/md5sums
	rm -f build/${PATIENT}/md5sums{.old,.new}
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
		unzip ${DOCTOR} META-INF/MANIFEST.MF resources/webOS.tar )
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/resources/webOS.tar \
		-x ./nova-cust-image-castle.rootfs.tar.gz
	gunzip -f build/${PATIENT}/nova-cust-image-castle.rootfs.tar.gz
	${TAR} -C build/${PATIENT} \
		-f build/${PATIENT}/nova-cust-image-castle.rootfs.tar \
		-x ${OLDDIRS} ./md5sums
	mv build/${PATIENT}/usr/lib/ipkg/info/com.palm.app.firstuse.md5sums{,.old}
	mv build/${PATIENT}/md5sums{,.old}
	touch $@

.PHONY: download-%
download-%:
	${MAKE} CARRIER=$* download

.PHONY: download
download: downloads/${DOCTOR}

downloads/${DOCTOR}:
	mkdir -p downloads
	curl -R -L -o $@ http://palm.cdnetworks.net/rom/${DEVICE}_${MODEL}/webosdoctor${MODEL}${CARRIER}.jar

clobber:
	rm -rf build
