symlinks = merge-ledger getquote gethistoric cryptotrade2ledger \
		   dwolla2ledger fidelity2ledger lbcsv2ledger mint2ledger

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
clawsdir = ~/.claws-mail

install: $(symlinks) claws-filter

uninstall:
	cd $(DESTDIR)$(bindir);
	rm -f $(symlinks)
	rm -f $(clawsdir)/perl_filter

claws-filter:
	ln -f -s $(abspath $@) $(clawsdir)/perl_filter

$(symlinks):
	ln -f -s $(abspath $@) $(DESTDIR)$(bindir)

.PHONY: $(symlinks) claws-filter
