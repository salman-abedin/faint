.POSIX:
BIN_DIR = /usr/local/bin
install:
	@mkdir -p $(BIN_DIR)
	@for e in *.sh; do \
		cp -f $$e $${e%.*}; \
		chmod 755 $${e%.*}; \
		mv $${e%.*} $(BIN_DIR); \
		done
	@echo Done installing executable files to $(BIN_DIR)
uninstall:
	@for e in *.sh;do \
		rm -f $(BIN_DIR)/$${e%.*}; \
		done
	@echo Done removing executable files from $(BIN_DIR)
.PHONY: install uninstall
