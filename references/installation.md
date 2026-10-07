# Installation

The plugin contains instructions and small helper scripts, not platform binaries. On first local use, the helper downloads LeLogin CLI and browser-client from the configured official HTTPS origin `https://lelogin.nationauth.cn/lelogin/cmd`. It validates the installer against `SHA256SUMS`; the installer validates the CLI and browser-client before replacing an existing installation.

## macOS and Linux

```bash
bash ./scripts/install-lelogin.sh
export PATH="${LELOGIN_INSTALL_DIR:-$HOME/.local/bin}:$PATH"
lelogin --help
lelogin runtime status
```

## Windows Command Prompt

```bat
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-lelogin.ps1
```

The default destination is `$HOME/.local/bin` on macOS/Linux and `%USERPROFILE%\.local\bin` on Windows. The installer places the `browser-client` directory beside the CLI and creates the appropriate desktop entry unless `LELOGIN_SKIP_SHORTCUTS=1` is set.

The helper verifies `lelogin --help` and `lelogin runtime status` using the installed CLI. On Windows, open a new terminal after installation to load the updated user PATH before running `lelogin auth --internal` or other commands.

After installation, use `lelogin auth --internal`. Do not ask the user to paste a token into the conversation.

## Uninstall

Use `bash ./scripts/uninstall-lelogin.sh` on macOS/Linux or `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\uninstall-lelogin.ps1` on Windows. The default uninstall removes installed programs and launchers while preserving user configuration, browser profiles, and authentication data. Use `--purge` or `-Purge` only when the user explicitly asks to erase those retained data.
