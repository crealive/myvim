# myvim

The main goal of this vim configuration is to keep it small and simple.

It is based on a simple vimrc, inspired from [dotvim](https://github.com/bling/dotvim). It contains the most useful key mappings and settings. A modern vim package manager, [NeoBundle](https://github.com/Shougo/neobundle.vim), makes it easy to install your favourite packages. Of course it supports to use your own vim scripts you already have maybe. But in addition to that, there are already preconfigured bundles of plugins, called modules. By default these modules are not activated, to enable you to use only what you really need. That's why I've called it 'myvim': It should be easy to customize it to your own needs.


## Installation

There are two ways to install this distribution:

### Git

1. Make a backup from your current .vim and .vimrc
2. Clone this repository somewhere in your home directory
3. Create links from the .vimrc and .vim from the cloned repository to your home directory's root: 
`ln -s <path-to-repo>/myvim/.vimrc ~/.vimrc && ln -s <path-to-repo>/myvim/.vim ~/.vim;`

### Copy the .vimrc

If curl is installed, it is very easy to copy the .vimrc to your home directory's root:

1. Make a backup from your current .vim and .vimrc
2. `curl https://raw.githubusercontent.com/crealive/myvim/master/.vimrc > ~/.vimrc`

### Use your own .vimrc

After cloning this project or copying only it's .vimrc you can keep using the .vimrc you aleady had before.

```
" Your own .vimrc
let g:ownvim = {}
let g:ownvim.plugin_groups = []

source <path-to-myvim-.vimrc>

" Your own settings...

" After all call
call PluginsComplete()
```

## Configuration

When vim is started with this configuration the first time, the package manager will be installed automatically.

With a `:e $MYVIMRC` ENTER you're able to change the configuration. If you want to activate the modules, for example, you can update the groups list:

```
" By default there are no additional modules loaded
let g:myvim_plugin_groups = []

" For a more comfortable editing experience, activating the editing module 
" could be a nice idea. To do that, change the myvim_plugin_groups list to:
let g:myvim_plugin_groups = [ 'editing' ]
```

After saving your changes, call `:so $MYVIMRC` ENTER to reload the configuration.

## Customizing

If you want to use your own scripts additionaly, simply move them in this directory `~/.vim/scripts/`.


