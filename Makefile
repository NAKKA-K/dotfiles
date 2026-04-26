# 一括セットアップ用エントリポイント。
# 実行順序: Homebrew 本体 → mise 本体 → mise install → brew bundle
# Brewfile の go "..." ディレクティブは mise 管理の go を必要とするため、
# brew bundle 実行前に mise の shims を PATH に通す。

MISE_SHIMS := $(HOME)/.local/share/mise/shims

.PHONY: install

install:
	$(MAKE) -f brew.mk bootstrap
	$(MAKE) -f mise.mk bootstrap
	$(MAKE) -f mise.mk install
	PATH="$(MISE_SHIMS):$$PATH" $(MAKE) -f brew.mk install
