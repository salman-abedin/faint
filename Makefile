.POSIX:
BIN_DIR = /usr/local/bin
install: clean
	@install -D --mode=755 --target-directory=${BIN_DIR} src/faint{,-{bookmark,explore,fetch-config,operate}}
	@install -D --mode=444 --target-directory=/usr/share/faint src/faint-config
	@echo Done installing.
uninstall:
	@for script in src/*;do rm -f $(BIN_DIR)/$${script#src/}; done
	@unlink /usr/share/faint/faint-config
	@rmdir /usr/share/faint
	@echo Done removing.
clean:
	@rm -f ~/.local/share/faint/FAINT_FILTERS
.PHONY: install uninstall clean
