# Синхронизация конфига Zed: отправить свои изменения и забрать чужие.
# Запуск:  powershell -ExecutionPolicy Bypass -File "$env:APPDATA\Zed\sync.ps1"
#          (можно с сообщением: ... sync.ps1 -m "поменял цвет функций")
param([string]$m = "Update Zed config from $env:COMPUTERNAME")

Set-Location $PSScriptRoot

git.exe add -A
git.exe diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    git.exe commit -m $m
    if ($LASTEXITCODE -ne 0) { Write-Host "Не получилось закоммитить" -ForegroundColor Red; exit 1 }
}

git.exe pull --rebase origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Конфликт при pull: поправь файлы, потом 'git rebase --continue' и запусти снова" -ForegroundColor Red
    exit 1
}

git.exe push origin HEAD:main
if ($LASTEXITCODE -ne 0) { Write-Host "Push не прошёл" -ForegroundColor Red; exit 1 }

Write-Host "Синхронизировано. Если менялась тема — перезапусти Zed (темы читаются только при старте)." -ForegroundColor Green
