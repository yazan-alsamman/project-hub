# Contributing to Junior Project Management App

First off, thank you for considering contributing to Junior! It's people like you that make Junior such a great tool.

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read the full text so that you can understand what actions will and will not be tolerated.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples to demonstrate the steps**
- **Describe the behavior you observed after following the steps**
- **Explain which behavior you expected to see instead and why**
- **Include screenshots and animated GIFs if applicable**
- **Include the Flutter and Dart version you're using**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a step-by-step description of the suggested enhancement**
- **Provide specific examples to demonstrate the steps**
- **Describe the current behavior and explain which behavior you expected to see instead**
- **Explain why this enhancement would be useful**
- **List some other applications where this enhancement exists, if applicable**

### Pull Requests

- Fill in the required template
- Do not include issue numbers in the PR title
- Include screenshots and animated GIFs in your pull request whenever possible
- Follow the Dart and Flutter style guides
- Include thoughtfully-worded, well-structured tests
- Document new code based on the Documentation Styleguide
- End all files with a newline

## Development Process

1. Fork the repo and create your branch from `master`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

### Setting Up Development Environment

1. Clone your fork of the repository
   ```bash
   git clone https://github.com/YOUR_USERNAME/project-hub.git
   cd project-hub
   ```

2. Add the upstream repository
   ```bash
   git remote add upstream https://github.com/yazan1240/project-hub.git
   ```

3. Install dependencies
   ```bash
   flutter pub get
   ```

4. Run the app
   ```bash
   flutter run
   ```

### Coding Standards

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide
- Use meaningful variable and function names
- Write comments for complex logic
- Keep functions small and focused
- Follow the existing code style

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line
- Consider starting the commit message with an applicable emoji:
  - 🎨 `:art:` when improving the format/structure of the code
  - 🐛 `:bug:` when fixing a bug
  - ⚡️ `:zap:` when improving performance
  - 📝 `:memo:` when writing docs
  - 🚀 `:rocket:` when deploying stuff
  - ✅ `:white_check_mark:` when adding tests
  - 🔒 `:lock:` when dealing with security
  - ⬆️ `:arrow_up:` when upgrading dependencies
  - ⬇️ `:arrow_down:` when downgrading dependencies

### Testing

- Write unit tests for new features
- Write widget tests for UI components
- Ensure all tests pass before submitting a PR
- Aim for high test coverage

### Documentation

- Update README.md if needed
- Add comments to complex code
- Update API documentation if you change APIs
- Add examples if you add new features

## Style Guide

### Dart Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Use `flutter analyze` to check for issues

### File Naming

- Use snake_case for file names: `project_controller.dart`
- Use descriptive names: `user_profile_screen.dart` not `screen1.dart`

### Code Organization

- Group related code together
- Use imports to organize dependencies
- Keep files focused on a single responsibility

## Questions?

Feel free to open an issue for any questions you might have. We're here to help!

Thank you for contributing to Junior! 🎉

