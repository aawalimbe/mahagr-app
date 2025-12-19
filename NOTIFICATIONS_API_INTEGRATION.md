# Notifications API Integration

## Overview
The notifications page has been successfully integrated with the backend API to fetch real-time notifications instead of using static JSON data.

## What Was Changed

### 1. API Service (`lib/reusable_or_snipit_widgets/api_service.dart`)
- Added `getNotifications()` method to fetch notifications from the backend
- Added `testNotificationsAPI()` method for testing the API connection
- Method supports optional `userId` parameter for future user-specific notifications

### 2. Notifications Page (`lib/pages/notification_page.dart`)
- Replaced static JSON loading with API calls
- Added proper error handling and loading states
- Implemented modern card-based UI for notifications
- Added refresh functionality
- Shows notification details including title, message, status, timestamps
- Links to related documents when available

### 3. Backend API (`api/notifications.php`)
- Changed from POST to GET method for better REST compliance
- Returns notifications ordered by timestamp (newest first)
- Currently returns all notifications (can be filtered by user_id later)

## Database Schema

The notifications table should have the following structure:
```sql
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `related_document_id` int(11) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `timestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`)
);
```

## Sample Data

Use the `api/sample_notifications.sql` file to populate the database with test notifications.

## Testing the Integration

### 1. Database Setup
```bash
# Import the sample data
mysql -u root -p mahagr < api/sample_notifications.sql
```

### 2. Test API Connection
```dart
// In your Flutter app, you can test the connection:
bool isConnected = await ApiService.testNotificationsAPI();
print('Notifications API connected: $isConnected');
```

### 3. Test Notifications Loading
```dart
// Fetch notifications
List<Map<String, dynamic>> notifications = await ApiService.getNotifications();
print('Found ${notifications.length} notifications');
```

## API Response Format

The API returns an array of notification objects:
```json
[
  {
    "notification_id": "1",
    "title": "New GR Released",
    "message": "A new Government Resolution has been released...",
    "related_document_id": "1",
    "scheduled_at": "2024-01-15 10:00:00",
    "sent_at": "2024-01-15 10:00:00",
    "status": "sent",
    "timestamp": "2024-01-15 10:00:00"
  }
]
```

## Features

### ✅ Implemented
- Real-time notifications from backend API
- Loading states and error handling
- Refresh functionality
- Modern card-based UI
- Status indicators (sent, pending, failed)
- Timestamp display
- Related document linking

### 🔄 Future Enhancements
- User-specific notifications filtering
- Push notifications
- Notification preferences
- Mark as read/unread
- Notification categories
- Real-time updates

## Troubleshooting

### Common Issues

1. **API Connection Failed**
   - Check if the backend server is running
   - Verify the API base URL in `app_config.dart`
   - Check database connection

2. **No Notifications Displayed**
   - Ensure the notifications table exists and has data
   - Check if notifications have status = 'sent'
   - Verify API response format

3. **Linter Errors**
   - Ensure all imports are correct
   - Check for missing dependencies
   - Run `flutter analyze` to identify issues

### Debug Steps

1. Check browser console for API errors
2. Verify database table structure
3. Test API endpoint directly (e.g., `http://localhost/mahagrweb/api/notifications.php`)
4. Check Flutter console for error messages

## API Endpoints

- **GET** `/api/notifications.php` - Fetch all notifications
- **Future:** `GET /api/notifications.php?user_id=123` - User-specific notifications

## Dependencies

- `dio` - HTTP client for API calls
- `flutter_screenutil` - Responsive UI scaling
- Custom widgets from `reusable_or_snipit_widgets/`

## Performance Considerations

- Notifications are limited to 50 most recent (configurable in API)
- API responses are cached in the app state
- Refresh functionality allows manual updates
- Error handling prevents app crashes on API failures
