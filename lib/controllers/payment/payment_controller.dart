import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/models/payment/subscription_plan_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class PaymentController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  //! Subscription plan
  final RxBool isSubscriptionPlanLoading = RxBool(false);
  final Rx<SubscriptionPlanModel?> subscriptionPlanData = Rx<SubscriptionPlanModel?>(null);
  final RxList<Package?> subscriptionPlanList = RxList<Package?>([]);
  Future<void> getSubscriptionPlan() async {
    try {
      isSubscriptionPlanLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuSubscriptionPlan,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        subscriptionPlanList.clear();
        subscriptionPlanData.value = SubscriptionPlanModel.fromJson(response.data);
        subscriptionPlanList.addAll(subscriptionPlanData.value!.packages!);
        isSubscriptionPlanLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isSubscriptionPlanLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cPrimaryColor2);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isSubscriptionPlanLoading.value = false;
      ll('getSubscriptionPlan error: $e');
    }
  }
}