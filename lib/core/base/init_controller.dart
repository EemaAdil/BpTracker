import 'package:get/get.dart';

import '../../screens/blood_sugar/export.dart';
import '../../screens/bmi_screen/export.dart';
import '../../screens/bottom_nav/export.dart';
import '../../screens/blood_pressure/pressure_record_screen/export.dart';
import '../../screens/languages_screen/languages_controller.dart';

class Appbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => PressureRecordController());
    //Blood Sugar
    Get.lazyPut(() => BSDashboardController());
    Get.lazyPut(() => NewSugarRecordController());
    //BMI
    Get.lazyPut(() => BMIController());
    //Languages
    Get.lazyPut(() => LanguageController());

  }
}
