.POSIX:
SHELL := /bin/bash
BIN_DIR = /usr/local/bin
DATA_DIR = ~/.local/share/faint
CONFIG = ~/.config/faintrc
TEMP = /tmp/FAINT_TEMP
init:
	@mkdir -p $(DATA_DIR)
	@ [ -f $(CONFIG) ] || { cp src/faint-config $(CONFIG); sed -i '$$d' $(CONFIG); }
	@ cp $(CONFIG) $(TEMP)
	@echo Done initiating configs.
install:
	@mkdir -p $(BIN_DIR)
	@for script in src/*; do \
		cp -f $$script $(BIN_DIR); \
		chmod 755 $(BIN_DIR)/$${script#src/}; \
		done
	@source $(TEMP); \
		mkdir -p $$TRASH_DIR; \
		faint-fetch-config "$$FILTERS" -k | \
      awk '{printf "%s\\|",$$0;}' | \
		sed -e 's/|\./|\\./g' -e 's/\\|$$//g' > $(DATA_DIR)/FAINT_FILTERS
	@rm $(TEMP)
	@echo Done installing the executable files.
uninstall:
	@for script in src/*;do rm -f $(BIN_DIR)/$${script#src/}; done
	@rm -fr $(DATA_DIR) $(CONFIG)
	@echo Done removing executable files.
.PHONY: init install uninstall
