# ⌨️ My Key Bindings

**Leader key:** Space

## 🔵 Navigation & File Management

### File Explorer
- leader+pv - Open Netrw file explorer

### Telescope
- leader+pf - Find files
- Ctrl+p - Git files
- leader+ps - Live grep (search in files)
- leader+pb - Find buffers

### Harpoon (Quick Navigation)
- leader+a - Add file to harpoon
- Ctrl+e - Toggle harpoon telescope menu
- Ctrl+h - Jump to harpoon file 1
- Ctrl+t - Jump to harpoon file 2
- Ctrl+n - Jump to harpoon file 3
- Ctrl+s - Jump to harpoon file 4
- Ctrl+Shift+p - Previous harpoon file
- Ctrl+Shift+n - Next harpoon file

## 🟢 LSP (Language Server)

### Navigation
- gD - Go to declaration
- gd - Go to definition
- gi - Go to implementation
- K - Hover documentation
- Ctrl+k - Signature help
- leader+D - Type definition

### Code Actions
- leader+rn - Rename
- leader+ca - Code actions (normal & visual)
- leader+f - Format file
- leader+e - Show diagnostics float

### Workspace
- leader+wa - Add workspace folder
- leader+wr - Remove workspace folder
- leader+wl - List workspace folders

## ☕ Java Specific (nvim-jdtls)

### Refactoring
- Ctrl+o - Organize imports
- leader+ev - Extract variable
- leader+ec - Extract constant
- leader+em (visual) - Extract method

### Testing & Debugging
- leader+vc - Test class (DAP)
- leader+vm - Test nearest method (DAP)

## 🐛 Debugging (nvim-dap)

### Breakpoints
- leader+bb - Toggle breakpoint
- leader+bc - Conditional breakpoint
- leader+bl - Log point
- leader+br - Clear all breakpoints
- leader+ba - List breakpoints (telescope)

### Debug Controls
- leader+dc - Continue
- leader+dj - Step over
- leader+dk - Step into
- leader+do - Step out
- leader+dd - Disconnect
- leader+dt - Terminate
- leader+dr - Toggle REPL
- leader+dl - Run last

### Debug Info
- leader+di - Hover variables
- leader+d? - Show scopes
- leader+df - List frames (telescope)
- leader+dh - List commands (telescope)

## 🎨 Editing

### Moving Lines
- J (visual) - Move selected lines DOWN
- K (visual) - Move selected lines UP
- J (normal) - Join lines (keep cursor position)

### Duplicating
- leader+j - Duplicate line/selection below
- leader+k - Duplicate line/selection above

### Clipboard
- leader+y - Yank to system clipboard
- leader+Y - Yank whole line to system clipboard
- leader+d - Delete to black hole register (doesn't affect clipboard)

### Formatting
- =ap - Format paragraph
- leader+f - Format file (LSP)

### Search & Replace
- leader+s - Search/replace word under cursor
- n - Next search result (centered)
- N - Previous search result (centered)

### Scrolling (Centered)
- Ctrl+d - Scroll down (centered)
- Ctrl+u - Scroll up (centered)

## 🔧 Utilities

### File Path
- leader+yf - Yank file path to clipboard

### Custom Functions
- leader+cc - Custom function (check remap.lua)
- leader+cs - Custom function (check remap.lua)
- leader+cp - Custom function (check remap.lua)

## 🔴 Git (Fugitive)

- leader+gs - Git status

## 🟢 TMUX (Prefix = Ctrl+a)

### Sessions
- Ctrl+a 1 - Switch to session "maven"
- Ctrl+a 2 - Switch to session "code"
- Ctrl+a 3 - Switch to session "test"

### Panes (Vim-like)
- Ctrl+a h - Select left pane
- Ctrl+a j - Select down pane
- Ctrl+a k - Select up pane
- Ctrl+a l - Select right pane

### Split
- Ctrl+a | - Split horizontal
- Ctrl+a - - Split vertical

### Other
- Ctrl+a r - Reload config
- Ctrl+a I - Install TMUX plugins (capital i)

## 🟡 ZSH

### Vi-mode (Oh My Zsh plugin)
- Esc or Ctrl+[ - Normal mode
- i - Insert mode
- v - Visual mode

### Custom Aliases
- vim - Alias for nvim
- qtmux - Start TMUX with Amazon Q (60-40 split)

## 🔴 iTerm2

- Cmd+T - New tab
- Cmd+D - Split vertically
- Cmd+Shift+D - Split horizontally
- Cmd+[ / Cmd+] - Switch tabs
- Cmd+Option+Arrow - Switch panes
