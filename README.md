# dotfiles

Personal config for Ubuntu (GNOME Terminal), managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level folder is a "package" that mirrors the home directory. Stow symlinks its contents into `~`,
so editing `~/.tmux.conf` edits the file in this repo.

## Layout

```
dotfiles/
├── tmux/
│   └── .tmux.conf
├── vim/
│   └── .vimrc
└── bin/
    └── bin/
        └── dev          # tmux session/layout launcher -> ~/bin/dev
```

Adjust this list if you add or remove packages.

## Quick setup on a new machine

```bash
# 1. Install the basics
sudo apt update
sudo apt install git stow tmux vim-gtk3 xclip wl-clipboard fzf htop

# 2. Set up an SSH key for GitHub (skip if you clone over HTTPS)
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub        # add at GitHub -> Settings -> SSH and GPG keys
ssh -T git@github.com            # should greet you by username

# 3. Clone the repo
git clone git@github.com:YOURNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 4. Remove existing default files that would conflict (Stow won't overwrite real files)
mv ~/.bashrc ~/.bashrc.bak 2>/dev/null   # only if you stow a bash package
mv ~/.tmux.conf ~/.tmux.conf.bak 2>/dev/null
mv ~/.vimrc ~/.vimrc.bak 2>/dev/null

# 5. Create the symlinks
stow tmux vim bin

# 6. Install tmux plugin manager, then the plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new -s setup
#   inside tmux press: prefix + I   (prefix is Ctrl+Space, then capital I)
```

Make sure `~/bin` is on your `PATH` (Ubuntu adds it automatically at login if the folder exists;
log out and back in, or run `source ~/.profile`).

## Day to day

| Task | Command |
|---|---|
| Add a new file to a package | move it into the repo, e.g. `mv ~/.gitconfig ~/dotfiles/git/`, then `stow git` |
| Re-create links after changes | `cd ~/dotfiles && stow -R tmux vim bin` |
| Remove a package's links | `stow -D tmux` |
| Save changes | `cd ~/dotfiles && git add -A && git commit -m "..." && git push` |

## tmux notes

- Prefix is `Ctrl+Space`. Reload config with `prefix + r`.
- Plugins (managed by TPM): resurrect, continuum, minimal-tmux-status, tmux-yank.
  Install with `prefix + I`, update with `prefix + U`.
- Sessions are saved automatically by continuum and restored when tmux starts.
- After changing terminal-related options (`default-terminal`, `terminal-features`),
  detach and reattach, or run `tmux kill-server` and start again.
- `~/bin/dev` creates the dev session with my layout, or attaches if it already exists.

## Clipboard

- tmux-yank sends yanks to the system clipboard. It needs `xclip` (X11) or `wl-clipboard` (Wayland).
- Paste in GNOME Terminal with `Ctrl+Shift+V`.
- Vim needs clipboard support: `vim --version | grep clipboard` must show `+clipboard`
  (that is what `vim-gtk3` provides).

## Secrets

Never commit private keys, tokens or `.env` files. Machine-specific or secret settings go in untracked files
such as `~/.bashrc.local`, which the shell config sources if present.
