import 'package:buraq_captain/DataHandler/Services/driverServices.dart';
import 'package:get/get.dart';

import '../Models/driver.dart';

final captainController = Get.find<CaptainController>();

class CaptainController extends GetxController {
  Rx<CaptainModel>? captain = CaptainModel().obs;
  @override
  void onReady() {
    initStream();
  }

  initStream() async {
    captain?.bindStream(DriverServices().streamCaptain()!);
  }
}