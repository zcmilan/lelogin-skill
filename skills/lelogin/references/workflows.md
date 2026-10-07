# CLI workflows

## Credential discovery and execution

```bash
lelogin find --query "production database" --type mysql
lelogin exec --env-file ./service.env -- ./start-service
```

An env file contains ordinary configuration plus `lelogin://...` references. It must not contain resolved secret values.

## Web applications

```bash
lelogin app list
lelogin app describe confluence
lelogin app describe confluence search
lelogin app login confluence
lelogin app exec confluence search --arg query=test --arg limit=5
```

Read the application summary first, then the selected command. Use `--full` or `--json` only for debugging or machine processing because they consume more context.

## Resource management

Use `lelogin save` and `lelogin delete` only when the user explicitly asks to create, update, or remove a credential. Inspect the current command help before acting because management flags can change between CLI versions.

## Database and SSH connection fields

New structured credentials support `lelogin://group/item#host`, `#port`, `#username`,
`#databaseType` / `#authType`, and `#password` or `#privateKey`. The unqualified
reference (or `#credential`) keeps the original scalar value. Missing fields fail
explicitly; never guess whether a legacy SSH value is a password or private key.

Use `lelogin exec --secret-bundle lelogin://group/item -- <command>` to inject
DB_HOST/PORT/USERNAME/TYPE/PASSWORD or SSH_HOST/PORT/USERNAME/AUTH_TYPE and the
selected SSH_PASSWORD or SSH_PRIVATE_KEY. Use `--secret-bundle PREFIX=lelogin://...`
for multiple connections. Existing dynamic bundles retain their environment keys.
For native SSH, prefer `--file KEY_FILE=lelogin://group/item#privateKey`; the child
receives a restricted temporary file path, removed on exit or caught interruption.
Do not print resolved variables or read the temporary private-key file into model context.
