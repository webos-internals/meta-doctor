#!/usr/bin/python

import sys
import re
import fileinput

md5sums = {}

for line in fileinput.input([sys.argv[2]]) :

    regexp = re.compile('^([a-z0-9]+) +\*?(.*)$')
    m = regexp.match(line)
    if (m):
        key = m.group(2)
        md5sums[key] = m.group(1)

for line in fileinput.input([sys.argv[1]]) :

    regexp = re.compile('^([a-z0-9]+) +\*?(.*)$')
    m = regexp.match(line)
    if (m):
        key = m.group(2)

        if ((key in md5sums) and (md5sums[key] != m.group(1))) :
            sys.stderr.write("Overwriting md5sum for %s\n" % key)
            print "%s *%s" % (md5sums[key], key)
        else :
            print line.rstrip('\n')
