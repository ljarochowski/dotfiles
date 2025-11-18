# 🚀 Moje Dotfiles

Setup środowiska deweloperskiego (macOS/Linux) - Neovim, TMUX, ZSH.

## 📦 Co zawiera?

- **Neovim** - PDE dla Java/Python/Lua + LSP + DAP
- **TMUX** - Terminal multiplexer z rose-pine theme
- **ZSH** - Oh My Zsh + Starship prompt + zsh-autosuggestions
- **iTerm2** - Custom color profile
- **Nerd Fonts** - Terminess, JetBrains Mono, Hack, FiraCode, Meslo

## 🛠️ Instalacja (nowy komputer)

### Krok 1: Wymagania wstępne (macOS)

```bash
# Homebrew (jeśli nie masz)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git
brew install git
```

### Krok 2: Sklonuj repo

```bash
git clone https://github.com/TWOJ_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Krok 3: Uruchom instalację

```bash
chmod +x install.sh
./install.sh
```

**Co instaluje install.sh:**
- Neovim, TMUX, ZSH, Starship
- Node.js, OpenJDK 21, Maven
- Nerd Fonts (Terminess, JetBrains Mono, etc.)
- Oh My Zsh + plugins
- TMUX Plugin Manager
- Tworzy symlinki do konfigów

### Krok 4 (opcjonalnie): Java Development

Jeśli pracujesz z Javą:

```bash
chmod +x setup-java.sh
./setup-java.sh
```

**Co instaluje setup-java.sh:**
- java-debug (Microsoft Debug Adapter)
- vscode-java-test (Test Runner)
- Lombok support
- Google Java Style formatter

## 📝 Po instalacji

1. **Restart terminala** lub source ~/.zshrc
2. **iTerm2 Font**: Preferences → Profiles → Text → Font → **Terminess Nerd Font Mono**, size **15**
3. **iTerm2 Colors**: Zaimportuj profil z iterm/profile.json
4. **Neovim**: Otwórz nvim - pluginy dokończą instalację
5. **TMUX**: Naciśnij Ctrl+a + I (duże i) aby zainstalować pluginy TMUX

## 🔧 Mason packages

Mason zainstaluje automatycznie przy pierwszym uruchomieniu Neovim:
- jdtls (Java LSP)
- lua-language-server
- pyright (Python)
- prettier, google-java-format
- i inne...

## ⌨️ Kluczowe skróty

Zobacz pełną listę w [KEYBINDINGS.md](KEYBINDINGS.md)

**Quick reference:**
- Leader key w Neovim: Space
- TMUX prefix: Ctrl+a
- vim alias: nvim

## 🎨 Theme

- **Terminal**: iTerm2 z custom colors
- **Neovim**: Rose Pine / Tokyo Night
- **TMUX**: Rose Pine
- **Prompt**: Starship
- **Font**: Terminess Nerd Font Mono 15pt

## 📂 Struktura

```
dotfiles/
├── nvim/              # Neovim config (cały katalog)
├── tmux/
│   └── tmux.conf     # TMUX config (bez kropki w repo!)
├── zsh/
│   └── zshrc         # ZSH config (bez kropki w repo!)
├── iterm/
│   └── profile.json  # iTerm2 color profile
├── java-tools/       # Java dev tools (tworzone przez setup-java.sh)
├── install.sh        # Główny skrypt instalacyjny
├── setup-java.sh     # Java setup (opcjonalny)
└── README.md
```

## 🔄 Aktualizacja dotfiles

```bash
cd ~/dotfiles
git pull
./install.sh  # Re-run jeśli zmieniły się dependencies
```

## 💡 Lokalne override'y (nie commitowane)

Możesz tworzyć lokalne customizacje które NIE trafiają do repo:

**ZSH local config:**
```bash
# ~/.zshrc.local (NIE w repo, gitignore)
alias work="cd ~/work-projects"
export COMPANY_API_KEY="secret"
```

**Neovim local config:**
```bash
-- ~/.config/nvim/lua/local.lua (NIE w repo, gitignore)
vim.opt.colorcolumn = "100"  -- tylko na tym kompie
```

## 🔤 Fonts

Instalowane automatycznie:
- **Terminess Nerd Font Mono** (używana głównie)
- JetBrains Mono Nerd Font
- Hack Nerd Font
- FiraCode Nerd Font
- Meslo LG Nerd Font

## ☕ Java Development

Pełna konfiguracja dla Java (nvim-jdtls + DAP):
1. Uruchom ./setup-java.sh
2. Wszystko trafia do ~/dotfiles/java-tools/
3. ftplugin/java.lua automatycznie używa tych ścieżek

## 🐛 Troubleshooting

**Pluginy Neovim się nie zainstalowały:**
```bash
nvim
:Lazy sync
```

**TMUX pluginy nie działają:**
W TMUX: Ctrl+a + I (duże i)

**Mason packages nie zainstalowały się:**
```bash
nvim
:Mason
# Ręcznie zainstaluj potrzebne
```

**Starship nie pokazuje ikon:**
Upewnij się że używasz Nerd Font w iTerm2

## 📜 License

MIT - rób co chcesz
