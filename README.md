# 🚀 My Dotfiles

Development environment setup (macOS/Linux) - Neovim, TMUX, ZSH.

## 📦 What's included?

- **Neovim** - PDE for Java/Python/Lua + LSP + DAP
- **TMUX** - Terminal multiplexer with rose-pine theme
- **ZSH** - Oh My Zsh + Starship prompt + zsh-autosuggestions
- **iTerm2** - Custom color profile
- **Nerd Fonts** - Terminess, JetBrains Mono, Hack, FiraCode, Meslo

## 🛠️ Installation (new machine)

### Step 1: Prerequisites (macOS)

```bash
# Homebrew (if you don't have it)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git
brew install git
```

### Step 2: Clone the repo

```bash
git clone https://github.com/ljarochowski/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Step 3: Run installation

```bash
chmod +x install.sh
./install.sh
```

**What install.sh does:**
- Installs Neovim, TMUX, ZSH, Starship
- Installs Node.js, OpenJDK 21, Maven
- Installs Nerd Fonts (Terminess, JetBrains Mono, etc.)
- Installs Oh My Zsh + plugins
- Installs TMUX Plugin Manager
- Creates symlinks to configs

### Step 4 (optional): Java Development

If you work with Java:

```bash
chmod +x setup-java.sh
./setup-java.sh
```

**What setup-java.sh does:**
- Installs java-debug (Microsoft Debug Adapter)
- Installs vscode-java-test (Test Runner)
- Adds Lombok support
- Adds Google Java Style formatter

## 📝 Post-installation

1. **Restart terminal** or run: source ~/.zshrc
2. **iTerm2 Font**: Preferences → Profiles → Text → Font → **Terminess Nerd Font Mono**, size **15**
3. **iTerm2 Colors**: Import profile from iterm/profile.json
4. **Neovim**: Open nvim - plugins will finish installing
5. **TMUX**: Press Ctrl+a + I (capital i) to install TMUX plugins

## 🔧 Mason packages

Mason will install automatically on first Neovim run:
- jdtls (Java LSP)
- lua-language-server
- pyright (Python)
- prettier, google-java-format
- and more...

## ⌨️ Key bindings

See full list in [KEYBINDINGS.md](KEYBINDINGS.md)

**Quick reference:**
- Leader key in Neovim: Space
- TMUX prefix: Ctrl+a
- vim alias: nvim

## 🎨 Theme

- **Terminal**: iTerm2 with custom colors
- **Neovim**: Rose Pine / Tokyo Night
- **TMUX**: Rose Pine
- **Prompt**: Starship
- **Font**: Terminess Nerd Font Mono 15pt

## 📂 Structure

```
dotfiles/
├── nvim/              # Neovim config (entire directory)
├── tmux/
│   └── tmux.conf     # TMUX config (no dot in repo!)
├── zsh/
│   └── zshrc         # ZSH config (no dot in repo!)
├── iterm/
│   └── profile.json  # iTerm2 color profile
├── java-tools/       # Java dev tools (created by setup-java.sh)
├── install.sh        # Main installation script
├── setup-java.sh     # Java setup (optional)
└── README.md
```

## 🔄 Updating dotfiles

```bash
cd ~/dotfiles
git pull
./install.sh  # Re-run if dependencies changed
```

## 💡 Local overrides (not committed)

You can create local customizations that DON'T go into the repo:

**ZSH local config:**
```bash
# ~/.zshrc.local (NOT in repo, gitignored)
alias work="cd ~/work-projects"
export COMPANY_API_KEY="secret"
```

**Neovim local config:**
```bash
-- ~/.config/nvim/lua/local.lua (NOT in repo, gitignored)
vim.opt.colorcolumn = "100"  -- only on this machine
```

## 🔤 Fonts

Installed automatically:
- **Terminess Nerd Font Mono** (primary font)
- JetBrains Mono Nerd Font
- Hack Nerd Font
- FiraCode Nerd Font
- Meslo LG Nerd Font

## ☕ Java Development

Full Java configuration (nvim-jdtls + DAP):
1. Run ./setup-java.sh
2. Everything goes to ~/dotfiles/java-tools/
3. ftplugin/java.lua automatically uses these paths

## 🐛 Troubleshooting

**Neovim plugins didn't install:**
```bash
nvim
:Lazy sync
```

**TMUX plugins not working:**
In TMUX: Ctrl+a + I (capital i)

**Mason packages didn't install:**
```bash
nvim
:Mason
# Manually install required packages
```

**Starship not showing icons:**
Make sure you're using a Nerd Font in iTerm2

## 📜 License

MIT - do whatever you want
