# zed-config

My [Zed](https://zed.dev) setup for C++ (clangd, xmake). Works on Windows, macOS and Linux.

| File | What's inside |
|---|---|
| `settings.json` | main settings: theme, font, clangd semantic tokens, diagnostics, AI disabled, auto-installed extensions |
| `keymap.json` | custom key bindings (`alt-enter` for code actions, like JetBrains) |
| `themes/ember-v3.json` | **Ember Dark v3**: a dark, high-contrast theme with muted literals and comments |
| `snippets/c++.json` | 30 C++ snippets (`println`, `class`, `class5`, `struct`, ...) |
| `sync.sh` | one-command sync between machines |

## Where Zed keeps its config

| OS | Folder |
|---|---|
| Windows | `%APPDATA%\Zed` |
| macOS, Linux | `~/.config/zed` (or `$XDG_CONFIG_HOME/zed`) |
| Linux, Flatpak | `~/.var/app/dev.zed.Zed/config/zed` |

## Just take it

Close Zed, copy `settings.json`, `keymap.json`, `themes/` and `snippets/` into your config folder, and start Zed again.

If you already have your own `settings.json`, back it up first, or copy over only the parts you want: `theme`, `global_lsp_settings` (needed for the theme's const colors) and `diagnostics`. The theme alone works too: drop `themes/ember-v3.json` into your `themes/` folder and pick **Ember Dark v3** in the theme selector (`ctrl-k ctrl-t`, or `cmd-k cmd-t` on macOS).

Some settings are personal: `disable_ai`, the panel layout, and the MSVC header path in `file_types` (Windows only, harmless elsewhere). Change them to taste.

## Keep it in sync with git

The config folder itself becomes the repo. `.gitignore` lets through only the files above, so everything else Zed stores there stays local. Fork the repo first if you want to push your own changes.

Close Zed and run this in a terminal (on Windows, use Git Bash, which comes with [Git for Windows](https://git-scm.com/download/win)):

```bash
# pick your config folder:
ZED_DIR="$HOME/.config/zed"     # macOS, Linux
# ZED_DIR="$APPDATA/Zed"        # Windows (Git Bash)

mkdir -p "$ZED_DIR" && cd "$ZED_DIR"
git init -b main
git remote add origin https://github.com/cah9xddd/zed-config.git
git fetch origin
git reset --hard origin/main
```

`reset --hard` replaces your local `settings.json`, `keymap.json` and the other tracked files with the versions from the repo. Then start Zed: the extensions listed in `auto_install_extensions` install themselves.

To sync later, run:

```bash
"$ZED_DIR/sync.sh" "what I changed"
```

On Windows you can also just double-click `sync.sh`. The script commits local changes, pulls (`pull --rebase`) and pushes. Zed applies settings changes immediately, but reads themes only at startup, so restart Zed after a theme change.

## Font

The settings use **MartianMono Nerd Font**. Install it, or set `buffer_font_family` to a font you already have.

- **macOS:** `brew install --cask font-martian-mono-nerd-font`
- **Arch Linux:** `sudo pacman -S ttf-martian-mono-nerd`
- **Other Linux:**
  ```bash
  mkdir -p ~/.local/share/fonts/MartianMono && cd ~/.local/share/fonts/MartianMono
  curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/MartianMono.zip
  unzip -o MartianMono.zip && rm MartianMono.zip && fc-cache -f
  ```
- **Windows:** download [MartianMono.zip](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/MartianMono.zip), extract it, select all the `.ttf` files → right-click → Install.

Restart Zed after installing the font.
