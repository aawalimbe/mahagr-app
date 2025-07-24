# 🌲 Forest Department GR & Updates App

**Client:** Rahul Sapkal, RFO  
**Prepared By:** Akshay – Alpha Developer Team  
**Date:** 30 Nov 2024

---

## 📱 Project Overview

This Flutter-based mobile application enables Forest Department staff and stakeholders to access Government Regulations (GRs), law updates, and official communications in various formats (PDF, text, images). The app is designed for cross-platform use (Android/iOS), with a focus on speed, clarity, and accessibility.

---

## 🎯 Key Features

- **User Authentication:** Secure login and registration with form validation.
- **Department Selection:** Users can select their department and district for personalized content.
- **Home Feed:** Grid-based navigation to categorized content (PDFs, images, text).
- **Content Viewer:** In-app PDF and image viewing, with options to share and download documents.
- **Expandable Department List:** On the sub-sub-departments page, each department row can be expanded to show all departments with their respective logos. Tapping a department in this expanded list navigates to the GR List page for that department.
- **Notifications:** (Planned) Push notifications for timely updates.
- **Profile Management:** Edit and update user profile information.
- **Policy & Legal Info:** In-app access to privacy policy, terms, refund, and disclaimer pages.
- **Multi-language Support:** (Planned) Language selection for broader accessibility.
- **Modern UI:** Clean, responsive design with custom themes and scalable typography.
- **Offline Assets:** Bundled images, PDFs, and data for offline access.

---

## 🧭 App Flow

```mermaid
flowchart TD
    A[Start Page] --> B[Welcome Page]
    B --> C[Splash Screen]
    C --> D[Registration]
    D --> E[Department Selection]
    E --> F[Home Page]
    F --> G[Content Viewer (PDF/Image/Text)]
    F --> H[Notifications]
    F --> I[Profile/Edit Profile]
    F --> J[Policies & Help]
    F --> K[Sub-Sub-Departments]
    K --> L[Expandable Department List]
    L --> M[GR List Page]
    G --> N[Share/Download]
```

---

## 🎨 Theme and Design Language

| Element     | Color Code         |
|-------------|-------------------|
| Primary     | Forest Green `#228B22` |
| Secondary   | Dark Grey `#333333`    |
| Background  | White `#FFFFFF`        |

- **Typography:** Clean, high-contrast fonts (OpenSans) for readability in outdoor environments.
- **Icons:** Material icons for navigation and actions.

---

## 🔧 Tech Stack

| Layer           | Technology                        |
|-----------------|-----------------------------------|
| Frontend        | Flutter + Dart                    |
| State Management| Provider                          |
| PDF Viewer      | `syncfusion_flutter_pdfviewer`, `pdfx` |
| Image Viewer    | `photo_view`                      |
| Sharing         | `share_plus`                      |
| HTTP/Assets     | `dio`, `path_provider`            |
| UI Utilities    | `flutter_screenutil`, `google_nav_bar` |
| Notifications   | (Planned) Firebase Cloud Messaging|
| Backend         | (Planned) PHP/Python (TBD)        |
| Database        | (Planned) MySQL/PostgreSQL (TBD)  |

---

## 📁 Project Structure

```
App/
  ├── lib/
  │   ├── main.dart
  │   ├── pages/
  │   │   ├── gr_list.dart           # GR List page (navigated to from expandable department list)
  │   │   ├── sub_sub_departments.dart # Expandable department list
  │   │   └── ...
  │   ├── reusable_or_snipit_widgets/
  │   └── splash_screen.dart
  ├── assets/
  │   ├── data/
  │   ├── fonts/
  │   └── images/
  ├── android/
  ├── ios/
  ├── pubspec.yaml
  └── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.7.2)
- Android Studio or Xcode for device emulation
- Internet connection for package installation

### Installation

1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd forrest_department_gr_and_updatees_app/App
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

### Assets

- All images, PDFs, and data are located in the `assets/` directory and registered in `pubspec.yaml`.

---

## 🛠️ Development Notes

- **State Management:** Uses Provider for scalable state handling.
- **Responsive UI:** Uses `flutter_screenutil` for adaptive sizing.
- **PDF/Image Viewing:** Supports both asset and (planned) network-based documents.
- **Offline Support:** Bundled assets for basic offline access.
- **Planned Features:** Backend integration, push notifications, advanced search/filter, multi-language support.

---

## 📄 Legal & Policies

- **Privacy Policy:** See `PrivacyPolicies` page in-app.
- **Terms & Conditions:** See `TermsAndConditions` page in-app.
- **Refund Policy:** See `RefundPolicies` page in-app.
- **Disclaimer:** See `DisclaimerPolicies` page in-app.

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## 📧 Contact

For support or business inquiries, contact the Alpha Developer Team.

---

## 📝 License

This project is proprietary and intended for use by the Forest Department and authorized personnel only.
