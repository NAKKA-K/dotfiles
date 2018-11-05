# vim
## install

1. 以下の様に`vim_link.sh`を実行するだけで、設定を適応できます。(設定はこのディレクトリから常時同期されます)

```bash
./vim_link.sh
```

2. vimのプラグインをダウンロードする必要があります。vimを開いてコマンドで以下を入力してください。リポジトリ内のdein.tomlに書かれてあるプラグインが導入されます。

```bash
:source ~/.vimrc
```

*※vimが7.2の場合、deinプラグインのバージョンを1.5に落とす必要があります。(`.cache/dein/repos/github.com/Shougo/dein.vim`に移動し、`git checkout`でバージョンを1.5に落としましょう)*


# bash
## install
bashの設定は個人用にいじってあるため、適応する場合はコードをよく読んでから適応してください。

```bash
./bash_link.sh
```
