obj_locale = ru
obj_script = ldd-requires

all: msgfmt

install: 
	for i in $(obj_script); do \
		mkdir -p $(DESTDIR)/usr/bin;\
		install -v $$i $(DESTDIR)/usr/bin; \
		for j in $(obj_locale);	do \
			mkdir -p $(DESTDIR)/usr/share/locale/$$j/LC_MESSAGES/;\
			install -v locale/$$j/LC_MESSAGES/$$i.mo $(DESTDIR)/usr/share/locale/$$j/LC_MESSAGES/ ;\
		done ;\
	done
	
uninstall:
	for i in $(obj_script); do \
		rm -fv $(DESTDIR)/usr/bin/$$i; \
		for j in $(obj_locale);	do \
			rm -fv $(DESTDIR)/usr/share/locale/$$j/LC_MESSAGES/$$i.mo; \
		done ;\
	done

gen_pot:
	for i in $(obj_script); do \
		xgettext --from-code=utf-8 -L shell -o $$i.pot $$i; \
	done

msgmerge: gen_pot
	for i in $(obj_script); do \
		for j in $(obj_locale);	do \
			msgmerge -U $$i-of-$$j.po $$i.pot ;\
		done ;\
	done

msginit: gen_pot
	for i in $(obj_script); do \
		msginit -i $$i.pot -o $$i-of-$1.po;\
	done

msgfmt: 
	for i in $(obj_script); do \
		for j in $(obj_locale);	do \
			msgfmt $$i-of-$$j.po -o $$i-of-$$j.mo;\
			mkdir -p locale/$$j/LC_MESSAGES/;\
			mv $$i-of-$$j.mo locale/$$j/LC_MESSAGES/$$i.mo;\
		done ;\
	done

clean:
	rm -Rfv locale/ *.pot

