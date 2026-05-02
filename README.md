# dotfiles

Personal macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Fresh Mac Setup

### Step 1 — Get the repo

You need the repo on disk before running anything. Two options:

**Option A — Clone (recommended)**

Git isn't available on a stock macOS until Xcode CLT is installed. Trying to run
`git` in Terminal will trigger a system prompt to install the CLT automatically.
Accept it, wait for it to finish, then clone:

```sh
# GitHub
mkdir -p ~/Code/github.com/kobfolson
git clone https://github.com/kobfolson/dotfiles.git ~/Code/github.com/kobfolson/dotfiles
cd ~/Code/github.com/kobfolson/dotfiles

# GitLab
mkdir -p ~/Code/gitlab.com/<your-username>
git clone https://gitlab.com/<your-username>/dotfiles.git ~/Code/gitlab.com/<your-username>/dotfiles
cd ~/Code/gitlab.com/<your-username>/dotfiles
```

**Option B — Download ZIP**

If you can't clone (no internet access to git, firewall, etc.), download the ZIP
from GitHub/GitLab and unzip it. Place the contents at the same path as above.
Note: a downloaded ZIP is **not** a git repository — version control won't work
until you run `git init && git remote add origin <url>` after setup.

### Step 2 — Run bootstrap

```sh
./bootstrap.sh
```

This script handles everything in order:

1. Installs **Xcode Command Line Tools** (if not already present — a GUI dialog will appear)
2. Accepts the Xcode license
3. Installs **Homebrew**
4. Runs `make` to install packages, stow configs, set up mise tools, and apply system preferences

> **sudo required** — the Xcode license step needs it. You'll be prompted for your password.

---

## What gets installed

| Step | What it does |
|---|---|
| `brew bundle` | Installs everything in `Brewfile` |
| `stow` | Symlinks config dirs (`bat`, `git`, `mpv`, `wezterm`, `zsh`, `direnv`, `ruff`) into `~` |
| `mise` | Installs `terraform`, `kubectl`, `helm`, `go`, and `node` at their latest/LTS versions |
| `uv tool install ruff` | Installs ruff as a global uv tool |
| `system` | Applies macOS preferences (dark mode, dock, screenshots location, etc.) |

---

## Directory layout

The repo follows [ghq](https://github.com/x-motemen/ghq) conventions with `~/Code` as root:

```
~/Code/
  github.com/kobfolson/dotfiles/   ← GitHub
  gitlab.com/<username>/dotfiles/  ← GitLab
```

Running `stow` from any other location will still work, but placing the repo
here keeps it consistent with `ghq` and the fuzzy repo picker in the shell.

---

## Individual make targets

```sh
make run_brewfile      # brew bundle
make stow_dirs         # stow all config directories
make setup_mise        # install dev tools via mise
make setup_uv_tools    # install uv tools (ruff)
make system            # apply macOS system preferences
make install_brew      # install Homebrew (handled by bootstrap.sh on fresh machines)
```

---

## GitLab

[`glab`](https://gitlab.com/gitlab-org/cli) (the GitLab CLI) is included in the
Brewfile as a counterpart to `gh`. Authenticate after setup:

```sh
glab auth login
```

[`ghq`](https://github.com/x-motemen/ghq) works with both GitHub and GitLab out
of the box — clone, list, and fuzzy-jump to repos from either host.
