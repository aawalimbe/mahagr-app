# Forest Department GR & Updates App

**Client:** Rahul Sapkal, RFO  
**Prepared By:** Akshay – Alpha Developer Team  
**Date:** 30 Nov 2024  
**Last Updated:** January 2025

---

## 📱 Project Overview

This Flutter-based mobile application enables Forest Department staff and stakeholders to access Government Regulations (GRs), law updates, and official communications in various formats (PDF, text, images). The app is designed for cross-platform use (Android/iOS/Web/Desktop), with a focus on speed, clarity, and accessibility. The project includes a complete PHP backend API for user management and document handling.

---

## 🎯 Key Features

### ✅ **Implemented Features**

- **User Authentication:** Secure login and registration with form validation and PHP backend integration
- **Password Management:** Forgot password functionality with email-based reset and secure password updates
- **Department Selection:** Users can select their department and district for personalized content
- **Home Feed:** Grid-based navigation to categorized content (PDFs, images, text)
- **Content Viewer:** In-app PDF and image viewing, with options to share and download documents
- **Document Management:** Upload, update, delete, and manage documents with proper access controls
- **Document Upload System:** Complete form-based document submission with file picker, validation, and server upload
- **Expandable Department List:** On the sub-sub-departments page, each department row can be expanded to show all departments with their respective logos
- **Profile Management:** Edit and update user profile information
- **Policy & Legal Info:** In-app access to privacy policy, terms, refund, and disclaimer pages
- **Contact & Support:** Contact us page and suggestion submission system
- **Document Sharing:** Share documents with other users and track shared documents
- **Saved Documents:** Bookmark and save frequently accessed documents
- **Notifications System:** Custom notifications and system notifications for updates
- **Modern UI:** Clean, responsive design with custom themes and scalable typography
- **Offline Assets:** Bundled images, PDFs, and data for offline access
- **PHP Backend API:** Complete backend system for user management, document handling, and data persistence
- **Admin Panel:** Administrative interface for user and content management
- **Multi-language Support:** English and Marathi language support
- **Theme Support:** Light and dark theme modes

### 🚧 **In Progress**

- **Advanced Notifications:** Enhanced push notification system with user preferences
- **Document Versioning:** Track document changes and maintain version history

### 📋 **Planned Features**

- Advanced search and filtering capabilities
- User activity tracking and analytics
- Bulk document operations
- Real-time collaboration features
- Advanced security features (2FA, biometric authentication)

---

## 🧭 App Flow

```
Start Page → Welcome Page → Splash Screen → Login/Registration
    ↓
Department Selection → Home Page
    ↓
Department Grid → Sub Departments → Sub-Sub Departments → Expandable List → GR List → Document Viewer
    ↓
[PDF Viewer / Image Viewer] → Share/Download/Save Options
```

### **Home Page Navigation Structure**

The Home Page serves as the central hub with **4 main navigation areas**:

1. **Department Grid (Main Content)**
   - 3x3 Grid Layout displaying department logos and names
   - Navigation Flow: Home → Department Grid → Sub Departments → Sub-Sub Departments → Expandable List → GR List → Document Viewer
   - Features: Search functionality, date filtering, expandable department rows

2. **Home Page Band (Top Bar)**
   - Notifications: Access to system notifications
   - Language Toggle: Switch between English and Marathi
   - Theme Toggle: Change app appearance
   - Share App: Share the application

3. **Hamburger Menu (Left Drawer)**
   - Profile Management: Edit Profile, Saved Documents
   - Legal Pages: Privacy Policies, Refund Policies, Terms & Conditions, Disclaimer
   - Support: Contact Us

4. **App Bar More Menu (Top Right)**
   - Customs Notifications: Custom notification system
   - Give Suggestions: Submit feedback and suggestions
   - Upload Documents: Document upload functionality

---

## 🎨 Theme and Design Language

| Element     | Color Code         |
|-------------|-------------------|
| Primary     | Forest Green `#228B22` |
| Secondary   | Dark Grey `#333333`    |
| Background  | White `#FFFFFF`        |

- **Typography:** Clean, high-contrast fonts (OpenSans) for readability in outdoor environments
- **Icons:** Material icons for navigation and actions
- **Responsive Design:** Uses `flutter_screenutil` for adaptive sizing across different screen sizes

---

## 🔧 Tech Stack

| Layer           | Technology                        | Status |
|-----------------|-----------------------------------|---------|
| Frontend        | Flutter + Dart                    | ✅ Complete |
| State Management| Provider                          | ✅ Complete |
| PDF Viewer      | `syncfusion_flutter_pdfviewer`, `pdfx` | ✅ Complete |
| Image Viewer    | `photo_view`                      | ✅ Complete |
| Sharing         | `share_plus`                      | ✅ Complete |
| HTTP/Assets     | `dio`, `http`, `path_provider`    | ✅ Complete |
| UI Utilities    | `flutter_screenutil`, `google_nav_bar` | ✅ Complete |
| File Handling   | `file_picker`, `shared_preferences` | ✅ Complete |
| Backend         | PHP + MySQL                       | ✅ Complete |
| Database        | MySQL                             | ✅ Complete |
| API Framework   | Custom PHP API                    | ✅ Complete |

---

## 📁 Project Structure

```
mahagr-app/
├── lib/
│   ├── main.dart                    # Main app entry point
│   ├── splash_screen.dart           # App launch screen
│   ├── test_connection.dart         # Network connectivity testing
│   ├── pages/                       # App screens and pages
│   │   ├── start_page.dart          # App initialization
│   │   ├── welcome_page.dart        # Welcome screen
│   │   ├── login_Page.dart          # User authentication
│   │   ├── registration.dart        # User registration
│   │   ├── forgot_password.dart     # Password recovery
│   │   ├── deptselection_page.dart  # Department selection
│   │   ├── home_page.dart           # Main dashboard
│   │   ├── sub_dept.dart            # Sub-departments
│   │   ├── sub_sub_departments.dart # Expandable department list
│   │   ├── gr_list.dart             # GR List page
│   │   ├── pdf_viewer.dart          # PDF document viewer
│   │   ├── img_viewer.dart          # Image viewer
│   │   ├── edit_profile.dart        # Profile management
│   │   ├── contact_us.dart          # Contact information
│   │   ├── give_sugg.dart           # Suggestion submission
│   │   ├── saved_docs.dart          # Saved documents
│   │   ├── share_doc.dart           # Document upload and sharing
│   │   ├── notification_page.dart   # Notifications
│   │   ├── customs_notifictions.dart # Custom notifications
│   │   ├── terms_and_conditions.dart # Terms page
│   │   ├── privacy_policies.dart    # Privacy policy
│   │   ├── refund_policies.dart     # Refund policy
│   │   └── disclaimer_policies.dart # Disclaimer
│   └── reusable_or_snipit_widgets/  # Shared components
│       ├── api_service.dart         # HTTP client and API calls
│       ├── api_list.dart            # API endpoint definitions
│       ├── app_config.dart          # App configuration
│       ├── appbar.dart              # Custom app bar
│       ├── colors.dart              # Color definitions
│       ├── custom_scaffold.dart     # Custom scaffold widget
│       ├── hamburger_menu.dart      # Navigation menu
│       ├── home_page_band.dart      # Home page header
│       ├── language_provider.dart   # Language management
│       ├── theme_provider.dart      # Theme management
│       └── viewer_bottomNevigator.dart # Viewer navigation
├── api/                             # PHP Backend API
│   ├── login.php                    # User authentication
│   ├── register.php                 # User registration
│   ├── password_reset.php           # Password reset
│   ├── password_update.php          # Password update
│   ├── users.php                    # User management
│   ├── admin_users.php              # Admin user management
│   ├── admin_login.php              # Admin authentication
│   ├── documents.php                # Document handling
│   ├── document_upload.php          # Document upload
│   ├── document_details.php         # Document information
│   ├── update_document.php          # Document updates
│   ├── delete_document.php          # Document deletion
│   ├── download_document.php        # Document download
│   ├── document_access_logs.php     # Access tracking
│   ├── share_document.php           # Document sharing
│   ├── shared_document.php          # Shared documents
│   ├── departments.php              # Department data
│   ├── districts.php                # District data
│   ├── categories.php                # Category management
│   ├── add_category.php             # Add categories
│   ├── update_category.php          # Update categories
│   ├── delete_category.php          # Delete categories
│   ├── notifications.php            # Notification system
│   ├── suggestions.php              # User suggestions
│   ├── update_user_status.php       # User status management
│   ├── connect.inc.php              # Database connection
│   ├── core.inc.php                 # Core functions
│   ├── security_fixes.php           # Security enhancements
│   ├── API_DOCUMENTATION.md         # API documentation
│   ├── UPLOAD_FUNCTIONALITY.md      # Upload feature docs
│   └── uploads/                     # Document storage
├── assets/                          # App resources
│   ├── data/                        # Local JSON data
│   ├── fonts/                       # Custom fonts (OpenSans)
│   ├── images/                      # App images and icons
│   └── pdf_img_text/                # Sample documents
├── android/                         # Android-specific code
├── ios/                            # iOS-specific code
├── web/                            # Web platform support
├── windows/                        # Windows desktop support
├── linux/                          # Linux desktop support
├── macos/                          # macOS desktop support
├── pubspec.yaml                    # Flutter dependencies
├── maha_gr(2).sql                  # Database schema
├── subject_master(1).sql           # Subject master data
├── API_DOCUMENTATION.md            # API documentation
├── API_QUICK_REFERENCE.md          # Quick API reference
├── API_SETUP_GUIDE.md              # API setup guide
├── api_improvements.md             # API enhancement recommendations
└── NOTIFICATIONS_API_INTEGRATION.md # Notifications docs
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.7.2)
- [PHP](https://php.net/) (>=7.4) for backend API
- [MySQL](https://mysql.com/) (>=5.7) for database
- Android Studio or Xcode for device emulation
- Internet connection for package installation
- AMPPS/XAMPP/WAMP for local server (optional)

### Installation

#### 1. **Clone the Repository**
```bash
git clone https://github.com/aawalimbe/mahagr-app.git
cd mahagr-app
```

#### 2. **Flutter App Setup**
```bash
# Install dependencies
flutter pub get

# Verify Flutter installation
flutter doctor
```

#### 3. **Backend API Setup**

1. **Copy API files to your web server:**
   - Copy the `api/` folder to your web server directory (e.g., `C:\Program Files\Ampps\www\mahagrweb\api\`)

2. **Database Setup:**
   ```sql
   -- Create database
   CREATE DATABASE mahagr;
   
   -- Import schema
   -- Run maha_gr(2).sql in your MySQL database
   -- Run subject_master(1).sql for subject master data
   ```

3. **Configure Database Connection:**
   - Update `api/connect.inc.php` with your database credentials:
   ```php
   $host = 'localhost';
   $dbname = 'mahagr';
   $username = 'your_username';
   $password = 'your_password';
   ```

4. **Set File Permissions:**
   - Ensure the `api/uploads/` directory has write permissions (chmod 755 or 777)

#### 4. **App Configuration**

Update `lib/reusable_or_snipit_widgets/app_config.dart` with your API base URL:

```dart
// For Android Emulator
static const String _devBaseUrl = 'http://10.0.2.2/mahagrweb/api/';

// For Physical Device (use your computer's IP)
static const String _devBaseUrl = 'http://192.168.1.42/mahagrweb/api/';

// For Production
static const String _productionBaseUrl = 'https://mahagralert.com/crm/api/';
```

**Finding Your IP Address:**
- Windows: Run `ipconfig` in CMD
- Mac/Linux: Run `ifconfig` in Terminal

#### 5. **Run the App**
```bash
# Run on connected device/emulator
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release
```

---

## 📡 API Configuration

### Environment Setup

The app supports multiple environments:

- **Development:** Local development with emulator/physical device
- **Production:** Live server deployment

### API Base URLs

| Environment | URL | Usage |
|------------|-----|-------|
| Android Emulator | `http://10.0.2.2/mahagrweb/api/` | Default for emulator |
| Physical Device | `http://YOUR_IP/mahagrweb/api/` | Use your computer's IP |
| Production | `https://mahagralert.com/crm/api/` | Live server |

### Testing on Different Devices

1. **Android Emulator:** Use `http://10.0.2.2/mahagrweb/api/`
2. **Physical Android Device:** Use your computer's IP address
3. **iOS Simulator:** Use `http://localhost/mahagrweb/api/`
4. **Physical iOS Device:** Use your computer's IP address

See `API_SETUP_GUIDE.md` for detailed configuration instructions.

---

## 📊 Database Schema

The app uses a MySQL database with the following main tables:

- `users` - User accounts and profiles
- `admin_users` - Admin user accounts
- `departments` - Department information
- `districts` - District data
- `categories` - Document categories
- `documents` - Document metadata and files
- `document_shares` - Document sharing records
- `document_access_logs` - Document access tracking
- `notifications` - User notifications
- `suggestions` - User feedback
- `audit_logs` - System audit logs

See `maha_gr(2).sql` for complete database schema.

---

## 🔒 Security Features

- Password hashing using MD5 (⚠️ **Security Alert:** Upgrade to bcrypt recommended - see `api_improvements.md`)
- Prepared statements to prevent SQL injection
- Input validation and sanitization
- User status management (Active/Inactive)
- Document access logging
- Admin role-based access control
- File upload validation (type and size)

### 🚨 **Security Recommendations**

Based on the comprehensive API improvement analysis (see `api_improvements.md`):

- **High Priority:** Upgrade password hashing from MD5 to bcrypt/Argon2
- **High Priority:** Implement CSRF protection and rate limiting
- **Medium Priority:** Add comprehensive input validation and sanitization
- **Medium Priority:** Implement API response standardization
- **Low Priority:** Add JWT token-based authentication

---

## 🐛 Recent Bug Fixes & Improvements

### **January 2025 - Login Authentication Fix**
- **Issue:** Wrong passwords were incorrectly navigating to home page
- **Root Cause:** PHP API was returning `status = 'false'` for successful logins
- **Fix:** Corrected PHP login logic and improved Flutter error handling
- **Files Modified:** `api/login.php`, `lib/pages/login_Page.dart`

### **API Service Improvements**
- Enhanced error handling with Dio HTTP client
- Better network connectivity testing
- Improved response parsing and validation
- Added comprehensive logging for debugging

### **New Features Added**
- Document sharing system
- Saved documents functionality
- Contact us and suggestions system
- Enhanced notification system
- Admin panel for user management

---

## 🛠️ Development Notes

- **State Management:** Uses Provider for scalable state handling
- **Responsive UI:** Uses `flutter_screenutil` for adaptive sizing
- **PDF/Image Viewing:** Supports both asset and network-based documents
- **Offline Support:** Bundled assets for basic offline access
- **Backend Integration:** Complete PHP API with MySQL database
- **Cross-Platform:** Supports Android, iOS, Web, Windows, Linux, and macOS
- **File Handling:** Supports document upload, download, and sharing
- **Security:** Implements proper authentication and authorization

---

## 📄 Legal & Policies

- **Privacy Policy:** See `PrivacyPolicies` page in-app
- **Terms & Conditions:** See `TermsAndConditions` page in-app
- **Refund Policy:** See `RefundPolicies` page in-app
- **Disclaimer:** See `DisclaimerPolicies` page in-app

---

## 🧪 Testing

### **Tested Scenarios**
- ✅ User registration and login
- ✅ Password reset and update
- ✅ Department and district selection
- ✅ Document viewing (PDF, images)
- ✅ Document upload and management
- ✅ Document sharing and collaboration
- ✅ Profile management
- ✅ Contact and suggestions
- ✅ Error handling for invalid credentials
- ✅ Cross-platform compatibility
- ✅ Admin panel functionality

---

## 🚀 Deployment

### **Mobile Apps**
```bash
# Android Debug APK
flutter build apk --debug

# Android Release APK
flutter build apk --release

# iOS (requires Xcode)
flutter build ios --release
```

### **Web App**
```bash
flutter build web
# Deploy to any web hosting service
```

### **Desktop Apps**
```bash
# Windows
flutter build windows

# Linux
flutter build linux

# macOS
flutter build macos
```

---

## 📚 Additional Documentation

- **API Documentation:** See `API_DOCUMENTATION.md` for detailed API reference
- **Quick Reference:** See `API_QUICK_REFERENCE.md` for common API calls
- **Setup Guide:** See `API_SETUP_GUIDE.md` for backend setup
- **API Improvements:** See `api_improvements.md` for enhancement recommendations
- **Upload Features:** See `api/UPLOAD_FUNCTIONALITY.md` for document upload details
- **Notifications:** See `NOTIFICATIONS_API_INTEGRATION.md` for notification system

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

### **Development Guidelines**
- Follow Flutter best practices
- Use meaningful commit messages
- Test on multiple platforms before submitting
- Update documentation for new features
- Follow consistent naming conventions
- Add error handling for non-trivial logic
- Keep code efficient and token-optimized

---

## 📧 Contact

For support or business inquiries, contact the Alpha Developer Team.

---

## 📝 License

This project is proprietary and intended for use by the Forest Department and authorized personnel only.

---

## 📈 Project Status

**Overall Progress: 95% Complete**

- ✅ **Core App Features:** 100%
- ✅ **Backend API:** 100%
- ✅ **Database:** 100%
- ✅ **Authentication:** 100%
- ✅ **Document Management:** 100%
- ✅ **User Management:** 100%
- ✅ **Document Sharing:** 100%
- ✅ **Contact & Support:** 100%
- ✅ **API Documentation:** 100%
- ✅ **API Enhancement Plan:** 100%
- 🚧 **Notifications:** 85%
- 🚧 **Multi-language:** 40%
- 📋 **Advanced Features:** 25%

**Next Milestone:** Implement API security improvements (password hashing upgrade), complete notification system, and enhance multi-language support

---

## 🏗️ Build Requirements

- **Flutter SDK:** >=3.7.2
- **Dart SDK:** Included with Flutter
- **Android:** Minimum SDK 21, Target SDK 33+
- **iOS:** iOS 12.0+
- **PHP:** >=7.4
- **MySQL:** >=5.7

---

## ⚠️ Troubleshooting

### Common Issues

1. **"No internet connection" error**
   - Check if your server is running
   - Verify the IP address is correct in `app_config.dart`
   - Ensure both device and computer are on same network

2. **"Connection timeout" error**
   - Check firewall settings
   - Verify server is accessible from device
   - Try using computer's IP instead of localhost

3. **"Server error"**
   - Check server logs
   - Verify API endpoints are working
   - Test with Postman or browser

4. **Build errors on Windows**
   - Enable Developer Mode for symlink support
   - Run: `start ms-settings:developers`

5. **Database connection errors**
   - Verify database credentials in `api/connect.inc.php`
   - Ensure MySQL service is running
   - Check database exists and tables are created

---

**Last Updated:** January 2025  
**Version:** 1.0.0+1
