# إعداد التطبيق للجهاز الحقيقي

## المشكلة

عند استخدام التطبيق على جهاز حقيقي، لا يمكن استخدام `localhost` أو `10.0.2.2` للاتصال بالـ server المحلي. يجب استخدام **IP address الفعلي** للكمبيوتر الذي يعمل عليه الـ server.

## الحل: إضافة IP Address للكمبيوتر

### الخطوة 1: معرفة IP Address للكمبيوتر

#### على Windows:
1. افتح **Command Prompt** (CMD)
2. اكتب: `ipconfig`
3. ابحث عن **IPv4 Address** تحت **Wireless LAN adapter Wi-Fi** أو **Ethernet adapter**
4. مثال: `192.168.1.100`

#### على Mac/Linux:
1. افتح **Terminal**
2. اكتب: `ifconfig` (أو `ipconfig getifaddr en0` على Mac)
3. ابحث عن **inet** تحت **en0** أو **wlan0**
4. مثال: `192.168.1.100`

### الخطوة 2: تحديث Base URL

#### الطريقة 1: تحديث في الكود (موصى به للاختبار)

افتح ملف `lib/core/constant/api_constant.dart` وعدّل:

```dart
static const String _customBaseUrl = 'http://192.168.1.100:5000'; // ضع IP address هنا
```

#### الطريقة 2: ضبط ديناميكي (موصى به للإنتاج)

يمكن إضافة IP address من خلال الإعدادات في التطبيق أو من خلال متغير environment.

### الخطوة 3: التأكد من أن الـ Server يعمل

تأكد من:
- ✅ الـ server يعمل على المنفذ 5000
- ✅ الـ firewall يسمح بالاتصالات على المنفذ 5000
- ✅ الكمبيوتر والجهاز الحقيقي على نفس الـ Network (WiFi)

### الخطوة 4: اختبار الاتصال

1. من الجهاز الحقيقي، افتح المتصفح
2. جرب الوصول إلى: `http://YOUR_IP_ADDRESS:5000/user/login`
3. إذا ظهرت صفحة أو خطأ من الـ server، فالاتصال يعمل ✅

## مثال

إذا كان IP address للكمبيوتر هو `192.168.1.100`:

```dart
static const String _customBaseUrl = 'http://192.168.1.100:5000';
```

## ملاحظات مهمة

1. **نفس الـ Network**: تأكد أن الكمبيوتر والجهاز الحقيقي على نفس شبكة WiFi
2. **الـ Firewall**: قد تحتاج إلى فتح المنفذ 5000 في Windows Firewall
3. **IP Address يتغير**: إذا غيرت الشبكة، سيتغير IP address

## حل سريع: استخدام Hotspot

إذا كان الاتصال لا يعمل:
1. استخدم هاتفك كـ Hotspot
2. اتصل بالكمبيوتر والجهاز الحقيقي على نفس الـ Hotspot
3. استخدم IP address من الشبكة الجديدة

## حل بديل: تعطيل التحقق من الإنترنت مؤقتاً

إذا كانت المشكلة في `checkInternet()`، يمكن تعطيلها مؤقتاً:

في `lib/core/services/api_service.dart`:
```dart
// Comment out this check temporarily
// if (!await checkInternet()) {
//   return const Left(StatusRequest.offlineFailure);
// }
```

لكن هذا **غير موصى به** للإنتاج.

