import '/core/app_export.dart';
import 'package:application1/presentation/get_started_one_screen/models/get_started_one_model.dart';

class GetStartedOneController extends GetxController {
  Rx<GetStartedOneModel> getStartedOneModelObj = GetStartedOneModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
