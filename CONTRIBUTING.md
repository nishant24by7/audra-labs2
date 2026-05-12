# Contributing to Audra Labs

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Report security issues privately to security@audralabs.dev
- No harassment or discrimination

## Getting Started

### Fork and Clone
```bash
git clone https://github.com/YOUR_USERNAME/Audra-Labs.git
cd Audra-Labs
```

### Setup Development Environment
```bash
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install -r backend/requirements.txt
pip install pytest pytest-cov flake8
```

### Create Feature Branch
```bash
git checkout -b feature/your-feature-name
```

## Development Workflow

### Running Tests
```bash
pytest backend/tests/ -v --cov=backend
```

### Code Formatting
```bash
black backend/
flake8 backend/
```

### Security Check
```bash
bandit -r backend/
safety check -r backend/requirements.txt
```

## Submitting Changes

1. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature"
   ```

2. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create Pull Request**
   - Clear description of changes
   - Link related issues
   - Include test results
   - Add screenshots if UI changes

## Pull Request Checklist

- [ ] Tests pass locally (`pytest`)
- [ ] Code is formatted (`black`, `flake8`)
- [ ] No security issues (`bandit`, `safety`)
- [ ] Documentation updated if needed
- [ ] Commit messages are clear
- [ ] No unrelated changes included

## Areas for Contribution

### High Priority
- [ ] Performance optimization
- [ ] Additional forensic detection engines
- [ ] Multi-language support
- [ ] Mobile app (React Native/Flutter)
- [ ] Enterprise features

### Medium Priority
- [ ] API documentation
- [ ] SDK development
- [ ] Integration templates
- [ ] Video analysis support
- [ ] Batch processing optimization

### Community
- [ ] Bug reports
- [ ] Feature suggestions
- [ ] Documentation improvements
- [ ] Tutorial creation
- [ ] Community feedback

## Issues and Feature Requests

### Reporting Bugs
```markdown
**Description**: Clear, concise description
**Steps to Reproduce**: Step-by-step instructions
**Expected Behavior**: What should happen
**Actual Behavior**: What actually happens
**Environment**: OS, Python version, API version
**Screenshots**: If applicable
```

### Feature Requests
```markdown
**Problem**: What problem does it solve?
**Proposed Solution**: How should it work?
**Use Cases**: When would someone use this?
**Alternatives**: Other approaches considered
```

## Documentation

- Update README.md for user-facing changes
- Add docstrings to new functions
- Comment complex logic
- Update DEPLOYMENT.md for infrastructure changes

## Release Process

1. Version bump (MAJOR.MINOR.PATCH)
2. Update CHANGELOG
3. Create GitHub release
4. Tag commit: `v1.0.0`
5. Publish to PyPI (if applicable)

## Questions?

- 💬 GitHub Discussions
- 📧 support@audralabs.dev
- 🐛 GitHub Issues

Thank you for contributing! 🚀
