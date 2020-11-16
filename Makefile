.POSIX:
BIN_DIR = /usr/local/bin
install: clean
	@mkdir -p $(BIN_DIR)
	@for script in src/*; do \
		cp -f $$script $(BIN_DIR); \
		chmod 755 $(BIN_DIR)/$${script#src/}; \
		done
	@echo Done installing the executable files.
uninstall:
	@for script in src/*;do \
		rm -f $(BIN_DIR)/$${script#src/}; \
		done
	@echo Done removing executable files.
clean:
	@rm -f ~/.local/share/faint/FAINT_FILTERS
.PHONY: install uninstall clean
