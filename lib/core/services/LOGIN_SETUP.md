# Login API Integration Setup

## تم ربط نظام تسجيل الدخول مع API

### Endpoint
```
POST http://localhost:5000/user/login
```

### Request Body
```json
{
  "username": "developer1",
  "password": "Dev@12345"
}
```

### Response Structure
```json
{
  "success": true,
  "message": "User login successfully",
  "data": {
    "user": {
      "_id": "692dd06b11888268af9a3598",
      "username": "developer1",
      "email": "dev1@company.com",
      "role": {
        "_id": "692dd06ab46338cdbad25c2e",
        "name": "developer",
        "description": "Developer - Can view and work on assigned projects and tasks"
      },
      "isActive": true,
      "lastLogin": "2025-12-01T17:33:52.736Z",
      "createdAt": "2025-12-01T17:29:15.810Z",
      "updatedAt": "2025-12-01T17:33:52.741Z",
      "__v": 0
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "e654d96497f8541d89031dd06b29a391..."
  }
}
```

## Changes Made

### 1. API Constants (`lib/core/constant/api_constant.dart`)
- ✅ Updated base URL to `http://localhost:5000`
- ✅ Changed login endpoint to `/user/login`
- ✅ Added automatic platform detection for Android Emulator (uses `10.0.2.2`)

### 2. Login Controller (`lib/controller/login_controller.dart`)
- ✅ Changed from `emailController` to `usernameController`
- ✅ Removed email validation (now accepts username)
- ✅ Updated login method to use username

### 3. Auth Repository (`lib/data/repository/auth_repository.dart`)
- ✅ Updated login method to send `username` instead of `email`
- ✅ Fixed response parsing to match API structure
- ✅ Extract user data from `data.user` instead of `data.user.id`
- ✅ Save token, refreshToken, and user information correctly

### 4. Auth Service (`lib/core/services/auth_service.dart`)
- ✅ Added `saveUsername()` method
- ✅ Added `saveUserRole()` method
- ✅ Updated `saveAuthData()` to include username and role
- ✅ Updated `logout()` to clear username and role

### 5. Login UI (`lib/view/screens/auth/login.dart`)
- ✅ Updated to use `usernameController` instead of `emailController`
- ✅ Changed hint text to "username"
- ✅ Connected login button to actual login method
- ✅ Added loading state handling

### 6. Input Fields Widget (`lib/view/widgets/login/inputfields.dart`)
- ✅ Changed icon from email to person icon
- ✅ Changed keyboard type from email to text

## Platform-Specific URLs

The app automatically uses the correct URL based on the platform:

- **Android Emulator**: `http://10.0.2.2:5000`
- **iOS Simulator**: `http://localhost:5000`
- **Web/Desktop**: `http://localhost:5000`

## Testing

### Test Credentials
```
Username: developer1
Password: Dev@12345
```

### Steps to Test
1. Open the login screen
2. Enter username: `developer1`
3. Enter password: `Dev@12345`
4. Click "Sign in"
5. Check that token is saved in shared preferences
6. Verify navigation to project dashboard after successful login

## Stored Data

After successful login, the following data is stored:

- ✅ `auth_token` - JWT token for API requests
- ✅ `refresh_token` - Refresh token for getting new access tokens
- ✅ `user_id` - User ID from `user._id`
- ✅ `user_email` - User email from `user.email`
- ✅ `username` - Username from `user.username`
- ✅ `user_role` - User role from `user.role.name`

## Next Steps

1. ✅ Test login functionality
2. ⏳ Add token refresh mechanism
3. ⏳ Update other API calls to use the saved token
4. ⏳ Add logout functionality
5. ⏳ Handle token expiration

## Notes

- The API endpoint uses `/user/login` not `/auth/login`
- Username is used instead of email for login
- Response structure has nested `data` object containing `user`, `token`, and `refreshToken`
- Token should be sent in Authorization header as `Bearer {token}`

