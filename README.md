# ITE Store 📱

Welcome to the **ITE Store**! This is a mobile shopping application built with Flutter as a final exam project for the Computer Science and Information Technology program.

---

## 📖 Project Overview

ITE Store is a clean and functional e-commerce app. It allows users to browse a product list, search for specific items, manage a shopping cart, and complete a checkout process. The app is designed with a professional architecture to support different environments for testing and production.

---

## ✨ Features

* **Product Browsing:** Fetch and display a list of products from an API.
* **Product Search:** Quickly find items by name using the search bar.
* **Shopping Cart:** Add, update quantity, and remove items.
* **Checkout Logic:** Complete the purchase and clear the cart.
* **Multi-Environment Support:** Custom settings and logos for different development stages.

---

## 📱 Screens

1. **Home Screen:** Displays the product list, search bar, and cart icon.
2. **Cart Screen:** Shows added items, total price, and the checkout button.

---

## 🌍 Environment/Flavor Explanation

This project uses **Flutter Flavors** to create four different versions of the app from one codebase. Each version has its own name and logo:

| Environment | App Name | Description |
| --- | --- | --- |
| **Dev** | ITE Store Dev | Used for active development and testing. |
| **UAT** | ITE Store Test | User Acceptance Testing version. |
| **Demo** | ITE Store Demo | **Limited:** View only. No cart access. |
| **Prod** | ITE Store | The final version for users. |

---

## 🛠 Technologies Used

* **Flutter:** Mobile UI framework.
* **Dart:** Programming language.
* **Provider:** For managing the shopping cart state.
* **HTTP:** For communicating with the API.

---

## 📁 Project Structure

```text
ite_store/
├── assets/images/       # App logos for each flavor
├── lib/
│   ├── config/          # Environment/Flavor settings
│   ├── models/          # Data structures (Product, CartItem)
│   ├── providers/       # State management
│   ├── screens/         # UI pages (Home, Cart)
│   ├── services/        # API communication
│   └── main_dev.dart    # Entry point for Dev flavor
├── pubspec.yaml         # Dependencies and assets
└── android/             # Android native configuration

```

---

## ⚙️ Installation Steps

1. **Clone the project:**
`git clone https://github.com/your-username/mad_final_y3.git`
2. **Install dependencies:**
Open your terminal in the `ite_store` folder by run `cd ite_store` and run:
`flutter pub get`
3. **Setup Android NDK:** (If you see build errors, ensure your Android SDK and NDK are correctly installed in Android Studio).

---

## 🚀 How to Run the Project

To run the app, ensure you have an emulator (like MuMu Player) or a real phone connected.

### How to Run Each Flavor

Use the following commands in your terminal to launch the version you want:

* **Run Dev:** `flutter run --flavor dev -t lib/main_dev.dart`
* **Run UAT:** `flutter run --flavor uat -t lib/main_uat.dart`
* **Run Demo:** `flutter run --flavor demo -t lib/main_demo.dart`
* **Run Prod:** `flutter run --flavor prod -t lib/main_prod.dart`

---

### 🎮 Connecting to MuMu Player Emulator

If you want to run the **ITE Store** app on the MuMu Player emulator instead of a physical phone, follow these steps:

1. **Enable ADB in MuMu Player:**
* Open MuMu Player settings.
* Go to **Developer Options** (or "Settings" -> "About Tablet" -> Click "Build Number" 7 times to enable).
* Turn on **USB Debugging**.
* In MuMu Settings, ensure "ADB connection" is enabled (often found under "Other" or "Developer" tab).


2. **Connect via Terminal:**
Open your project terminal and run this command to link your computer to the emulator:
```bash
# Try this first:
adb connect 127.0.0.1:7555

# If the above fails (for MuMu Player 12), try this:
adb connect 127.0.0.1:16384

```


3. **Verify the Connection:**
Check if Flutter sees your emulator by running:
```bash
flutter devices

```


If successful, you will see `127.0.0.1:7555` in the list of connected devices.
4. **Run the App:**
Now you can use the standard run commands (e.g., `flutter run --flavor dev -t lib/main_dev.dart`) to install the app onto MuMu Player.

> **Note:** If you restart your computer or MuMu Player, the connection might drop. Simply run the `adb connect` command again to reconnect.

---

### Tips for success:

* Make sure your **Android SDK Platform-Tools** are in your computer's Path (System Environment Variables) so the `adb` command works globally.
* If you see the error `adb: The term 'adb' is not recognized`, use the full path to your SDK:
  `X:\...\Android\Sdk\platform-tools\adb.exe connect 127.0.0.1:7555`

## 📸 Screenshots

*<img width="510" height="735" alt="image" src="https://github.com/user-attachments/assets/542ee0a9-31a4-46c9-ab8d-498371965d39" />
*

---

## 💡 Future Improvements

* Add user authentication (Login/Register).
* Add category filtering for products.
* Save cart data locally using SharedPreferences.

---

## 👨‍💻 Author

**Seak Bolim** *Third-Year Student,ITE *RUPP*

---

*Happy coding!*
