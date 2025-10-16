# Contributing to Android Kotlin Generator

Thank you for your interest in contributing! 🎉

## How to Contribute

### 🐛 Reporting Bugs

1. Check if the bug is already reported in [Issues](https://github.com/yourusername/android-kotlin-generator/issues)
2. If not, create a new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce
   - Expected vs actual behavior
   - OS and version info
   - Logs (from `build.log`)

### 💡 Suggesting Features

1. Check [Discussions](https://github.com/yourusername/android-kotlin-generator/discussions) first
2. Open an issue with `[Feature Request]` prefix
3. Describe the feature and use cases
4. Explain why it would be useful

### 🔧 Pull Requests

1. **Fork** the repository
2. **Create** a branch: `git checkout -b feature/my-feature`
3. **Make** your changes
4. **Test** on Linux and macOS (if possible)
5. **Commit** with clear messages
6. **Push** to your fork
7. **Submit** a Pull Request

### 📝 Coding Standards

- Use **POSIX-compliant** shell scripts where possible
- Follow **Kotlin** coding conventions for app code
- Add **comments** for complex logic
- Keep functions **small and focused**
- Test on **multiple OS** (Linux, macOS)

### ✅ Testing Checklist

Before submitting PR:

- [ ] Scripts run without errors on Linux
- [ ] Scripts run without errors on macOS (if possible)
- [ ] Generated projects build successfully
- [ ] APK installs on Android device
- [ ] Documentation updated
- [ ] No hardcoded paths
- [ ] Error handling added

### 📚 Documentation

- Update README.md for new features
- Add inline comments for complex code
- Include examples for new functionality

## Development Setup

```bash
# Clone your fork
git clone https://github.com/yourusername/android-kotlin-generator.git
cd android-kotlin-generator

# Test the generator
./create-project.sh

# Make changes and test
# ...

# Run in a test project
cd TestProject
./setup.sh
```

## Questions?

Feel free to ask in [Discussions](https://github.com/yourusername/android-kotlin-generator/discussions) or open an issue!

---

**Thank you for contributing! 🚀**
