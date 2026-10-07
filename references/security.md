# Security and authorization

- Discovery results may expose names, types, descriptions, projects, environments, and secret references. They must never expose secret values.
- Before a write, send, delete, publish, payment, approval, or other consequential action, identify the exact target and rely on the host's approval policy or obtain the user's explicit authorization.
- Never weaken TLS, disable host verification, bypass approval checks, or copy browser profile data.
- Do not write resolved credentials into `.env` files, source files, command arguments, logs, or generated reports.
- If a command fails because the user is signed out, authenticate and retry discovery once. Repeated failure is an authorization or configuration issue, not a reason to collect plaintext credentials.
