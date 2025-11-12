# Custom App Bar Widget

## الوصف
شريط تنقل علوي مخصص يمكن إدراجه في جميع صفحات التطبيق. يحتوي على جميع العناصر المطلوبة مثل البحث والإشعارات وملف المستخدم.

## الميزات
- ✅ قائمة الهامبرغر (Hamburger Menu)
- ✅ شريط البحث مع placeholder
- ✅ أيقونة البحث
- ✅ جرس الإشعارات مع عداد الإشعارات
- ✅ أيقونة المستخدم مع قائمة منسدلة
- ✅ تصميم متجاوب
- ✅ قابل للتخصيص بالكامل

## كيفية الاستخدام

### الاستخدام الأساسي
```dart
import 'package:junior/view/widgets/common/custom_app_bar.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: YourContent(),
    );
  }
}
```

### الاستخدام المتقدم مع التخصيص
```dart
CustomAppBar(
  notificationCount: 5,
  onSearchChanged: (query) {
    // Handle search query changes
    print('Search: $query');
  },
  onNotificationTap: () {
    // Handle notification tap
    print('Notifications tapped');
  },
  onUserProfileTap: () {
    // Handle user profile tap
    print('User profile tapped');
  },
  onHamburgerMenuTap: () {
    // Handle hamburger menu tap
    print('Hamburger menu tapped');
  },
)
```

### تخصيص العناصر المرئية
```dart
CustomAppBar(
  showSearch: true,           // إظهار/إخفاء شريط البحث
  showNotifications: true,    // إظهار/إخفاء الإشعارات
  showUserProfile: true,      // إظهار/إخفاء ملف المستخدم
  showHamburgerMenu: true,    // إظهار/إخفاء قائمة الهامبرغر
)
```

## المعاملات

| المعامل | النوع | الوصف | القيمة الافتراضية |
|---------|-------|--------|------------------|
| `title` | `String?` | عنوان الشريط | `null` |
| `showSearch` | `bool` | إظهار شريط البحث | `true` |
| `showNotifications` | `bool` | إظهار الإشعارات | `true` |
| `showUserProfile` | `bool` | إظهار ملف المستخدم | `true` |
| `showHamburgerMenu` | `bool` | إظهار قائمة الهامبرغر | `true` |
| `onSearchTap` | `VoidCallback?` | دالة عند النقر على البحث | `null` |
| `onNotificationTap` | `VoidCallback?` | دالة عند النقر على الإشعارات | `null` |
| `onUserProfileTap` | `VoidCallback?` | دالة عند النقر على ملف المستخدم | `null` |
| `onHamburgerMenuTap` | `VoidCallback?` | دالة عند النقر على قائمة الهامبرغر | `null` |
| `onSearchChanged` | `Function(String)?` | دالة عند تغيير نص البحث | `null` |
| `notificationCount` | `int` | عدد الإشعارات | `0` |

## الألوان المستخدمة
- **الخلفية**: أبيض (`Colors.white`)
- **النص الأساسي**: رمادي داكن (`AppColor.textColor`)
- **النص الثانوي**: رمادي (`AppColor.textSecondaryColor`)
- **خلفية البحث**: رمادي فاتح (`AppColor.backgroundColor`)
- **حدود البحث**: رمادي فاتح (`AppColor.borderColor`)
- **عداد الإشعارات**: أحمر (`AppColor.errorColor`)
- **تدرج ملف المستخدم**: بنفسجي إلى أزرق (`AppColor.primaryColor` إلى `AppColor.secondaryColor`)

## ملاحظات
- الشريط يستخدم `PreferredSizeWidget` لضمان التوافق مع `AppBar`
- جميع العناصر قابلة للتخصيص أو الإخفاء
- يحتوي على دوال افتراضية للعناصر الأساسية
- متوافق مع GetX للتنقل والحوارات
