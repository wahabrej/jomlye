import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

import 'sp_controller.dart';

class GlobalController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  @override
  void onInit() {
    super.onInit();
  }

}
