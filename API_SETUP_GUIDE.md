# API Setup Guide

## Testing on Different Devices

### 1. Android Emulator
- Use: `http://10.0.2.2/mahagrweb/api/`
- This is already configured in `AppConfig.baseUrl`

### 2. Physical Android Device
- Find your computer's IP address:
  - Windows: Run `ipconfig` in CMD
  - Mac/Linux: Run `ifconfig` in Terminal
- Update `AppConfig._physicalDeviceUrl` with your computer's IP
- Example: `http://192.168.1.100/mahagrweb/api/`

### 3. iOS Simulator
- Use: `http://localhost/mahagrweb/api/`
- Update `AppConfig._devBaseUrl` to use localhost

### 4. Physical iOS Device
- Same as Android physical device
- Use your computer's IP address

## Quick Configuration Changes

### For Android Emulator (Default)
```dart
// In lib/reusable_or_snipit_widgets/app_config.dart
static const String _devBaseUrl = 'http://10.0.2.2/mahagrweb/api/';
```

### For Physical Device
```dart
// In lib/reusable_or_snipit_widgets/app_config.dart
static const String _devBaseUrl = 'http://YOUR_COMPUTER_IP/mahagrweb/api/';
```

### For Local Development
```dart
// In lib/reusable_or_snipit_widgets/app_config.dart
static const String _devBaseUrl = 'http://localhost/mahagrweb/api/';
```

## Troubleshooting

1. **"No internet connection" error**
   - Check if your server is running
   - Verify the IP address is correct
   - Ensure both device and computer are on same network

2. **"Connection timeout" error**
   - Check firewall settings
   - Verify server is accessible from device
   - Try using computer's IP instead of localhost

3. **"Server error"**
   - Check server logs
   - Verify API endpoints are working
   - Test with Postman or browser

## Testing Steps

1. Start your local server (AMPPS/XAMPP/WAMP)
2. Verify API is accessible: `http://localhost/mahagrweb/api/departments.php`
3. Update `AppConfig._devBaseUrl` with correct IP
4. Run the Flutter app
5. Try registration

## Current Configuration
- Base URL: `http://10.0.2.2/mahagrweb/api/` (Android Emulator)
- Timeout: 30 seconds
- Debug logging: Enabled
