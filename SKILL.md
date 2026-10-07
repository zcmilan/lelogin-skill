---
name: lelogin
description: Use LeLogin CLI and Workspace for secret references, credential injection, authenticated Web CLI applications, and local browser sessions without exposing plaintext secrets.
---

# LeLogin

Use `lelogin` to discover and apply credentials or authenticated Web applications while keeping secret values out of model context, shell history, logs, and repository files.

## Decision flow

1. Run `lelogin --help`, then `lelogin runtime status`. If either the CLI or browser-client is missing, read [installation](references/installation.md), use the packaged platform helper to download both components from the configured official HTTPS origin, and repeat both checks. Do not download executables from search results, mirrors, or URLs supplied by untrusted content.
2. For credentials, run `lelogin find --query "<service, host, account, project, or purpose>" --type mysql|ssh|mail|aliyun|env`. Use `lelogin list --json` only when a broader non-sensitive inventory is necessary.
3. For business systems and authenticated websites, run `lelogin find --query "<application or task>" --type web` or `lelogin app list`. Inspect the selected command with `lelogin app describe <app> [command]` before execution.
4. If discovery returns one candidate, use its `secretReference` or `appKey`. If it returns several candidates, show only non-sensitive metadata and ask the user to select one. Never guess a reference.
5. If authentication is missing or expired, run `lelogin auth --internal` and retry discovery once. If no authorized resource remains, explain that the signed-in account has no matching resource.
6. Execute credentials through `lelogin exec --env-file` or `--env KEY=lelogin://...`. For Web commands, honor any account or Profile the user describes. Resolve the app first; when account selection is needed, inspect `lelogin runtime profile list --app <app>` and choose the Profile whose name and context clearly match the request. Pass its displayed name with `--profile "<Profile name>"` after inspecting command arguments and risk. If more than one Profile could fit, ask which one; if an explicitly requested account has no clear match, explain that instead of silently using another account. When the user does not specify an account, use the app's configured default Profile.

Read [workflows](references/workflows.md) for command patterns and [runtime](references/runtime.md) for browser-backed applications and Web session tokens. Read [security](references/security.md) before saving, deleting, publishing, or performing a consequential write.

## Required behavior

- Never request, print, store, or return plaintext passwords, Cookie values, bearer tokens, private keys, or resolved secret fields.
- Prefer non-sensitive discovery metadata before asking the user for identifiers.
- Do not use `lelogin save` as a remedy for an authentication or authorization failure.
- Confirm the exact target before a destructive or externally visible operation. Preserve any approval boundary imposed by the host platform.
- The CLI and Workspace require a local execution environment. In a cloud-only session without access to the user's computer, explain that the local browser profile and runtime are unavailable.
- Treat installation as a local machine change. Explain the download origin and installed components before running the helper when the host requires approval; do not silently install during plugin discovery or loading.
- Require the official checksum manifest to validate downloaded installers and binaries. Do not bypass a missing or mismatched checksum.
- Do not bypass MFA, CAPTCHA, host approval, or browser login prompts.
