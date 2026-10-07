# Workspace runtime

LeLogin Workspace is a local Electron runtime with isolated persistent browser profiles. It executes resolved OpenCLI commands and extracts approved Web session fields without sending browser Cookie plaintext to the server.

```bash
lelogin runtime start
lelogin runtime status
lelogin runtime jobs
lelogin runtime cancel <job-id>
```

For a Web application requiring interactive login, use `lelogin app login <app>`. The user completes login, MFA, and CAPTCHA in the visible Workspace window.

`WEB_SESSION_TOKEN` bundles are resolved locally through browser-client. The CLI may inject approved fields into a child process, but the agent must never inspect or echo those values.
