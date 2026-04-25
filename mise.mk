MISE_BIN := $(HOME)/.local/bin/mise

.PHONY: bootstrap install

bootstrap:
	@if [ ! -x "$(MISE_BIN)" ]; then \
		echo "Installing mise..."; \
		curl https://mise.run | sh; \
	else \
		echo "mise already installed, running self-update..."; \
		$(MISE_BIN) self-update; \
	fi

install:
	$(MISE_BIN) install
