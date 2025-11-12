# Shadow Effects - أمثلة على تأثيرات الظلال

## 🎨 **تأثيرات الظلال المختلفة:**

### 1. **Shadow خفيف (Subtle)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 2),
  ),
]
```

### 2. **Shadow متوسط (Medium)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 15,
    offset: const Offset(0, 5),
  ),
]
```

### 3. **Shadow قوي (Strong)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.15),
    blurRadius: 20,
    offset: const Offset(0, 8),
  ),
]
```

### 4. **Shadow متعدد الطبقات (Layered)**
```dart
boxShadow: [
  // Shadow رئيسي
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 15,
    offset: const Offset(0, 5),
  ),
  // Shadow إضافي للعمق
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 25,
    offset: const Offset(0, 10),
  ),
]
```

### 5. **Shadow ملون (Colored)**
```dart
boxShadow: [
  BoxShadow(
    color: AppColor.primaryColor.withOpacity(0.3),
    blurRadius: 15,
    offset: const Offset(0, 5),
  ),
]
```

### 6. **Shadow داخلي (Inset)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: const Offset(0, 0),
    inset: true, // ظل داخلي
  ),
]
```

## 🔧 **معاملات BoxShadow:**

| المعامل | الوصف | مثال |
|---------|--------|------|
| `color` | لون الظل | `Colors.black.withOpacity(0.1)` |
| `blurRadius` | مدى ضبابية الظل | `15` |
| `offset` | موضع الظل | `Offset(0, 5)` |
| `spreadRadius` | انتشار الظل | `0` |
| `inset` | ظل داخلي | `true` |

## 🎯 **تأثيرات خاصة:**

### **تأثير الانبثاق (Elevation)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 15,
    offset: const Offset(0, 5),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 25,
    offset: const Offset(0, 10),
    spreadRadius: 0,
  ),
]
```

### **تأثير الطفو (Floating)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 20,
    offset: const Offset(0, 10),
    spreadRadius: 2,
  ),
]
```

### **تأثير الغرق (Pressed)**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 5,
    offset: const Offset(0, 2),
    spreadRadius: -2,
  ),
]
```

## 💡 **نصائح للتصميم:**

1. **استخدم opacity منخفض** (0.05 - 0.2) للظلال الطبيعية
2. **offset موجب** للأسفل يعطي تأثير الانبثاق
3. **blurRadius أكبر** يعطي ظل أكثر نعومة
4. **spreadRadius موجب** يوسع الظل
5. **ظلال متعددة** تعطي عمق أكبر

## 🎨 **ألوان الظلال الشائعة:**

- **أسود شفاف**: `Colors.black.withOpacity(0.1)`
- **رمادي شفاف**: `Colors.grey.withOpacity(0.1)`
- **لون التطبيق**: `AppColor.primaryColor.withOpacity(0.2)`
- **أبيض للظلال السلبية**: `Colors.white.withOpacity(0.8)`
