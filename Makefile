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
VERSION = p100eww
CARRIER = sprint

ifeq (${DEVICE},pre)
CODENAME = castle
endif

DOCTOR  = webosdoctor${VERSION}${CARRIER}.jar

all: patch-sprint patch-bellmo

.PHONY: patch-%
patch-%:
	${MAKE} CARRIER=$* patch

.PHONY: patch
patch: build/${DEVICE}_${VERSION}_${CARRIER}/md5sums

build/${DEVICE}_${VERSION}_${CARRIER}/md5sums: build/${DEVICE}_${VERSION}_${CARRIER}/md5sums.old
	( cd build/${DEVICE}_${VERSION}_${CARRIER} ; find . ! -name 'md5sums*' -type f | \
		xargs md5sum > md5sums.new )
	./scripts/replace-md5sums.py build/${DEVICE}_${VERSION}_${CARRIER}/md5sums.old \
				     build/${DEVICE}_${VERSION}_${CARRIER}/md5sums.new > \
				     build/${DEVICE}_${VERSION}_${CARRIER}/md5sums

.PHONY: unpack-%
unpack-%:
	${MAKE} CARRIER=$* unpack

.PHONY: unpack
unpack: build/${DEVICE}_${VERSION}_${CARRIER}/md5sums.old

build/${DEVICE}_${VERSION}_${CARRIER}/md5sums.old: downloads/${DOCTOR}
	rm -rf build/${DEVICE}_${VERSION}_${CARRIER}
	mkdir -p build/${DEVICE}_${VERSION}_${CARRIER}
	unzip -p $< resources/webOS.tar | \
	tar -O -x -f - ./nova-cust-image-castle.rootfs.tar.gz | \
	tar -C build/${DEVICE}_${VERSION}_${CARRIER} -m -z -x -f - \
		./usr/palm/applications/com.palm.app.firstuse \
		./usr/lib/ipkg/info \
		./md5sums
	mv build/${DEVICE}_${VERSION}_${CARRIER}/md5sums $@

.PHONY: download-%
download-%:
	${MAKE} CARRIER=$* download

.PHONY: download
download: downloads/${DOCTOR}

downloads/${DOCTOR}:
	mkdir -p downloads
	curl -R -L -o $@ http://palm.cdnetworks.net/rom/${DEVICE}_${VERSION}/${DOCTOR}

clobber:
	rm -rf build
