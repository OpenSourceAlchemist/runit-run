DESTDIR=

install:
	for i in 1 2 3 4; do install -d '$(DESTDIR)'/etc/sv/getty-$$i; done
	for i in 1 2 3 4; do \
	  install -m0755 getty-$$i/run \
	    '$(DESTDIR)'/etc/sv/getty-$$i/run && \
	  install -m0755 getty-$$i/finish \
	    '$(DESTDIR)'/etc/sv/getty-$$i/finish || exit 1; \
	done
	for i in 1 2 3 ctrlaltdel; do \
	  install -m0755 $$i '$(DESTDIR)'/etc/runit/$$i || exit 1; \
	done
	install -m0755 runit-policy-rc.d \
	  '$(DESTDIR)'/usr/sbin/runit-policy-rc.d
