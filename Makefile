
BIN ?= downloadwordpress
PREFIX ?= /usr/local

install:
	cp src/downloadwordpress.sh $(PREFIX)/bin/$(BIN)
	chmod +x $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
	