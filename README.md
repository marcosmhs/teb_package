## Overview

This library is a collection of classes developed by **Marcos Silva**. It is designed to provide reusable components and utilities for various programming tasks. Below is an overview of the classes included in the library and their intended usage.

## Classes

### Class: `TEBText`
- **Description**: A text widget with additional styling options for That Exotic Bug applications.
- **Usage**: This class is used to display styled text consistently across the application.
- **Key Methods**:
    - `TEBText({required String text, TextStyle? style})`: Constructor to create a styled text widget.

### Class: `TEBButton`
- **Description**: A button widget with predefined styles for That Exotic Bug applications.
- **Usage**: This class is used to create buttons with consistent styling and behavior.
- **Key Methods**:
    - `TEBButton({required String label, required VoidCallback onPressed})`: Constructor to create a button with a label and an action.

### Class: `TEBTextEdit`
- **Description**: A text editing widget with custom styling and validation options.
- **Usage**: This class is used to create text input fields with additional features like validation.
- **Key Methods**:
    - `TEBTextEdit({String? hintText, TextEditingController? controller})`: Constructor to create a text input field.

## Usage Example

### Example 1: Using `TEBText`
```dart
import 'package:teb_package/teb_text.dart';

TEBText(
  text: 'Welcome to That Exotic Bug!',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
);
```

### Example 2: Using `TEBButton`
```dart
import 'package:teb_package/teb_button.dart';

TEBButton(
  label: 'Submit',
  onPressed: () {
    print('Button pressed!');
  },
);
```

### Example 3: Using `TEBTextEdit`
```dart
import 'package:teb_package/teb_text_edit.dart';

TEBTextEdit(
  hintText: 'Enter your name',
  controller: TextEditingController(),
);
```

## Adding the Package to `pubspec.yaml`

To use this package in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  teb_package:
    git:
      url: https://github.com/marcosmhs/teb_package.git
```

Run `flutter pub get` to fetch the package and start using it in your project.
