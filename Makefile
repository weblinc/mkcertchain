#
# Copyright (c) 2014 Opsmate, Inc.
#
# See COPYING file for license information.
#

PROJECT = mkcertchain
VERSION = 0.1.1

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share/mkcertchain
DOCDIR ?= $(PREFIX)/share/doc/mkcertchain
MANDIR ?= $(PREFIX)/share/man
DISTDIR ?= $(PROJECT)-$(VERSION)
DISTFILE ?= $(DISTDIR).tar

all: build

#
# Build
#
build: build-bin build-man

build-bin:

build-man:
#	$(MAKE) -C man all

#
# Clean
#
clean: clean-bin clean-man

clean-bin:

clean-man:
#	$(MAKE) -C man clean

#
# Install
#
install: install-bin install-data install-doc install-man

install-bin:
	mkdir -m 755 -p $(DESTDIR)$(BINDIR)
	install -m 755 bin/mkcertchain $(DESTDIR)$(BINDIR)/

install-data:
	mkdir -m 755 -p $(DESTDIR)$(DATADIR)
	install -m 644 share/mkcertchain/browser_roots.pem $(DESTDIR)$(DATADIR)/

install-doc:
	mkdir -m 755 -p $(DESTDIR)$(DOCDIR)
	install -m 644 README NEWS $(DESTDIR)$(DOCDIR)/

install-man:
	mkdir -m 755 -p $(DESTDIR)$(MANDIR)/man1
	install -m 644 man/man1/mkcertchain.1 $(DESTDIR)$(MANDIR)/man1/

install-paths:
	mkdir -m 755 -p $(DESTDIR)/etc/paths.d $(DESTDIR)/etc/manpaths.d
	echo $(BINDIR) > $(DESTDIR)/etc/paths.d/mkcertchain
	echo $(MANDIR) > $(DESTDIR)/etc/manpaths.d/mkcertchain

#
# Uninstall
#
uninstall: uninstall-bin uninstall-data uninstall-doc uninstall-man

uninstall-bin:
	rm -f $(DESTDIR)$(BINDIR)/mkcertchain

uninstall-data:
	rm -f $(DESTDIR)$(DATADIR)/browser_roots.pem
	rmdir --ignore-fail-on-non-empty $(DESTDIR)$(DATADIR)

uninstall-doc:
	rm -f $(DESTDIR)$(DOCDIR)/README
	rm -f $(DESTDIR)$(DOCDIR)/NEWS
	rmdir --ignore-fail-on-non-empty $(DESTDIR)$(DOCDIR)

uninstall-man:
	rm -f $(DESTDIR)$(MANDIR)/man1/mkcertchain.1

uninstall-paths:
	rm -f $(DESTDIR)/etc/paths.d/mkcertchain $(DESTDIR)/etc/manpaths.d/mkcertchain

#
# 'make dist'
#
dist:
	git archive --prefix=$(DISTDIR)/ $(VERSION) | gzip -n9 > $(DISTFILE).gz

#
# Misc.
#
get-version:
	@echo $(VERSION)

.PHONY: all \
	build build-bin build-man \
	clean clean-bin clean-man \
	install install-bin install-man \
	uninstall uninstall-bin uninstall-man \
	dist get-version
