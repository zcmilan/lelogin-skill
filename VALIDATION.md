# Validation

Validated on 2026-10-07 using Node.js 24.19.0, @deepseek-ai/cordis 4.0.4, and @deepseek-ai/dsh-skill 0.2.0-rc.2 from npm.

- Mounted the actual Harness SkillRegistry and LeLogin plugin in a Cordis Context.
- Discovered and loaded the lelogin skill.
- Verified all four reference documents and all four installer/uninstaller resources resolve from the registered directory.
- Rendered the skill with the official skill renderer.
- Disposed the plugin and verified its registration disappeared.

Build and package structure checks and six installer/build tests passed.
This checks plugin registration and packaged resources. It does not exercise credential operations, LeLogin installation, a model conversation, or Windows runtime behavior.
