import 'package:get/get.dart';
import 'package:junior/core/services/services.dart';

translateDatabase(columnar, columnen) {
  Myservices myservices = Get.find();
  if (myservices.sharedPreferences.getString("lang") == "Ar") {
    return columnar;
  } else {
    return columnen;
  }
}
