@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $p=Join-Path $env:USERPROFILE '.config\opencode\opencode.json'; irm 'https://raw.githubusercontent.com/skodalaura20/ibrahim-skills/main/opencode-config-8mcps.json' -OutFile $p"
echo.
echo [OK] Full config (8 MCPs) lag gaya! OpenCode restart karo.
pause
