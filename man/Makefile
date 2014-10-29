#
# Copyright (c) 2014 Opsmate, Inc.
#
# See COPYING file for license information.
#

MANPAGES = man1/mkcertchain.1

all: $(MANPAGES)

man1/mkcertchain.1: ../bin/mkcertchain
	pod2man $< > $@

clean:
	rm -f $(MANPAGES)

.PHONY: all clean
