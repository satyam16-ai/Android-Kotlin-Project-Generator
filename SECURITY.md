# Security Policy

## Supported Versions

Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please:

1. **DO NOT** open a public issue
2. Email us at: security@yourproject.com
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We will respond within 48 hours and work with you to resolve the issue.

## Security Best Practices

When using this tool:

- ✅ Download scripts only from official repository
- ✅ Review scripts before executing
- ✅ Keep Android SDK and build tools updated
- ✅ Use keystore files with strong passwords for release builds
- ✅ Never commit keystore files or credentials to version control
- ✅ Enable USB debugging only when needed
- ✅ Revoke USB debugging authorization after development

## Scope

This security policy applies to:
- Generator scripts (`create-project.sh`, `setup.sh`)
- Template application code
- Build configuration files

## Out of Scope

- Third-party dependencies (report to respective maintainers)
- User-generated code in projects
- Issues in Android SDK or Gradle

Thank you for helping keep our project secure! 🔒
