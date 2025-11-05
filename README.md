# Dotfiles - Windows Setup

Windows dotfiles configuration using Scoop package manager and Git Bash.

## Prerequisites

- Windows 10/11
- Git for Windows (includes Git Bash)
- Administrator access (for initial setup)

## Quick Start

1. **Install Git for Windows** (if not already installed)
   - Download from https://git-scm.com/download/win
   - During installation, select "Use Git and optional Unix tools from the Command Prompt"

2. **Clone this repository**
```bash
cd ~
git clone https://github.com/kobfolson/dotfiles.git
cd dotfiles
git checkout windows
```

3. **Install Scoop** (Windows package manager)
```bash
# In Git Bash
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; irm get.scoop.sh | iex"
```

4. **Run the setup script**
```bash
./setup.sh
```

5. **Restart Git Bash** to load the new configuration

## Manual Setup

### 1. Install Scoop Packages
```bash
# In Git Bash
scoop install git
scoop bucket add extras
scoop bucket add nerd-fonts
scoop import Scoopfile.json
```

### 2. Install GNU Stow (for symlinking)
```bash
scoop install stow
```

### 3. Stow Configuration Directories
```bash
# Navigate to dotfiles directory
cd ~/dotfiles

# Stow individual configs
stow -v git
stow -v bash
stow -v bat
stow -v direnv
```

### 4. Reload Git Bash Profile
```bash
# The .bashrc and .bash_profile will be symlinked by stow
# Reload your profile
source ~/.bashrc
```

## What's Included

### Package Manager - Scoop
Installs essential development tools and utilities:
- **CLI Tools**: git, gh, fd, bat, ripgrep, fzf, neovim, stow
- **Development**: Python, uv (modern Python package manager), Node.js, ansible, shellcheck, lazydocker
- **Python Tools**: ruff (linter/formatter), mypy (type checker) - installed via uv
- **Productivity**: PowerToys, Everything (search tool)
- **Applications**: VSCode, Docker, Postman, Spotify, browsers
- **Fonts**: JetBrainsMono Nerd Font, CascadiaCode Nerd Font

### Shell Configuration - Bash
- Custom `.bashrc` with Git Bash optimizations
- Modular configuration (aliases, functions, paths)
- Modern tool aliases (exa/eza for ls, bat for cat, nvim for vim)
- Git shortcuts and Docker aliases
- direnv integration (if installed)
- Starship prompt support (if installed)

### Tools Configuration
- **git**: Git configuration and settings
- **bat**: Syntax highlighting for cat
- **direnv**: Directory-specific environment variables

## Directory Structure

```
dotfiles/
├── bash/               # Bash configuration (Git Bash)
│   ├── .bashrc
│   ├── .bash_profile
│   └── .config/bash/
│       ├── modules/    # aliases, functions, paths
│       └── functions/  # custom shell functions
├── bat/                # bat (cat alternative) config
├── direnv/             # direnv configuration
├── git/                # Git configuration
├── Scoopfile.json      # Scoop package definitions
├── setup.sh            # Automated setup script
└── README.md           # This file
```

## WSL Integration

If you also use WSL (Windows Subsystem for Linux), you can share configurations:

```bash
# In WSL
ln -s /mnt/c/Users/YourName/dotfiles/git/.gitconfig ~/.gitconfig
ln -s /mnt/c/Users/YourName/dotfiles/bat ~/.config/bat
ln -s /mnt/c/Users/YourName/dotfiles/direnv ~/.config/direnv

# Or stow directly from the Windows path
cd /mnt/c/Users/YourName/dotfiles
stow -v git bat direnv
```

For zsh users in WSL, the main branch has zsh configurations.

## Customization

### Adding Aliases
Edit `bash/.config/bash/modules/aliases.bash` to add your own aliases.

### Adding Functions
Create new files in `bash/.config/bash/functions/` for custom shell functions.

### Installing More Packages
```bash
# Search for packages
scoop search <package-name>

# Install packages
scoop install <package-name>

# Update all packages
scoop update *
```

## Notes

- Git Bash provides a Unix-like environment on Windows
- Most Unix tools and commands work the same as on Linux/macOS
- Administrator privileges required for creating symlinks (unless Developer Mode is enabled)
- Scoop keeps packages isolated and easy to uninstall

## Troubleshooting

### Stow Conflicts
Remove existing config files before stowing:
```bash
rm ~/.bashrc ~/.bash_profile
stow -v bash
```

### Scoop Not Found
Ensure you've installed Scoop and restarted Git Bash. Add to PATH manually if needed:
```bash
export PATH="$HOME/scoop/shims:$PATH"
```

### Permission Denied
Some operations require running Git Bash as Administrator, or enable Developer Mode in Windows Settings:
- Settings → Update & Security → For Developers → Developer Mode

### Symlinks Not Working
Enable Developer Mode (above) or run Git Bash as Administrator when using `stow`.

### Command Not Found After Install
Restart Git Bash to refresh the PATH, or source your profile:
```bash
source ~/.bashrc
```

## Branches

- `main`: macOS setup with zsh and Homebrew
- `linux-ubuntu`: Ubuntu/Debian setup
- `windows`: This branch - Windows setup with Git Bash and Scoop
