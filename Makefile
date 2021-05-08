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

uploadrock: rockspecs/moongarden-$(VERSION)-1.rockspec
	luarocks --local build $<
	$(HOME)/.luarocks/bin/moongarden --version | grep $(VERSION)
	luarocks --local remove moongarden
	luarocks upload --sign --api-key $(shell pass luarocks-api-key) $<
	luarocks --local install moongarden
	$(HOME)/.luarocks/bin/moongarden --version | grep $(VERSION)
	luarocks --local remove moongarden

clean:
	@rm moongarden

.PHONY: build moongarden test clean uploadrock
