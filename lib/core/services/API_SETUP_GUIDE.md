# دليل إعداد API للـ Backend

## نظرة عامة

تم إعداد البنية الكاملة للتعامل مع RESTful API. هذا الدليل يشرح كيفية استخدامها وإعدادها.

## البنية المكونة

### 1. API Constants (`lib/core/constant/api_constant.dart`)
يحتوي على جميع الـ endpoints و base URL.

### 2. API Service (`lib/core/services/api_service.dart`)
خدمة رئيسية للتعامل مع جميع HTTP requests.

### 3. Auth Service (`lib/core/services/auth_service.dart`)
خدمة لإدارة authentication tokens والبيانات.

### 4. Repository Pattern (`lib/data/repository/`)
Repositories لكل entity (Projects, Auth, etc.)

### 5. Response Models (`lib/data/Models/api_response_model.dart`)
نماذج للاستجابة من API.

## الخطوات المطلوبة

### 1. تحديث Base URL

افتح `lib/core/constant/api_constant.dart` وحدّث:

```dart
static const String baseUrl = 'https://api.yourdomain.com/api/v1';
```

**أمثلة:**
- Development: `'http://localhost:8000/api/v1'`
- Android Emulator: `'http://10.0.2.2:8000/api/v1'`
- Production: `'https://api.yourdomain.com/api/v1'`

### 2. هيكل الاستجابة المتوقع من API

يجب أن تكون استجابة API بهذا الشكل:

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {
    // البيانات هنا
  },
  "errors": null,
  "meta": {}
}
```

**للـ Pagination:**
```json
{
  "success": true,
  "message": "Data retrieved successfully",
  "data": [...],
  "pagination": {
    "current_page": 1,
    "per_page": 10,
    "total": 100,
    "last_page": 10,
    "from": 1,
    "to": 10
  }
}
```

### 3. Authentication

**Login Response يجب أن يحتوي على:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "jwt_token_here",
    "refresh_token": "refresh_token_here",
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "User Name"
    }
  }
}
```

### 4. Endpoints المطلوبة

#### Authentication
- `POST /auth/login` - تسجيل الدخول
- `POST /auth/register` - تسجيل حساب جديد
- `POST /auth/logout` - تسجيل الخروج
- `POST /auth/refresh` - تحديث token

#### Projects
- `GET /projects` - الحصول على جميع المشاريع
  - Query params: `status`, `page`, `per_page`
- `GET /projects/{id}` - الحصول على مشروع محدد
- `POST /projects` - إنشاء مشروع جديد
- `PUT /projects/{id}` - تحديث مشروع
- `DELETE /projects/{id}` - حذف مشروع
- `GET /projects/stats` - إحصائيات المشاريع

### 5. Headers المطلوبة

**جميع الـ requests (عدا login/register) تحتاج:**
```
Authorization: Bearer {token}
Content-Type: application/json
Accept: application/json
```

## كيفية الاستخدام

### 1. في Controller

```dart
import 'package:junior/data/repository/projects_repository.dart';
import 'package:junior/core/class/statusrequest.dart';

class MyController extends GetxController {
  final ProjectsRepository _repository = ProjectsRepository();
  StatusRequest _status = StatusRequest.none;
  List<ProjectModel> _projects = [];

  void loadProjects() async {
    _status = StatusRequest.loading;
    update();

    final result = await _repository.getProjects();

    result.fold(
      (error) {
        _status = error;
        // Handle error
      },
      (projects) {
        _projects = projects;
        _status = StatusRequest.success;
        // Update UI
      },
    );
    update();
  }
}
```

### 2. في Login Controller

```dart
import 'package:junior/data/repository/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _repository = AuthRepository();

  Future<void> login(String email, String password) async {
    final result = await _repository.login(
      email: email,
      password: password,
    );

    result.fold(
      (error) {
        // Handle error
        print('Login failed: $error');
      },
      (data) {
        // Login successful
        // Token is automatically saved
        Get.offNamed(AppRoute.home);
      },
    );
  }
}
```

### 3. إضافة Repository جديد

```dart
// lib/data/repository/tasks_repository.dart
class TasksRepository {
  final ApiService _apiService = ApiService();

  Future<Either<StatusRequest, List<TaskModel>>> getTasks() async {
    final result = await _apiService.get(ApiConstant.tasks);
    
    return result.fold(
      (error) => Left(error),
      (response) {
        // Parse response
        final apiResponse = ApiResponseModel<List<dynamic>>.fromJson(
          response,
          (data) => data as List<dynamic>,
        );
        
        if (apiResponse.success && apiResponse.data != null) {
          final tasks = apiResponse.data!
              .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
              .toList();
          return Right(tasks);
        }
        return const Left(StatusRequest.serverFailure);
      },
    );
  }
}
```

## Error Handling

### StatusRequest Enum

```dart
enum StatusRequest {
  none,           // Initial state
  loading,        // Request in progress
  success,        // Request successful
  failure,        // General failure
  serverFailure,  // Server error (400, 404, 500, etc.)
  offlineFailure, // No internet connection
  serverException, // Network exception
  timeoutException, // Request timeout
}
```

### معالجة الأخطاء في UI

```dart
GetBuilder<ProjectsControllerImp>(
  builder: (controller) {
    switch (controller.statusRequest) {
      case StatusRequest.loading:
        return const Center(child: CircularProgressIndicator());
      
      case StatusRequest.offlineFailure:
        return Center(
          child: Column(
            children: [
              Icon(Icons.wifi_off),
              Text('No internet connection'),
              ElevatedButton(
                onPressed: () => controller.loadProjects(),
                child: Text('Retry'),
              ),
            ],
          ),
        );
      
      case StatusRequest.serverFailure:
        return Center(
          child: Column(
            children: [
              Icon(Icons.error),
              Text('Server error'),
              ElevatedButton(
                onPressed: () => controller.loadProjects(),
                child: Text('Retry'),
              ),
            ],
          ),
        );
      
      case StatusRequest.success:
        return ListView.builder(
          itemCount: controller.projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: controller.projects[index]);
          },
        );
      
      default:
        return const SizedBox();
    }
  },
)
```

## Testing

### 1. اختبار مع API محلي

```dart
// في api_constant.dart
static const String baseUrl = 'http://10.0.2.2:8000/api/v1'; // Android emulator
// أو
static const String baseUrl = 'http://localhost:8000/api/v1'; // iOS simulator
```

### 2. اختبار مع Mock API

يمكنك استخدام:
- Postman Mock Server
- JSONPlaceholder
- Mockoon

## Troubleshooting

### مشكلة: لا يعمل على Android Emulator

**الحل:** استخدم `10.0.2.2` بدلاً من `localhost`

```dart
static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
```

### مشكلة: CORS Error

**الحل:** تأكد من إعداد CORS في backend:

```php
// Laravel
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
```

### مشكلة: 401 Unauthorized

**الحل:** تأكد من:
1. حفظ token بعد login
2. إرسال token في header
3. Token لم ينتهي صلاحيته

## ملاحظات مهمة

1. **تأكد من تحديث base URL** قبل الاستخدام
2. **تأكد من أن API يتبع نفس هيكل الاستجابة**
3. **اختبر على جهاز حقيقي** للتأكد من عمل SSL certificates
4. **استخدم HTTPS** في production
5. **تأكد من إعداد SSL Pinning** في production للأمان

## الخطوات التالية

1. تحديث base URL
2. اختبار endpoints مع backend
3. إضافة repositories إضافية حسب الحاجة
4. إضافة error handling محسّن
5. إضافة caching للبيانات
6. إضافة offline support

## الدعم

إذا واجهت أي مشاكل، تأكد من:
- فحص logs في console
- التأكد من صحة base URL
- التأكد من صحة هيكل الاستجابة
- التأكد من صحة authentication tokens

