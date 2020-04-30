# Cheat sheet


## fzf

```
# ~/.zshrc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ~/.fzf.zsh
# fzf command ...
```

- [fzf examples](https://github.com/junegunn/fzf/wiki/Examples)
- [forgit is a utility tool powered by fzf for using git interactively.](https://github.com/wfxr/forgit)


powered by forgit
| command | what |
| --- | --- |
| ga | Interactive `git add` selector |
| glo | Interactive `git log` viewer with preview |
| gi | Interactive ``.gitignore`` generator from selected file |
| gd | Interactive `git diff` viewer |
| grh | `git reset HEAD <file>` with file search |
| gcf | Interactive `git checkout <file>` selector |
| gss | Interactive `git stash` viewer |
| gclean | Interactive `git clean`  selector |

powered by ~/.fzf.zsh
| command | what |
| --- | --- |
| gsw | Interactive `git switch` selector |
| glol | Interactive `git lol` selector detail |
| fd | Interactive `cd` selector |


### fzf default keybinds

| Keybind                                       | Action                  |
| :-------------------------------------------: | ----------------------- |
| <kbd>Enter</kbd>                              | Confirm                 |
| <kbd>Tab</kbd>                                | Toggle mark             |
| <kbd>?</kbd>                                  | Toggle preview window   |
| <kbd>Alt</kbd> - <kbd>W</kbd>                 | Toggle preview wrap     |
| <kbd>Ctrl</kbd> - <kbd>S</kbd>                | Toggle sort             |
| <kbd>Ctrl</kbd> - <kbd>R</kbd>                | Toggle selection        |
| <kbd>Ctrl</kbd> - <kbd>K</kbd> / <kbd>P</kbd> | Selection move up       |
| <kbd>Ctrl</kbd> - <kbd>J</kbd> / <kbd>N</kbd> | Selection move down     |
| <kbd>Alt</kbd> - <kbd>K</kbd> / <kbd>P</kbd>  | Preview move up         |
| <kbd>Alt</kbd> - <kbd>J</kbd> / <kbd>N</kbd>  | Preview move down       |
