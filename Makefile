.POSIX:
DIR_BIN = /usr/local/bin
DIR_DATA = ~/.local/share/faint
CONFIG = ~/.config/faintrc
init:
	@mkdir -p $(DIR_BIN)
	@[ -f $(CONFIG) ] || { cp src/faint-config $(CONFIG) && sed -i '$$d' $(CONFIG); }
	@echo Done initiating configs.
install:
	@for script in src/*; do \
		cp -f $$script $(DIR_BIN); \
		chmod 755 $(DIR_BIN)/$${script#src/}; \
		done
	@echo Done installing the executable files.
uninstall:
	@for script in src/*;do rm -f $(DIR_BIN)/$${script#src/}; done
	@rm -fr $(DIR_DATA) $(CONFIG)
	@echo Done removing executable files.
.PHONY: init install uninstall
