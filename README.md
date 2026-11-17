# zed-config

Мой конфиг [Zed](https://zed.dev) для C++ (clangd, xmake) на Windows.

| Файл | Что внутри |
|---|---|
| `settings.json` | основные настройки: тема, шрифт, clangd semantic tokens, диагностика, AI выключен, авто-установка расширений |
| `keymap.json` | свои хоткеи |
| `themes/ember-v3.json` | тема **Ember Dark v3**: тёмная, контрастная, приглушённые литералы и комментарии |
| `snippets/c++.json` | 30 сниппетов для C++ (`println`, `class`, `class5`, `struct`…) |
| `sync.ps1` | синхронизация в одну команду |

Конфиг Zed на Windows лежит в `%APPDATA%\Zed`. Эта папка и есть репо: `.gitignore` пропускает только файлы выше, всё остальное, что Zed там хранит, остаётся локальным.

## Поставить на ещё один свой ПК

Закрой Zed и выполни в PowerShell:

```powershell
cd "$env:APPDATA\Zed"
Remove-Item themes\ember.json, themes\ember-v2.json -ErrorAction SilentlyContinue
git init -b main
git remote add origin https://github.com/cah9xddd/zed-config.git
git fetch origin
git reset --hard origin/main
```

`reset --hard` заменит локальные `settings.json`, `keymap.json` и остальные файлы версией из репо. Потом запусти Zed: расширения из `auto_install_extensions` поставятся сами.

## Синхронизация

```powershell
powershell -ExecutionPolicy Bypass -File "$env:APPDATA\Zed\sync.ps1"
```

Скрипт коммитит локальные изменения, забирает изменения с GitHub (`pull --rebase`) и пушит. Настройки Zed подхватывает сразу, тему — только после перезапуска.

## Просто взять себе (без git)

Скопируй `settings.json`, `keymap.json`, `themes\` и `snippets\` в `%APPDATA%\Zed` (на macOS и Linux — в `~/.config/zed`) и перезапусти Zed. Если у тебя уже есть свой `settings.json`, перенеси из моего только нужные куски: тему, `global_lsp_settings` и `diagnostics`.

## Шрифт

В настройках стоит **MartianMono Nerd Font**. Его нет в Windows по умолчанию: скачай Martian Mono с [nerdfonts.com](https://www.nerdfonts.com/font-downloads), выдели все `.ttf` → ПКМ → «Установить» и перезапусти Zed. Или поменяй `buffer_font_family` на свой шрифт.
