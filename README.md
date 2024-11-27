# PasswordChecklist Widget

The `PasswordChecklist` widget in Flutter is a customizable UI element used to display password validation requirements and their current status. This widget helps users see which conditions their password meets in real-time, with customizable messages, colors, and icons. Below, we provide a detailed explanation of each attribute.

<table>
<tr>
<td>

[![Video 1](https://github.com/user-attachments/assets/663adf60-4b0d-4e85-997a-2ac43e85c273)](https://github.com/user-attachments/assets/663adf60-4b0d-4e85-997a-2ac43e85c273)

</td>
<td>

[![Video 2](https://github.com/user-attachments/assets/382d3e2e-fc8a-401d-94c1-726c9e8baa7b)](https://github.com/user-attachments/assets/382d3e2e-fc8a-401d-94c1-726c9e8baa7b)

</td>
</tr>
</table>



## Attributes

### 1. `controller`
- **Type**: `TextEditingController`
- **Description**: The `controller` is used to manage and listen to changes in the password input field. It should be passed from the parent widget to ensure the `PasswordChecklist` has access to the password text.
- **Example**:
  ```dart
  TextEditingController myController = TextEditingController();
  ```

### 2. `onValidationChanged`
- **Type**: `ValueChanged<bool>`
- **Description**: A callback function that is triggered whenever the password validation status changes. This allows you to handle changes in the validation state, such as enabling or disabling a submit button.
- **Example**:
  ```dart
  (isValid) {
    print(isValid ? "Password is valid" : "Password is invalid");
  }
  ```

### 3. `checkEightCharacters`
- **Type**: `bool`
- **Description**: Determines whether the widget checks for a minimum character length. If set to `true`, the widget will verify that the password has at least `minCharacters` characters.
- **Default**: `true`
- **Example**:
  ```dart
  checkEightCharacters: true,
  ```

### 4. `checkSpecialCharacter`
- **Type**: `bool`
- **Description**: Indicates whether the widget should check for the presence of at least one special character (e.g., `!@#$%^&*()`).
- **Default**: `true`
- **Example**:
  ```dart
  checkSpecialCharacter: true,
  ```

### 5. `checkNumber`
- **Type**: `bool`
- **Description**: Indicates whether the widget should check for the presence of at least one numeric digit.
- **Default**: `true`
- **Example**:
  ```dart
  checkNumber: true,
  ```

### 6. `checkUppercase`
- **Type**: `bool`
- **Description**: Specifies whether the widget should verify if the password contains at least one uppercase letter.
- **Default**: `true`
- **Example**:
  ```dart
  checkUppercase: true,
  ```

### 7. `checkLowercase`
- **Type**: `bool`
- **Description**: Determines if the widget should check for at least one lowercase letter in the password.
- **Default**: `true`
- **Example**:
  ```dart
  checkLowercase: true,
  ```

### 8. `checkOnlyNumbers`
- **Type**: `bool`
- **Description**: Indicates if the widget should check if the password is composed solely of numbers.
- **Default**: `false`
- **Example**:
  ```dart
  checkOnlyNumbers: false,
  ```

### 9. `minCharacters`
- **Type**: `int`
- **Description**: Specifies the minimum number of characters required for the password when `checkEightCharacters` is set to `true`.
- **Default**: `8`
- **Example**:
  ```dart
  minCharacters: 10,
  ```

### 10. `validColor`
- **Type**: `Color?`
- **Description**: The color applied to the validation text and `Checkbox` when the condition is met. If not specified, it defaults to green.
- **Example**:
  ```dart
  validColor: Colors.blue,
  ```

### 11. `invalidColor`
- **Type**: `Color?`
- **Description**: The color applied to the validation text and `Checkbox` when the condition is not met. If not specified, it defaults to red.
- **Example**:
  ```dart
  invalidColor: Colors.orange,
  ```

### 12. `eightCharactersMessage`
- **Type**: `String?`
- **Description**: Customizable message displayed when the password does not meet the minimum character requirement. If not provided, the default message is "Should contain at least X characters."
- **Example**:
  ```dart
  eightCharactersMessage: 'Password must be at least 12 characters long',
  ```

### 13. `specialCharacterMessage`
- **Type**: `String?`
- **Description**: Customizable message shown when the password does not contain a special character. Defaults to "Should contain a special character."
- **Example**:
  ```dart
  specialCharacterMessage: 'Include at least one special character',
  ```

### 14. `numberMessage`
- **Type**: `String?`
- **Description**: Customizable message displayed when the password does not contain a number. Defaults to "Should contain a number."
- **Example**:
  ```dart
  numberMessage: 'Include at least one numeric digit',
  ```

### 15. `uppercaseMessage`
- **Type**: `String?`
- **Description**: Customizable message displayed when the password does not contain an uppercase letter. Defaults to "Should contain an uppercase letter."
- **Example**:
  ```dart
  uppercaseMessage: 'Include at least one uppercase letter',
  ```

### 16. `lowercaseMessage`
- **Type**: `String?`
- **Description**: Customizable message shown when the password does not contain a lowercase letter. Defaults to "Should contain a lowercase letter."
- **Example**:
  ```dart
  lowercaseMessage: 'Include at least one lowercase letter',
  ```

### 17. `onlyNumbersMessage`
- **Type**: `String?`
- **Description**: Customizable message displayed when the password only contains numbers. Defaults to "Should contain only numbers."
- **Example**:
  ```dart
  onlyNumbersMessage: 'Password should not be only numbers',
  ```

### 18. `customIcon`
- **Type**: `Widget?`
- **Description**: An optional custom icon that will be displayed next to the validation message. If not provided, a default `Checkbox` will be shown.
- **Example**:
  ```dart
  customIcon: Icon(Icons.check, color: Colors.blue),
  ```


