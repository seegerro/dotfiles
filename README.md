# dotfiles

My config for Ubuntu (GNOME Terminal): **tmux**, **vim** and **zsh**, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

Each top-level folder is a Stow "package" that mirrors the home directory. Stow symlinks its contents into `~`,
so editing `~/.tmux.conf` edits the file in this repo.

## Layout

```
dotfiles/
├── .gitignore
├── .gitmodules
├── tmux/
│   └── .tmux.conf
├── vim/
│   ├── .vimrc
│   └── .vim/bundle/Vundle.vim     # git submodule
└── zsh/
    ├── .zshrc
    └── .oh-my-zsh                 # git submodule
```

Vundle and oh-my-zsh are **git submodules**, so clone with `--recurse-submodules` (see below).

## Setup on a new machine

```bash
# 1. Install the tools
sudo apt update
sudo apt install git stow tmux vim zsh htop xclip wl-clipboard curl

# 2. SSH key for GitHub (skip if you clone over HTTPS)
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub          # add at GitHub -> Settings -> SSH and GPG keys
ssh -T git@github.com              # should greet you by username

# 3. Clone the repo including the submodules
git clone --recurse-submodules git@github.com:seegerro/dotfiles.git ~/dotfiles
cd ~/dotfiles
#    already cloned without submodules?
#    git submodule update --init --recursive

# 4. Move existing files out of the way (Stow will not overwrite real files)
mv ~/.tmux.conf ~/.tmux.conf.bak 2>/dev/null
mv ~/.vimrc     ~/.vimrc.bak     2>/dev/null
mv ~/.vim       ~/.vim.bak       2>/dev/null
mv ~/.zshrc     ~/.zshrc.bak     2>/dev/null
mv ~/.oh-my-zsh ~/.oh-my-zsh.bak 2>/dev/null

# 5. Create the symlinks
stow tmux vim zsh

# 6. tmux plugins: install TPM, start tmux, then press  prefix + I  (Ctrl+Space, then capital I)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux

# 7. vim plugins
vim +PluginInstall +qall

# 8. Make zsh the default shell (log out and back in afterwards)
chsh -s "$(which zsh)"
```

Check that the links exist: `ls -l ~/.tmux.conf ~/.vimrc ~/.zshrc ~/.vim ~/.oh-my-zsh`.

## What's in each package

### tmux
- Prefix is `Ctrl+Space`. Reload the config with `prefix + r`. Requires tmux 3.2+ (for the popup).
- Windows and panes start at 1. Splits and new windows open in the current directory:
  `prefix + |` (side by side), `prefix + -` (stacked), `prefix + c` (new window).
- Pane navigation `prefix + h/j/k/l`, resize with `prefix + H/J/K/L` (repeatable),
  previous/next window with `prefix + Ctrl-h` / `Ctrl-l`.
- `prefix + g` opens htop in a popup. Mouse mode is on. Copy mode uses vi keys (`v` to select, `y` to yank).
- Plugins (managed by TPM): tmux-resurrect, tmux-continuum (auto-save and restore sessions),
  minimal-tmux-status, tmux-yank (yanks go to the system clipboard).
  Install with `prefix + I`, update with `prefix + U`.
- After changing terminal options (`default-terminal`, `terminal-features`), detach and reattach,
  or run `tmux kill-server` and start again.

### vim
- Plugins are managed by [Vundle](https://github.com/VundleVim/Vundle.vim): lightline.vim and vim-colors-solarized.
  Install with `vim +PluginInstall +qall`, update with `vim +PluginUpdate +qall`.
- Add a plugin by putting a `Plugin '...'` line in `.vimrc` and running `:PluginInstall`.
- Vundle installs plugins into `vim/.vim/bundle/` inside this repo. They are not part of the repo:
  `.gitignore` ignores everything there except the Vundle submodule itself.
- System clipboard integration (`set clipboard=unnamedplus`) is commented out in `.vimrc`.
  To use it, install `vim-gtk3` and check that `vim --version | grep clipboard` shows `+clipboard`.

### zsh
- `.zshrc` plus [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) as a submodule at `~/.oh-my-zsh`.
- Do not run the oh-my-zsh installer. The submodule already provides it, and the installer would
  overwrite `.zshrc`.

## Clipboard

- tmux-yank needs `xclip` (X11) or `wl-clipboard` (Wayland). Both are installed in step 1.
- Paste in GNOME Terminal with `Ctrl+Shift+V` (middle-click pastes the separate "primary" selection).

## Day to day

| Task | Command |
|---|---|
| Add a new package | `mkdir ~/dotfiles/git && mv ~/.gitconfig ~/dotfiles/git/ && cd ~/dotfiles && stow git` |
| Re-create links after changes | `cd ~/dotfiles && stow -R tmux vim zsh` |
| Remove a package's links | `cd ~/dotfiles && stow -D tmux` |
| Update the submodules | `cd ~/dotfiles && git submodule update --remote --merge` |
| Save changes | `cd ~/dotfiles && git add -A && git commit -m "..." && git push` |

## Secrets and `.gitignore`

Never commit private keys, tokens or `.env` files. Keep machine-specific or secret settings in untracked files
(for example `~/.zshrc.local`, sourced from `.zshrc`).

`.gitignore` covers plugin installs (Vundle bundles), vim swap/undo files, shell history and caches,
`*.local`, `.env*` and key files. It only affects untracked files: if something already committed should be
ignored, run `git rm --cached <file>`. Before pushing, check the shell config for secrets:
`grep -inE 'token|secret|key|password' zsh/.zshrc`.

oh-my-zsh writes `cache/` and `log/` into its own folder. It ignores those itself, so they need no entry here.
