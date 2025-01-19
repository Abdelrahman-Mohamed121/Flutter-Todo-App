# Task Manager App 📋

A Flutter-based **Task Manager App** that allows users to manage their tasks efficiently. The app allows users to efficiently manage their tasks, with features like user authentication, task CRUD operations, pagination, state management using provider pattern, local storage, dark mode, and unit testing.

---

## Features 🚀

1. **User Authentication**  
   - Secure login using `https://dummyjson.com/docs/auth`.
   - Stores user session for persistence.
   - Authentication tokens are stored securely using [FlutterSecureStorage](https://pub.dev/packages/flutter_secure_storage).

2. **Task Management**  
   - Add, edit, delete, and view tasks.
   - Tasks are fetched from and synced with `https://dummyjson.com/docs/todos`.

3. **Pagination**  
   - Efficient loading of tasks using API pagination with the `limit` and `skip` parameters.

4. **Dark Mode**  
   - Switch between light and dark themes.
   - Preference is saved using `SharedPreferences`.

5. **State Management**  
   - State is managed using the **Provider** package for a clean and responsive UI.

---

## Screenshots 📸
  - Login Screen

<img src="https://github.com/user-attachments/assets/dde590b2-6462-4ded-8141-ebbc2ffcd9ed" width="250"> <img src="https://github.com/user-attachments/assets/469bba56-2538-4ac2-818b-d2cd35472e7d" width="250">

  - Home Screen

<img src="https://github.com/user-attachments/assets/12748d7e-d62b-4577-badd-2d548da03aa9" width="250"> <img src="https://github.com/user-attachments/assets/cee47a5b-f372-479d-bd23-b9dd5a6ca182" width="250">

  - Add, edit, delete tasks

<img src="https://github.com/user-attachments/assets/533f96ef-5cc1-4627-ba2f-123a605576ee" width="250"> <img src="https://github.com/user-attachments/assets/b47077cf-2a1c-4d09-bd9d-cd4e2cde8ba0" width="250">
<img src="https://github.com/user-attachments/assets/9fe6c9da-c8f9-48c8-b38d-4dfff8a0f02f" width="250"> <img src="https://github.com/user-attachments/assets/cf1730f9-0ac7-4291-a61d-3cfe94e1ac38" width="250">


---

## Tech Stack 🛠️

- **Framework**: Flutter
- **State Management**: Provider
- **Backend API**: [DummyJSON](https://dummyjson.com)
- **Local Storage**: SharedPreferences

---

## **Getting Started**

### **Prerequisites**
1. Install [Flutter](https://flutter.dev/docs/get-started/install) (Version 3.0 or later recommended).
2. Set up a code editor, such as [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### **Dependencies**
This project uses the following dependencies:
- `cupertino_icons`
- `provider`: State management.
- `http`: For making API requests.
- `shared_preferences`: Local storage for caching task data and theme preference.
- `flutter_secure_storage`: Secure storage for authentication tokens.

---

##How to Run
1. Clone the repository:

```bash
git clone https://github.com/yourusername/task-manager-app.git
cd task-manager-app
```

2. Install the dependencies:
```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```
