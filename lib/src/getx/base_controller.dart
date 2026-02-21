import 'package:get/get.dart';
import '../ui/global_loader.dart';

class BaseController extends GetxController {
  void showLoader() => GlobalLoader.show();
  void hideLoader() => GlobalLoader.hide();

  void handleError(dynamic error) {
    hideLoader();
    Get.snackbar("Error", error.toString());
  }
}