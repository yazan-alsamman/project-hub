# 📱 Junior - Project Management App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20Linux%20%7C%20macOS-lightgrey?style=for-the-badge)

**A modern, cross-platform project management application built with Flutter**

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Usage](#-usage) • [Contributing](#-contributing) • [License](#-license)

</div>

---

## 📖 About

**Junior** is a comprehensive project management application designed to help teams collaborate, track projects, manage tasks, and analyze productivity. Built with Flutter, it provides a seamless experience across all major platforms including Android, iOS, Web, Windows, Linux, and macOS.

### 🎯 Key Highlights

- 🚀 **Cross-Platform**: Run on Android, iOS, Web, Windows, Linux, and macOS
- 📊 **Project Management**: Track projects, tasks, and team members
- 📈 **Analytics**: Monitor productivity and project progress
- 👥 **Team Management**: Manage team members and assignments
- 📄 **PDF Reports**: Generate professional PDF reports for projects
- 🌍 **Multi-language**: Support for multiple languages
- 🎨 **Modern UI**: Beautiful, responsive user interface
- ⚡ **Fast Performance**: Optimized for speed and efficiency

## ✨ Features

### 📋 Project Management
- **Project Dashboard**: Overview of all projects with status and progress
- **Project Details**: Detailed view of project information
- **Project Status**: Track project status (Active, Completed, Planned)
- **Progress Tracking**: Visual progress bars and completion percentages
- **Timeline Management**: Start and end date tracking

### 👥 Team Management
- **Team Overview**: View all team members
- **Member Details**: Detailed profiles for each team member
- **Team Statistics**: Track team productivity and performance
- **Assignment Management**: Assign team members to projects

### ✅ Task Management
- **Task List**: View and manage all tasks
- **Task Status**: Track task completion status
- **Task Filtering**: Filter tasks by status, priority, or assignee
- **Task Sorting**: Sort tasks by various criteria

### 📊 Analytics
- **Productivity Metrics**: Track team and individual productivity
- **Project Analytics**: Analyze project performance
- **Progress Reports**: Visual reports and charts
- **Performance Insights**: Gain insights into team performance

### 📄 PDF Generation
- **Project Reports**: Generate professional PDF reports
- **Share Reports**: Share PDFs via email, messaging, or other apps
- **Custom Formatting**: Beautiful, formatted PDF documents
- **Export Options**: Multiple export and sharing options

### ⚙️ Settings
- **Language Selection**: Change application language
- **Theme Settings**: Customize app appearance
- **Timezone Settings**: Configure timezone preferences
- **Security Settings**: Manage security and privacy options
- **Team Settings**: Configure team-related settings

### 🔐 Authentication
- **Login System**: Secure authentication system
- **User Management**: Manage user accounts
- **Session Management**: Handle user sessions

### 🎨 User Interface
- **Modern Design**: Clean, modern interface
- **Responsive Layout**: Adapts to different screen sizes
- **Custom App Bar**: Customizable navigation bar
- **Custom Drawer**: Side navigation drawer
- **Animations**: Smooth animations and transitions

## 📸 Screenshots

<div align="center">

### Project Dashboard
![Project Dashboard](assets/images/project_dashboard.png)

### Team Management
![Team Management](assets/images/team_management.png)

### Analytics
![Analytics](assets/images/analytics.png)

</div>

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.8.1+
- **Dart** 3.8.1+

### State Management
- **GetX** 4.6.6 - State management and dependency injection

### Key Dependencies
- **http** 1.1.2 - HTTP client for API requests
- **shared_preferences** 2.2.2 - Local storage
- **pdf** 3.10.7 - PDF generation
- **path_provider** 2.1.2 - File system access
- **share_plus** 7.2.2 - Native sharing
- **permission_handler** 11.3.1 - Permission management
- **connectivity_plus** 5.0.2 - Network connectivity
- **timezone** 0.9.2 - Timezone handling
- **url_launcher** 6.2.2 - URL launching
- **open_file** 3.3.2 - File opening
- **lottie** 3.1.2 - Animations
- **dartz** 0.10.1 - Functional programming

## 📦 Installation

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDE)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yazan1240/project-hub.git
   cd project-hub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21
- Target SDK: 33+
- Gradle version: 8.0+

#### iOS
- Minimum iOS: 12.0
- Xcode version: 14.0+

#### Web
- Chrome/Edge (recommended)
- Firefox
- Safari

#### Desktop (Windows/Linux/macOS)
- Windows 10+
- Linux (Ubuntu 18.04+)
- macOS 10.14+

## 🚀 Usage

### Running the Application

```bash
# Run on connected device
flutter run

# Run on specific platform
flutter run -d android
flutter run -d ios
flutter run -d web
flutter run -d windows
flutter run -d linux
flutter run -d macos
```

### Building the Application

```bash
# Build APK (Android)
flutter build apk

# Build App Bundle (Android)
flutter build appbundle

# Build IPA (iOS)
flutter build ipa

# Build Web
flutter build web

# Build Windows
flutter build windows

# Build Linux
flutter build linux

# Build macOS
flutter build macos
```

## 📁 Project Structure

```
lib/
├── controller/          # Controllers (GetX)
│   ├── analytics_controller.dart
│   ├── login_controller.dart
│   ├── projects_controller.dart
│   ├── tasks_controller.dart
│   └── ...
├── core/               # Core functionality
│   ├── class/          # Base classes
│   ├── constant/       # Constants
│   ├── functions/      # Utility functions
│   ├── services/       # Services (API, Auth, PDF)
│   └── shared/         # Shared widgets
├── data/               # Data layer
│   ├── Models/         # Data models
│   ├── repository/     # Repositories
│   └── static/         # Static data
├── view/               # UI layer
│   ├── screens/        # Screens
│   └── widgets/        # Reusable widgets
├── main.dart           # Entry point
└── routes.dart         # Route configuration
```

## 🔧 Configuration

### API Configuration

1. Open `lib/core/services/api_service.dart`
2. Update the API base URL
3. Configure authentication headers if needed

### Theme Configuration

1. Open `lib/core/constant/apptheme.dart`
2. Customize colors, fonts, and themes
3. Update theme settings as needed

### Localization

1. Add translation files in `lib/core/localaization/`
2. Update `translation.dart` with new languages
3. Configure language settings in the app

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Yazan** - [@yazan1240](https://github.com/yazan1240)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX for state management
- All contributors and open-source packages used

## 📞 Contact

For questions or support, please open an issue on GitHub or contact the maintainers.

## 🔮 Roadmap

- [ ] Real-time collaboration
- [ ] Cloud sync
- [ ] Mobile notifications
- [ ] Advanced analytics
- [ ] Integration with third-party tools
- [ ] Custom themes
- [ ] More languages support
- [ ] Offline mode
- [ ] Dark mode
- [ ] Widgets for home screen

## 📊 Project Status

![GitHub stars](https://img.shields.io/github/stars/yazan1240/project-hub?style=social)
![GitHub forks](https://img.shields.io/github/forks/yazan1240/project-hub?style=social)
![GitHub issues](https://img.shields.io/github/issues/yazan1240/project-hub)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yazan1240/project-hub)

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you find it helpful!

</div>
