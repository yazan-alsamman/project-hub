# 🔄 إعداد Refresh Token

## ✅ تم الربط

تم ربط refresh token endpoint بنجاح!

---

## 📋 تفاصيل الـ API

### Endpoint:
```
POST /user/refresh
```

### Request Body:
```json
{
  "refreshToken": "{{refreshToken}}"
}
```

### Response:
```json
{
  "success": true,
  "message": "Token refreshed successfully",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "8d389bf53492e5d44ea316eb926458d2..."
  }
}
```

---

## 🔧 التحديثات المطبقة

### 1. تم تحديث `ApiConstant`:
```dart
static const String refreshToken = '/user/refresh';
```

### 2. تم تحديث `AuthRepository.refreshToken()`:
- ✅ يستخدم endpoint الجديد
- ✅ يرسل `refreshToken` في body
- ✅ يقرأ `token` و `refreshToken` من response
- ✅ يحفظ الـ tokens الجديدة تلقائياً

### 3. تم إضافة helper method في `AuthService`:
```dart
Future<void> updateTokens({
  required String token,
  String? refreshToken,
}) async
```

---

## 💻 كيفية الاستخدام

### في Controller:

```dart
import 'package:junior/data/repository/auth_repository.dart';

class MyController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> refreshToken() async {
    final result = await _authRepository.refreshToken();
    
    result.fold(
      (error) {
        // Handle error
        print('Failed to refresh token: $error');
        // Redirect to login if refresh fails
      },
      (data) {
        // Token refreshed successfully
        print('Token refreshed successfully');
        // Continue with your operation
      },
    );
  }
}
```

---

## 🔄 استخدام تلقائي (Automatic Refresh)

يمكن استخدام refresh token تلقائياً عند فشل الطلب بسبب expired token (401).

### مثال في ApiService:

```dart
// في _handleResponse method
case 401:
  // Token expired, try to refresh
  final refreshResult = await _authRepository.refreshToken();
  return refreshResult.fold(
    (error) {
      // Refresh failed, logout user
      _authService.logout();
      return const Left(StatusRequest.serverFailure);
    },
    (data) {
      // Token refreshed, retry original request
      // (implementation depends on your needs)
      return const Left(StatusRequest.serverFailure);
    },
  );
```

---

## 📝 مثال كامل

```dart
import 'package:junior/data/repository/auth_repository.dart';
import 'package:junior/core/services/auth_service.dart';

class ExampleController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final AuthService _authService = AuthService();

  Future<void> makeApiCall() async {
    // Try to make API call
    // If it fails with 401, refresh token
    
    final refreshResult = await _authRepository.refreshToken();
    
    refreshResult.fold(
      (error) {
        // Refresh failed - user needs to login again
        Get.offNamed('/login');
      },
      (response) {
        // Token refreshed - retry API call
        // ... retry your API call here
      },
    );
  }
}
```

---

## ✅ التحقق من العمل

### اختبار يدوي:

1. **احصل على refresh token بعد login:**
   - بعد تسجيل الدخول، احفظ refresh token

2. **استخدم refresh token:**
   ```dart
   final result = await authRepository.refreshToken();
   ```

3. **تحقق من Console logs:**
   - يجب أن ترى: `🔄 Refresh token called`
   - ثم: `✅ Tokens refreshed successfully`

---

## 🔍 Debug Logs

عند استدعاء refresh token، سترى في Console:

```
🔄 Refresh token called
🔵 Calling refresh token API...
🟢 Refresh token response received
Response keys: [success, message, data]
Data keys: [token, refreshToken]
✅ Tokens refreshed successfully
```

---

## ⚠️ ملاحظات مهمة

1. **Refresh Token يجب أن يكون صالح:**
   - إذا انتهت صلاحية refresh token، يجب إعادة تسجيل الدخول

2. **حفظ الـ Tokens:**
   - الـ tokens الجديدة تُحفظ تلقائياً بعد refresh
   - لا حاجة لحفظها يدوياً

3. **Error Handling:**
   - عند فشل refresh، يجب توجيه المستخدم لتسجيل الدخول مرة أخرى

---

## 📚 الملفات المعدلة

1. ✅ `lib/core/constant/api_constant.dart` - تحديث endpoint
2. ✅ `lib/data/repository/auth_repository.dart` - تحديث refreshToken method
3. ✅ `lib/core/services/auth_service.dart` - إضافة updateTokens method

---

## 🎯 الخطوة التالية

يمكنك الآن:
- ✅ استخدام `authRepository.refreshToken()` في أي مكان
- ✅ إضافة automatic refresh عند 401
- ✅ إضافة interceptor لتحديث token تلقائياً

---

## 💡 مثال متقدم: Automatic Refresh

يمكن إضافة interceptor في ApiService:

```dart
// في ApiService
Future<Either<StatusRequest, Map<String, dynamic>>> post(...) async {
  // ... make request
  
  final response = await http.post(...);
  
  // Check if 401 (Unauthorized)
  if (response.statusCode == 401) {
    // Try to refresh token
    final refreshResult = await AuthRepository().refreshToken();
    
    if (refreshResult.isRight()) {
      // Token refreshed, retry request
      final newResponse = await http.post(...);
      return _handleResponse(newResponse);
    } else {
      // Refresh failed, logout
      await _authService.logout();
      return const Left(StatusRequest.serverFailure);
    }
  }
  
  return _handleResponse(response);
}
```

---

## ✅ جاهز للاستخدام!

الآن refresh token جاهز ومربوط. جرّب استدعاء `refreshToken()` بعد تسجيل الدخول!

