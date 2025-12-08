# 🚪 إعداد Logout

## ✅ تم الربط

تم ربط logout endpoint بنجاح!

---

## 📋 تفاصيل الـ API

### Endpoint:
```
POST /user/logout
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
  "message": "Logged out successfully"
}
```

---

## 🔧 التحديثات المطبقة

### 1. ✅ تم تحديث Endpoint في `ApiConstant`:
```dart
static const String logout = '/user/logout';
```

### 2. ✅ تم تحديث `AuthRepository.logout()`:
- ✅ يرسل `refreshToken` في body
- ✅ يحاول استدعاء الـ API أولاً
- ✅ ينظف البيانات المحلية دائماً (حتى لو فشل الـ API)
- ✅ يعيد `true` دائماً لضمان تسجيل الخروج المحلي

### 3. ✅ تم تحديث `CustomDrawer`:
- ✅ يستخدم `authRepository.logout()` بدلاً من الانتقال مباشرة
- ✅ ينتقل إلى login بعد logout

---

## 💻 كيفية الاستخدام

### في أي Controller:

```dart
import 'package:junior/data/repository/auth_repository.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> logout() async {
    final result = await _authRepository.logout();
    
    result.fold(
      (error) {
        // حتى لو فشل الـ API، البيانات المحلية منُظفة
        Get.offAllNamed(AppRoute.login);
      },
      (success) {
        // تسجيل الخروج نجح
        Get.offAllNamed(AppRoute.login);
      },
    );
  }
}
```

---

## 🔍 كيف يعمل

1. **يحصل على refreshToken:**
   - من `AuthService.getRefreshToken()`
   
2. **يرسل request للـ API:**
   - POST `/user/logout`
   - Body: `{ "refreshToken": "..." }`

3. **ينظف البيانات المحلية:**
   - يحذف token
   - يحذف refreshToken
   - يحذف user data
   - **هذا يحدث دائماً حتى لو فشل الـ API**

4. **ينتقل إلى login:**
   - يستخدم `Get.offAllNamed(AppRoute.login)`

---

## ✅ المميزات

- ✅ **Logout المحلي مضمون:** حتى لو فشل الـ API، البيانات المحلية تُحذف
- ✅ **إرسال refreshToken:** لإلغاء تفعيل الـ token على الـ server
- ✅ **Debug logs:** لتتبع عملية logout
- ✅ **Error handling:** معالجة شاملة للأخطاء

---

## 🔍 Debug Logs

عند استدعاء logout، سترى في Console:

```
🚪 Logout called
🔵 Sending logout request with refreshToken
✅ Local authentication data cleared
🟢 Logout API response received
Response keys: [success, message]
✅ Logout successful
```

---

## 📝 الملفات المعدلة

1. ✅ `lib/core/constant/api_constant.dart` - تحديث endpoint
2. ✅ `lib/data/repository/auth_repository.dart` - تحديث logout method
3. ✅ `lib/view/widgets/common/custom_drawer.dart` - استخدام logout method

---

## 🎯 الاستخدام الحالي

### في CustomDrawer:

عند الضغط على "Logout" في Drawer:
1. يتم استدعاء `authRepository.logout()`
2. يتم إرسال refreshToken للـ API
3. يتم تنظيف البيانات المحلية
4. يتم الانتقال إلى صفحة login

---

## 💡 ملاحظات

1. **Logout المحلي أولوية:**
   - حتى لو فشل الـ API، البيانات المحلية تُحذف دائماً
   - هذا يضمن أن المستخدم لا يبقى مسجلاً محلياً

2. **refreshToken اختياري:**
   - إذا لم يكن هناك refreshToken، يتم إرسال request بدون body
   - Logout المحلي يحدث دائماً

3. **Error Handling:**
   - جميع الأخطاء يتم معالجتها
   - المستخدم يُنقل دائماً إلى login

---

## ✅ جاهز!

الآن logout يعمل بشكل صحيح:
- ✅ يرسل refreshToken للـ API
- ✅ ينظف البيانات المحلية
- ✅ ينقل المستخدم إلى login

🎉

