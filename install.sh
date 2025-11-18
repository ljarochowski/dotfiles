#!/bin/bash

set -e

echo "🚀 Starting dotfiles installation..."

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    error "Unsupported OS: $OSTYPE"
    exit 1
fi

info "Detected OS: $OS"

# Check if Homebrew is installed (macOS)
if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
        warn "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        info "Homebrew already installed ✓"
    fi
fi

# Install dependencies
info "Installing dependencies..."

if [[ "$OS" == "macos" ]]; then
    # Core tools
    brew install neovim tmux zsh starship node openjdk@21 jq fzf ripgrep fd maven
    
    # Nerd Fonts
    info "Installing Nerd Fonts..."
    brew tap homebrew/cask-fonts
    
    # Install Nerd Fonts (including Terminess which you use!)
    fonts=(
        "font-terminess-ttf-nerd-font"
        "font-jetbrains-mono-nerd-font"
        "font-hack-nerd-font"
        "font-fira-code-nerd-font"
        "font-meslo-lg-nerd-font"
    )
    
    for font in "${fonts[@]}"; do
        if brew list --cask "$font" &>/dev/null; then
            info "$font already installed ✓"
        else
            info "Installing $font..."
            brew install --cask "$font" || warn "Failed to install $font"
        fi
    done
    
elif [[ "$OS" == "linux" ]]; then
    sudo apt-get update
    sudo apt-get install -y neovim tmux zsh curl git nodejs npm jq fzf ripgrep fd-find maven
    
    if ! command -v starship &> /dev/null; then
        curl -sS https://starship.rs/install.sh | sh
    fi
    
    # Nerd Fonts for Linux
    info "Installing Nerd Fonts..."
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    
    fonts_to_download=(
        "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Terminus/terminus-ttf-nerd-font/TerminessNerdFontMono-Regular.ttf"
        "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
    )
    
    for font_url in "${fonts_to_download[@]}"; do
        font_name=$(basename "$font_url")
        if [ ! -f "$font_name" ]; then
            info "Downloading $font_name..."
            curl -fLo "$font_name" "$font_url"
        fi
    done
    
    fc-cache -fv
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    info "Oh My Zsh already installed ✓"
fi

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    info "zsh-autosuggestions already installed ✓"
fi

# Install TMUX Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    info "Installing TMUX Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    info "TPM already installed ✓"
fi

# Create symlinks
info "Creating symlinks..."

backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

# Neovim
if [ -e "$HOME/.config/nvim" ]; then
    warn "Backing up existing Neovim config to $backup_dir"
    mv "$HOME/.config/nvim" "$backup_dir/"
fi
mkdir -p "$HOME/.config"
ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
info "Neovim config linked ✓"

# TMUX
if [ -e "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$backup_dir/"
fi
ln -sf "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
info "TMUX config linked ✓"

# ZSH
if [ -e "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$backup_dir/"
fi
ln -sf "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"
info "ZSH config linked ✓"

# Set ZSH as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    info "Setting ZSH as default shell..."
    chsh -s $(which zsh)
fi

# Neovim: Install plugins
info "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "Neovim plugin installation may need manual attention"

info ""
info "✨ Installation complete!"
info ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
info "📝 Next steps:"
info "  1. Restart your terminal or run: source ~/.zshrc"
info "  2. Configure iTerm2 font (see below)"
info "  3. Open Neovim - plugins will finish installing"
info "  4. In TMUX, press Ctrl+a then I (capital i) to install TMUX plugins"
if [[ "$OS" == "macos" ]]; then
    info "  5. Import iTerm2 profile from ~/dotfiles/iterm/profile.json"
    info "  6. Run ./setup-java.sh for Java development setup"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
info ""
info "🔤 iTerm2 Font Configuration:"
info "  Preferences → Profiles → Text → Font"
info "  Recommended: Terminess Nerd Font Mono, size 15 (your current setup)"
info "  Or choose: JetBrainsMono Nerd Font, Hack Nerd Font, FiraCode Nerd Font"
info ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
info "💡 Local overrides:"
info "  - ZSH: Create ~/.zshrc.local for machine-specific config"
info "  - Neovim: Create ~/.config/nvim/lua/local.lua for machine-specific config"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
info ""
info "🔑 Backups saved to: $backup_dir"
