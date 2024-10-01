# Flutter Boilerplate Project

This Flutter project serves as a boilerplate for building scalable, maintainable apps using the **Provider** architecture. It includes a basic app structure with commonly used features like **sample screens**, **custom widgets**, **localization**, **API integration** using Dio and Retrofit, **theme switching**, and **push notification services**.

## Features

### 1. **Provider Structure**
   The project follows the **Provider** architecture to manage app-wide states, including theme switching (light/dark mode) and localization.

### 2. **Sample Screens**
   The project comes with two sample screens:
   - **Splash Screen**: Displays the app logo and transitions to the login screen.
   - **Login Screen**: A simple login form with validation and navigation.

### 3. **Custom Widgets**
   Several reusable custom widgets are included to speed up UI development:
   - **Common AppBar**
   - **Bottom Sheet**
   - **Custom Button**
   - **Custom Dialog**
   - **Custom TextField**
   - **Loader**
   - **Logout Dialog**
   
   These components are designed to be easily customizable and reusable across various screens.

### 4. **Localization**
   The project supports **localization** with multiple language support built-in. Language selection is managed using a `LocaleProvider`.

### 5. **API Service Integration**
   API calls are handled using **Dio** and **Retrofit**, with `retrofit_generator` for generating the API services. To make changes in the API service structure, follow these steps:
   - Modify the `url.dart` or `network_service.dart` files.
   - Run the following command to generate updated API services:
    
     dart run build_runner build --delete-conflicting-outputs
    
   - Run the following command as soon as you open IDE to automatically update API  services:  
    
    dart run build_runner watch --delete-conflicting-outputs
    

### 6. **Toastification Wrapper**
   The app is wrapped with the **ToastificationWrapper** to handle all toast messages. Use this wrapper to display toasts across the app with minimal setup.

### 7. **Light/Dark Theme Support**
   **Provider** is used to handle **theme switching** between light and dark modes. The current theme state is managed globally and can be switched easily within the app.

### 8. **Push Notification Service**
   The project includes support for **push notifications**. Notifications are handled in all three states:
   - **Foreground**: Notifications are displayed as in-app alerts.
   - **Background**: Notifications trigger app-specific behavior upon tapping.
   - **Terminated**: The app responds to notifications even when not running.

   Make sure to add the following configuration files for push notifications to work:
   - **Android**: `google_service.json`
   - **iOS**: `GoogleService-Info.plist`

   Also, don't forget to update the `firebase_options.dart` file with your Firebase configuration details.

9. **API Interceptor for Refresh Token Handling**
   - The project includes an API interceptor for automatically refreshing tokens when the access token expires. This functionality is implemented using Dio.

    *Setting Up the Refresh Token Interceptor*
   - The interceptor listens for 401 (Unauthorized) responses and automatically attempts to refresh the token. Upon successful token refresh, it retries the original request.

    *Here’s a summary of how the interceptor works:*

   - Intercepts all API requests and responses.
   - When a 401 error is detected, it attempts to refresh the access token using the refresh token.
   - If the refresh token is valid, the interceptor retries the original request with the new access token.
   - In case the refresh token is expired, the user is logged out, and they are redirected to the login screen.

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase configuration for push notifications

### Setup

1. **Clone the repository**:

   git clone https://github.com/your-repo/flutter-boilerplate.git
    

2. **Install dependencies**:

    flutter pub get

3. **Set up Firebase**:

   - Add the google_service.json file to the Android app directory.
   - Add the GoogleService-Info.plist file to the iOS app directory.
   - Update the firebase_options.dart file with your Firebase project details.

4. **Generate API services if required**:

    dart run build_runner build --delete-conflicting-outputs

5. **Run the app**:
    
    flutter run


### Project Structure ###

lib/
├── data
│   ├── api_service
│   │   ├── api_error_handler.dart
│   │   ├── api_service.dart
│   │   ├── api_service_helper.dart
│   │   ├── interceptors_config.dart
│   │   ├── network_service.dart
│   │   └── network_service.g.dart
│   └── models
├── domain
│   └── providers
│       ├── auth
│       │   └── auth_provider.dart
│       ├── locale_provider.dart
│       └── theme_provider.dart
├── l10n
│   └── intl_en.arb
├── main.dart
├── notification_service
│   ├── firebase_options.dart
│   └── notification_service.dart
├── presentation
│   ├── screens
│   │   ├── auth
│   │   │   ├── login
│   │   │   │   ├── login_form_field.dart
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── login_title.dart
│   │   │   │   ├── mobile_no_textfield.dart
│   │   │   │   ├── terms_and_conditions_screen.dart
│   │   │   │   ├── tnc_pp_text.dart
│   │   │   │   └── verify_button.dart
│   │   │   ├── otp_verification
│   │   │   │   ├── otp_screen.dart
│   │   │   │   ├── otp_textfield.dart
│   │   │   │   ├── otp_titie.dart
│   │   │   │   ├── resend_otp_button.dart
│   │   │   │   ├── sms_retriever.dart
│   │   │   │   └── verify_otp_button.dart
│   │   │   └── validators
│   │   │       ├── mobile_no_validator.dart
│   │   │       └── otp_validator.dart
│   │   └── splash
│   │       └── splash_screen.dart
│   └── widgets
│       ├── common_appbar.dart
│       ├── common_bottomsheet.dart
│       ├── custom_button.dart
│       ├── custom_dialog.dart
│       ├── custom_textfield.dart
│       ├── loader.dart
│       └── logout_dialog.dart
└── shared
    ├── constants
    │   ├── colors.dart
    │   ├── images.dart
    │   ├── miscellaneous.dart
    │   ├── themes.dart
    │   └── uri.dart
    ├── navigation
    │   ├── app_router.dart
    │   ├── navigation_types.dart
    │   ├── routes.dart
    │   └── transition.dart
    ├── shared_preferences
    │   └── shared_preference.dart
    └── utils
        ├── clear_app_data.dart
        ├── https_override.dart
        ├── responsive_manager.dart
        ├── textstyles
        │   ├── bold_textstyles.dart
        │   ├── extra_bold_textstyles.dart
        │   ├── medium_textstyles.dart
        │   ├── regular_textstyles.dart
        │   └── semi_bold_textstyles.dart
        └── toasts.dart

### Additional Notes ###
- Ensure that your Firebase configurations are up-to-date.
- Use the ToastificationWrapper for handling toast messages throughout the app.
- API services are generated using build_runner and retrofit_generator.
- Run the build command after any changes to API files.

### Contributing ###
*Feel free to submit a pull request if you have any improvements or bug fixes!*
