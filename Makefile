LUA ?= lua
FENNEL ?= ./bin/fennel

build: moongarden

moongarden: src/core.fnl
	@echo "#!/usr/bin/env $(LUA)" > $@
	@$(FENNEL) --compile --no-metadata $< >> $@
	@chmod 755 $@

test: moongarden
	@$(LUA) test/init.lua

clean:
	@rm moongarden

.PHONY: build moongarden test clean
