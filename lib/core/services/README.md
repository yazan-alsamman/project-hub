# PDF Service Documentation

## Overview
This service provides functionality to generate PDF reports for projects and share them through various platforms.

## Features
- Generate professional PDF reports for projects
- Share PDFs through native sharing options
- Share project information as text
- Copy project links to clipboard

## Usage

### 1. Generate PDF
```dart
final file = await PDFService.generateProjectPDF(project);
if (file != null) {
  // PDF generated successfully
  print('PDF saved to: ${file.path}');
}
```

### 2. Share Dialog
```dart
showDialog(
  context: context,
  builder: (context) => ShareDialog(project: project),
);
```

## Dependencies Required
- `pdf: ^3.10.7` - PDF generation
- `path_provider: ^2.1.2` - File system access
- `share_plus: ^7.2.2` - Native sharing
- `permission_handler: ^11.3.1` - Permission management

## Permissions
The service requires storage permission to save PDF files. This is handled automatically by the service.

## PDF Content
The generated PDF includes:
- Project header with title, company, and status
- Project description
- Progress information with visual progress bar
- Timeline (start/end dates)
- Team information
- Generated timestamp and app branding

## Error Handling
The service includes comprehensive error handling for:
- Permission denials
- File system errors
- PDF generation failures
- Sharing failures

All errors are logged and user-friendly messages are displayed.
