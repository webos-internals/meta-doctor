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

DOCTOR  = webosdoctor${VERSION}${CARRIER}.jar

.PHONY: unpack-sprint
unpack-sprint:
	${MAKE} CARRIER=sprint unpack

.PHONY: unpack-bellmo
unpack-bellmo:
	${MAKE} CARRIER=bellmo unpack

.PHONY: unpack
unpack: build/${DEVICE}_${VERSION}_${CARRIER}/META-INF/MANIFEST.MF

build/${DEVICE}_${VERSION}_${CARRIER}/META-INF/MANIFEST.MF: downloads/${DOCTOR}
	rm -rf build/${DEVICE}_${VERSION}_${CARRIER}
	mkdir -p build/${DEVICE}_${VERSION}_${CARRIER}
	unzip -d build/${DEVICE}_${VERSION}_${CARRIER} $<
	[ -f $@ ] && touch $@

.PHONY: download-sprint
download-sprint:
	${MAKE} CARRIER=sprint download

.PHONY: download-bellmo
download-bellmo:
	${MAKE} CARRIER=bellmo download

.PHONY: download
download: downloads/${DOCTOR}

downloads/${DOCTOR}:
	mkdir -p downloads
	curl -R -L -o $@ http://palm.cdnetworks.net/rom/${DEVICE}_${VERSION}/${DOCTOR}

clobber:
	rm -rf build
