import 'package:purchases_flutter/purchases_flutter.dart';
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
  final RxList<Packages?> subscriptionPlanList = RxList<Packages?>([]);
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

//!In App purchase
final RxList<String> storeProductIds = RxList<String>([]);
final RxList<Package> storeProducts = RxList<Package>([]);

Future<void> initializeInAppPurchase() async {
    Offerings? offerings;
    offerings = await Purchases.getOfferings();

    if (offerings.current == null) {
      ll("No offerings available");
    } else {
      var availablePackage = offerings.current!.availablePackages;
      storeProductIds.clear();
      storeProducts.clear();
      for (int i = 0; i < availablePackage.length; i++) {
        var splitStoreProductIdString = offerings.current!.availablePackages[i].storeProduct.identifier.toString().split(":");
        storeProductIds.add(splitStoreProductIdString[0]);
        storeProducts.add(offerings.current!.availablePackages[i]);
      }
      ll("The store product list is ${storeProducts.length}");
      ll("The store product ids list is $storeProductIds");
      // UtilityFunction().ll("store product Ids : $storeProductIds");
      // UtilityFunction().ll("admin product count : ${Get.find<SubscriptionController>().subscriptionList.length}");
    }
  }

   //!for finding a product id and match with your product id which get from the backend server
    findStoreProductById(int index) {
     ll("The id is ${storeProducts.length}");
    for (int j = 0; j < storeProductIds.length; j++) {
      if (storeProductIds[j] == subscriptionPlanList[index]!.storeSubscriptionId.toString()) {
        // UtilityFunction().ll(Get.find<PurchaseController>().storeProducts[j]);
        ll("The selected id is ${storeProductIds[j]}");
        return storeProducts[j];
      }
    }
  }
  
}