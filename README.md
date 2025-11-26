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
The `setup.sh` script will automatically add buckets and install packages.
If you want to install manually:
```bash
# In Git Bash
scoop bucket add extras
scoop bucket add nerd-fonts

# Install tools
scoop install gh ghq fd bat ripgrep fzf wget neovim delta starship shellcheck eza btop
scoop install python lazydocker direnv

# Note: Python tools (ruff, mypy) require uv to be installed separately
# Install uv: https://docs.astral.sh/uv/getting-started/installation/
# The setup script will prompt to install Python tools via uv
```

### 2. Reload Git Bash Profile
```bash
# The .bashrc and .bash_profile will be symlinked by the setup script
# Reload your profile
source ~/.bashrc
```

## What's Included

### Package Manager - Scoop
Installs essential development tools and utilities:
- **CLI Tools**: gh, ghq, fd, bat, ripgrep, fzf, neovim, wget, delta, starship, shellcheck, eza, btop
- **Development**: Python, lazydocker, direnv
- **Python Tools (Optional)**: ruff (linter/formatter), mypy (type checker) - installed via uv (requires uv installed separately)
- **Fonts**: JetBrainsMono Nerd Font, CascadiaCode Nerd Font
- **Note**: Git for Windows (prerequisite) is used instead of Scoop's git package
- **Note**: Configuration files are symlinked using native Git Bash symlinks (no GNU Stow needed)

### Shell Configuration - Bash
- Custom `.bashrc` with Git Bash optimizations
- **XDG Base Directory**: Configured to use `/c/dev/.config` by default
- Modular configuration (aliases, functions, paths)
- Modern tool aliases (eza for ls, bat for cat, nvim for vim, btop for top)
- Git shortcuts and Docker aliases (using `docker compose` not legacy `docker-compose`)
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
├── setup.sh            # Automated setup script (includes package list)
└── README.md           # This file
```

## WSL Integration

If you also use WSL (Windows Subsystem for Linux), you can share configurations:

```bash
# In WSL, manually create symlinks to share configurations
ln -s /mnt/c/Users/YourName/dotfiles/git/.config/git ~/.config/git
ln -s /mnt/c/Users/YourName/dotfiles/bat/.config/bat ~/.config/bat
ln -s /mnt/c/Users/YourName/dotfiles/direnv/.config/direnv ~/.config/direnv
ln -s /mnt/c/Users/YourName/dotfiles/bash/.bashrc ~/.bashrc
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

### Proxy Authentication Required (407)
If you're behind a corporate proxy:
```bash
# Set proxy for Scoop
scoop config proxy http://username:password@proxy:port

# Or if using NTLM auth
scoop config proxy http://proxy:port
```

### Package Not Found or Invalid
Some package names may differ. Search for the correct name:
```bash
scoop search <package-name>

# Example: if 'google-chrome' fails, try:
scoop search chrome
```

### Symlink Conflicts
If you have existing config files, the setup script will skip them. To replace them:
```bash
# Backup existing configs
mv ~/.bashrc ~/.bashrc.backup
mv ~/.bash_profile ~/.bash_profile.backup

# Re-run the setup script
./setup.sh
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
Enable Developer Mode (above) or run Git Bash as Administrator when running the setup script to create symlinks.

### Command Not Found After Install
Restart Git Bash to refresh the PATH, or source your profile:
```bash
source ~/.bashrc
```

## Branches

- `main`: macOS setup with zsh and Homebrew
- `linux-ubuntu`: Ubuntu/Debian setup
- `windows`: This branch - Windows setup with Git Bash and Scoop
