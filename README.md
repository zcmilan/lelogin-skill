# LeLogin for DeepSeek Harness

A DeepSeek Harness skill plugin for using LeLogin credentials and authenticated business applications without exposing plaintext passwords, cookies, tokens, or private keys to the model.

The plugin registers the `lelogin` skill with the Harness skill registry. The skill explains credential discovery, environment injection, application command selection, browser Profile selection, and approval boundaries. It ships installation instructions and checksum-verifying download helpers. Loading the plugin does not install LeLogin, enumerate credentials, or sign in to an account.

## Install in DeepSeek Harness

With DeepSeek Harness installed, add the GitHub repository to the `web` profile:

```sh
dsh plugin --profile web add github:zcmilan/lelogin-skill
```

Restart the Harness process after installation. The selected profile must include the `skills` service and a skill consumer; the normal web profile provides these. Ask the agent to use the `lelogin` skill. The plugin itself has no model-provider dependency or API key requirement.

For a local checkout or extracted package, use its absolute directory path instead:

```sh
dsh plugin --profile web add /absolute/path/to/lelogin-skill
```

## Set up LeLogin

LeLogin CLI and Workspace run on the user's local computer. The skill checks `lelogin --help` and `lelogin runtime status` first. If a component is missing, follow [installation instructions](skills/lelogin/references/installation.md). The packaged Unix and PowerShell helpers download from the official HTTPS origin and require SHA256 verification:

```text
https://lelogin.nationauth.cn/lelogin/cmd
```

Installers and CLI/Workspace binaries are downloaded separately; the plugin does not contain them. Windows PowerShell helpers have been inspected but have not been executed on a Windows machine.

Complete interactive LeLogin sign-in on your own computer. A cloud or remote Harness cannot automatically access the user's local browser Profile or Workspace. Do not provide account credentials in a prompt, a GitHub issue, or a repository file.

## Examples

- “Use LeLogin to find the SSH credential for the server I name and run this read-only command.”
- “Use the Work Profile in LeLogin to query this business application.”
- “Check whether LeLogin CLI and Workspace are installed and show their runtime status.”

Select the intended resource from non-sensitive discovery metadata. The CLI resolves credentials during execution; plaintext secrets must remain outside model context and logs. Saving, deleting, or writing to external systems must follow the host's approval rules.

## Files

```text
package.json               # dsh.bundle manifest
cordis.patch.yml           # Harness profile patch
index.js                   # skills-service registration
skills/lelogin/SKILL.md     # Skill instructions
skills/lelogin/references/  # Installation, runtime, security and workflows
skills/lelogin/scripts/     # Checksum-verifying install/uninstall helpers
```

The root `SKILL.md` and its resources, when present, also support direct skill installation. The Harness plugin uses the copy under `skills/lelogin/`.

## Support and licensing

Publisher: NationAuth. Product: [LeLogin](https://lelogin.nationauth.cn). Support: support@nationauth.cn.

This package currently declares `UNLICENSED`; publishing its source does not grant an open-source license. LeLogin CLI and Workspace have their own product terms.
