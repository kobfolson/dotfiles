# dotfiles

Personal Ubuntu/Linux dotfiles using XDG Base Directory specification and GNU Stow.

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url> ~/Code/github.com/kobfolson/dotfiles
cd ~/Code/github.com/kobfolson/dotfiles

# Switch to linux-ubuntu branch
git checkout linux-ubuntu

# Run full setup
make all
```

## What's Included

This dotfiles configuration includes:

### Core Configuration
- **alacritty** - GPU-accelerated terminal emulator
- **bat** - Syntax-highlighted file viewer
- **direnv** - Directory-based environment switcher
- **git** - Version control configuration
- **mpv** - Video player configuration
- **npm** - Node.js package manager (XDG compliant)
- **tmux** - Terminal multiplexer
- **wget** - Download utility (XDG compliant)
- **zsh** - Shell configuration with modules and plugins

### Modern CLI Tools (via zinit)
- **gh** - GitHub CLI
- **glab** - GitLab CLI
- **eza** - Modern ls replacement
- **jq** - JSON processor
- **fzf** - Fuzzy finder

### Python Tools (via zinit + uv)
- **uv** - Fast Python package manager
- **ruff** - Fast Python linter & formatter
- **mypy** - Static type checker (via uv)
- **poetry** - Dependency management (via uv)

### DevOps & Cloud Tools (via zinit)
- **terraform** - Infrastructure as Code
- **kubectl** - Kubernetes CLI
- **helm** - Kubernetes package manager
- **aws** - AWS CLI v2

## Installation

### Prerequisites

- Ubuntu 20.04+ or Debian-based Linux distribution
- `sudo` access
- `git` installed: `sudo apt install git`

### Step-by-Step

1. **Update system and install packages**
   ```bash
   make update_system
   make install_packages
   ```

2. **Stow dotfiles** (create symlinks)
   ```bash
   make stow_dirs
   ```

3. **Setup anyenv** (optional)
   ```bash
   make setup_anyenv
   ```

4. **System configuration** (create directories, set zsh as default)
   ```bash
   make system
   ```

5. **Log out and back in**, then start zsh to install zinit plugins (automatic)

6. **Install Python dev tools** (after zsh/zinit setup)
   ```bash
   make py_tools
   ```

Or run everything at once:
```bash
make all
# Then log out/in, start zsh, and run: make py_tools
```

### Verify Installation

After setup and starting zsh:
```bash
# Check versions of installed tools
gh --version
glab --version
terraform version
kubectl version --client
helm version
aws --version
uv --version
ruff --version

# Test tab completion (press TAB after typing)
terraform <TAB>
kubectl <TAB>
helm <TAB>
aws <TAB>
```

## XDG Compliance

These dotfiles follow the XDG Base Directory specification:

- `XDG_CONFIG_HOME` → `~/.config` (configurations)
- `XDG_DATA_HOME` → `~/.local/share` (data files)
- `XDG_CACHE_HOME` → `~/.cache` (cache files)
- `XDG_STATE_HOME` → `~/.local/state` (state/logs/history)

### XDG Environment Variables

The following applications are configured to use XDG directories:

- Cargo/Rustup
- NPM
- Docker
- AWS CLI → `~/.config/aws/`
- Gradle
- Jupyter/IPython
- Python/PostgreSQL history
- Less history
- Wget
- Gem

**Zinit-managed tools** install to:
- Binaries: `~/.local/share/zinit/polaris/bin/`
- Completions: `~/.cache/zsh/compdump`

See `zsh/.config/zsh/modules/env.zsh` for all XDG configurations.

## Directory Structure

```
dotfiles/
├── alacritty/      # Terminal emulator config
├── bat/            # Syntax highlighting config
├── direnv/         # Environment switcher
├── git/            # Git configuration
├── mpv/            # Video player config
├── npm/            # NPM XDG config
├── tmux/           # Terminal multiplexer config
├── wget/           # Wget XDG config
├── zsh/            # Shell configuration
│   ├── .zshenv     # Environment variables (loaded first)
│   └── .config/zsh/
│       ├── .zshrc          # Main config file
│       ├── modules/        # Modular configuration
│       ├── functions/      # Custom shell functions
│       └── widgets/        # Custom ZLE widgets
├── packages.txt    # APT packages list
└── Makefile        # Installation automation
```

## Key Features

### Zsh Configuration

- Modular setup (aliases, completions, history, etc.)
- Zinit plugin manager (auto-installs)
- Powerlevel10k theme
- Fuzzy finding (fzf)
- Git integration
- 30+ custom functions

### Tmux

- Prefix: `` ` `` (backtick)
- Mouse support
- Auto-install TPM and plugins
- Session persistence (tmux-resurrect/continuum)

### Git

- SSH signing via 1Password
- diff-so-fancy for prettier diffs
- GPG commit signing
- Default branch: main

### Version Control CLIs

Modern Git hosting platform CLIs installed via zinit:

**GitHub CLI (`gh`):**
```bash
gh repo clone owner/repo      # Clone repository
gh pr create                  # Create pull request
gh pr list                    # List pull requests
gh issue list                 # List issues
gh auth login                 # Authenticate with GitHub
```

**GitLab CLI (`glab`):**
```bash
glab repo clone group/project # Clone repository
glab mr create                # Create merge request
glab mr list                  # List merge requests
glab issue list               # List issues
glab auth login               # Authenticate with GitLab
```

Both tools auto-complete in zsh and support similar commands for seamless workflow between platforms.

### DevOps & Cloud Tools

Modern infrastructure and cloud tools installed via zinit:

**Terraform** - Infrastructure as Code:
```bash
terraform init                # Initialize working directory
terraform plan                # Preview changes
terraform apply               # Apply changes
terraform destroy             # Destroy infrastructure
terraform fmt                 # Format configuration files
terraform validate            # Validate configuration
```

**kubectl** - Kubernetes CLI:
```bash
kubectl get pods              # List pods
kubectl get svc               # List services
kubectl apply -f deploy.yaml  # Apply configuration
kubectl logs pod-name         # View logs
kubectl exec -it pod-name bash # Shell into pod
kubectl config get-contexts   # List contexts
kubectl config use-context ctx # Switch context
```

**Helm** - Kubernetes Package Manager:
```bash
helm repo add stable https://charts.helm.sh/stable  # Add repo
helm repo update              # Update repos
helm search repo nginx        # Search for charts
helm install my-app stable/nginx  # Install chart
helm list                     # List releases
helm upgrade my-app stable/nginx  # Upgrade release
helm uninstall my-app         # Uninstall release
```

**AWS CLI** - Amazon Web Services:
```bash
aws configure                 # Configure credentials
aws s3 ls                     # List S3 buckets
aws ec2 describe-instances    # List EC2 instances
aws eks list-clusters         # List EKS clusters
aws lambda list-functions     # List Lambda functions
aws sts get-caller-identity   # Check current identity
```

**Configuration Notes:**
- AWS credentials: Configure via `aws configure` or `~/.config/aws/` (XDG compliant)
- kubectl config: `~/.kube/config` or `$KUBECONFIG`
- Terraform: Uses current directory for state files
- All tools include tab completion in zsh

### Python Development

Modern Python tooling installed via zinit + uv:

**Installed via zinit (automatic):**
- `uv` - Fast Python package installer (replaces pip, pip-tools, pipx)
- `ruff` - Fast linter & formatter (replaces black, flake8, isort)

**Installed via uv tool (run `make py_tools`):**
- `mypy` - Static type checker
- `poetry` - Dependency management

**Usage:**
```bash
# Format and lint code
ruff check .           # Check for issues
ruff check --fix .     # Auto-fix issues
ruff format .          # Format code (like black)

# Type checking
mypy your_code.py

# Package management
uv pip install package       # Install package
uv tool install package      # Install CLI tool globally
poetry new myproject         # Create new project with poetry
```

## Documentation

- **README.md** (this file) - Complete setup and usage guide
- **Makefile** - View available make targets
- **packages.txt** - List of APT packages and zinit-managed tools
- Individual config files are well-commented

## Updating

### Update system packages
```bash
sudo apt update && sudo apt upgrade -y
```

### Update packages list
Edit `packages.txt` and run:
```bash
make install_packages
```

### Update Zinit and all tools (gh, glab, terraform, kubectl, helm, aws, etc.)
```bash
zinit self-update          # Update zinit itself
zinit update --all         # Update all plugins and tools
```

### Update specific tools
```bash
zinit update astral-sh/ruff              # Update ruff
zinit update hashicorp/terraform         # Update terraform
zinit update kubernetes/kubectl          # Update kubectl
```

### Re-stow after editing
```bash
make stow_dirs
```

## Notes

- Designed for Ubuntu/Debian-based Linux distributions
- Uses standard Linux paths (`/usr/bin`, `/usr/local/bin`)
- Git config includes 1Password SSH signing (optional - adjust if not using 1Password)
- Docker requires adding user to docker group: `sudo usermod -aG docker $USER`
- Some packages may have different names on different distributions

## License

Personal dotfiles - use at your own discretion.
