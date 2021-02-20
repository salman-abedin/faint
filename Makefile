.POSIX:
DIR_BIN = /usr/local/bin
DIR_DATA = ~/.local/share/faint
CONFIG = ~/.config/faintrc
init:
	@mkdir -p $(DIR_DATA)
	@[ -f $(CONFIG) ] || { cp faintrc $(CONFIG) && sed -i '/config\/faintrc/d' $(CONFIG); }
	@echo Initiation finished.
install:
	@cp faintrc /etc
	@mkdir -p $(DIR_BIN)
	@for script in src/*; do \
		cp -f $$script $(DIR_BIN); \
		chmod 755 $(DIR_BIN)/$${script#src/}; \
		done
	@echo Installation finished.
uninstall:
	@for script in src/*; do rm -f $(DIR_BIN)/$${script#src/}; done
	@echo Uninstallation finished.
.PHONY: init install uninstall
