# دليل البدء السريع - API Integration

## الخطوات الأولى

### 1. تحديث Base URL

افتح `lib/core/constant/api_constant.dart` وحدّث:

```dart
static const String baseUrl = 'https://api.yourdomain.com/api/v1';
```

**للتطوير المحلي:**
- Android Emulator: `'http://10.0.2.2:8000/api/v1'`
- iOS Simulator: `'http://localhost:8000/api/v1'`
- جهاز حقيقي: `'http://YOUR_IP:8000/api/v1'`

### 2. التأكد من هيكل API Response

يجب أن تكون استجابة API بهذا الشكل:

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {...},
  "errors": null
}
```

### 3. اختبار الاتصال

بعد تحديث base URL، جرب تسجيل الدخول من التطبيق.

## الملفات المهمة

### 1. API Constants
📁 `lib/core/constant/api_constant.dart`
- يحتوي على جميع الـ endpoints
- Base URL
- Helper methods

### 2. API Service
📁 `lib/core/services/api_service.dart`
- خدمة HTTP رئيسية
- GET, POST, PUT, DELETE
- Error handling

### 3. Auth Service
📁 `lib/core/services/auth_service.dart`
- إدارة tokens
- حفظ/استرجاع بيانات المستخدم

### 4. Repositories
📁 `lib/data/repository/`
- `projects_repository.dart` - المشاريع
- `auth_repository.dart` - Authentication

### 5. Response Models
📁 `lib/data/Models/api_response_model.dart`
- نماذج الاستجابة القياسية

## كيفية الاستخدام

### في Controller

```dart
class MyController extends GetxController {
  final ProjectsRepository _repository = ProjectsRepository();
  StatusRequest _status = StatusRequest.none;
  List<ProjectModel> _projects = [];

  void loadData() async {
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

### في UI

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

## Endpoints المطلوبة

### Authentication
- ✅ `POST /auth/login` - جاهز
- ✅ `POST /auth/register` - جاهز
- ✅ `POST /auth/logout` - جاهز

### Projects
- ✅ `GET /projects` - جاهز
- ✅ `GET /projects/{id}` - جاهز
- ✅ `POST /projects` - جاهز
- ✅ `PUT /projects/{id}` - جاهز
- ✅ `DELETE /projects/{id}` - جاهز

## ملاحظات مهمة

1. **Base URL** يجب تحديثه قبل الاستخدام
2. **API Response** يجب أن يتبع الهيكل المحدد
3. **Authentication** يتم تلقائياً بعد login
4. **Error Handling** موجود في جميع الـ repositories

## Troubleshooting

### مشكلة: لا يعمل على Android Emulator
**الحل:** استخدم `10.0.2.2` بدلاً من `localhost`

### مشكلة: CORS Error
**الحل:** تأكد من إعداد CORS في backend

### مشكلة: 401 Unauthorized
**الحل:** تأكد من حفظ token بعد login

## الخطوات التالية

1. ✅ تحديث base URL
2. ✅ اختبار login
3. ✅ اختبار fetch projects
4. ⬜ إضافة repositories إضافية (Tasks, Team, etc.)
5. ⬜ إضافة caching
6. ⬜ إضافة offline support

