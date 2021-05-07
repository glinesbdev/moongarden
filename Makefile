LUA ?= lua
FENNEL ?= ./bin/fennel
DESTDIR ?=
PREFIX ?= /usr/local
BIN_DIR ?= $(PREFIX)/bin

build: moongarden

moongarden: src/core.fnl
	@echo "#!/usr/bin/env $(LUA)" > $@
	@$(FENNEL) --compile --no-metadata --require-as-include $< >> $@
	@chmod 755 $@

install: moongarden
	mkdir -p $(DESTDIR)$(BIN_DIR) && \
		cp moongarden $(DESTDIR)$(BIN_DIR)/

test: moongarden
	@$(LUA) test/init.lua

clean:
	@rm moongarden

.PHONY: build moongarden test clean
