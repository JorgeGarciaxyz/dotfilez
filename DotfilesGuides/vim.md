# Setup

## Fzf

Install `fzf` package

```
sudo pacman -S fzf
```

## Ag

```
sudo pacman -S the_silver_searcher
```


## Vundle

Follow [instructions](https://github.com/VundleVim/Vundle.vim)

```
vim +PluginInstall +qall
```

## YouCompleteMe

```
sudo pacman -S libnghttp2
```

```
yay -S vim-youcompleteme-git
```

## Install plugins

```
vim

:PluginInstall
```

## Solarized (what else I would use?)


Follow https://github.com/lifepillar/vim-solarized8

Tldr;
> if `echo has('packages')` (on vim) print 1, then
```
git clone https://github.com/lifepillar/vim-solarized8.git \
    ~/.vim/pack/themes/opt/solarized8
```
