BREW_INSTALL_URL := https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

.PHONY: bootstrap install

bootstrap:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL $(BREW_INSTALL_URL))"; \
	else \
		echo "Homebrew already installed, running update..."; \
		brew update; \
	fi

install:
	brew bundle --file=Brewfile
