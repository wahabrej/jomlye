import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/models/common/common_data_model.dart';
import 'package:flixoo_flutter_app/models/common/common_error_model.dart';
import 'package:flixoo_flutter_app/models/payment/payment_history_model.dart';
import 'package:flixoo_flutter_app/models/payment/subscription_check_model.dart';
import 'package:flixoo_flutter_app/models/payment/subscription_plan_model.dart';
import 'package:flixoo_flutter_app/services/api_services.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/utils/constants/urls.dart';

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

//!payment history
  final RxBool isPaymentHistoryLoading = RxBool(false);
  final Rx<PaymentHistoryModel?> paymentHistoryData = Rx<PaymentHistoryModel?>(null);
  final RxList<PaymentHistoryData?> paymentHistoryList = RxList<PaymentHistoryData?>([]);
  Future<void> getPaymentHistory() async {
    try {
      isPaymentHistoryLoading.value = true;
      String? token = await spController.getBearerToken();
      ll("the token is $token");
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuPaymentHistory?user_id=${userId.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        paymentHistoryList.clear();
        paymentHistoryData.value = PaymentHistoryModel.fromJson(response.data);
        paymentHistoryList.addAll(paymentHistoryData.value!.paymentHistory!.data!);
         paymentHistoryListSubLink.value = paymentHistoryData.value!.paymentHistory!.nextPageUrl;
        if (paymentHistoryListSubLink.value != null) {
          paymentHistoryListScrolled.value = false;
        } else {
          paymentHistoryListScrolled.value = true;
        }
        isPaymentHistoryLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPaymentHistoryLoading.value = false;
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
      isPaymentHistoryLoading.value = false;
      ll('getPaymentHistory error: $e');
    }
  }
  //* more payment history
   ScrollController paymentHistoryScrollController = ScrollController();
  final Rx<String?> paymentHistoryListSubLink = Rx<String?>(null);
  final RxBool paymentHistoryListScrolled = RxBool(false);
  Future<void> getMorePaymentHistory([take]) async {
    int? userId = await spController.getUserId();
    ll("getMorePaymentHistory is called");
    try {
      String? token = await spController.getBearerToken();
      dynamic paymentHistoryListSub;

      if (paymentHistoryListSubLink.value == null) {
        return;
      } else {
        paymentHistoryListSub = paymentHistoryListSubLink.value!.split('?');
      }

      String paymentHistorySuffixUrl = '';

      paymentHistorySuffixUrl = '&${paymentHistoryListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuPaymentHistory?user_id=${userId.toString()}$paymentHistorySuffixUrl",
      ) as CommonDM;

      if (response.code == 200) {
         paymentHistoryData.value = PaymentHistoryModel.fromJson(response.data);
        paymentHistoryList.addAll(paymentHistoryData.value!.paymentHistory!.data!);
        paymentHistoryListSubLink.value = paymentHistoryData.value!.paymentHistory!.nextPageUrl;
        if (paymentHistoryListSubLink.value != null) {
          paymentHistoryListScrolled.value = false;
        } else {
          paymentHistoryListScrolled.value = true;
        }
        isPaymentHistoryLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPaymentHistoryLoading.value = true;
      ll('getMorePaymentHistory error: $e');
    }
  }
  //! Subscription check api
  final RxBool isSubscriptionCheckLoading = RxBool(false);
  final Rx<SubscriptionCheckModel?> subscriptionCheckModel = Rx<SubscriptionCheckModel?>(null);
  Future<void> getSubscriptionCheck() async {
    try {
      isSubscriptionCheckLoading.value = true;
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuSubscriptionCheck?user_id=${userId.toString()}",
        body: body,
      ) as CommonDM;
      if (response.code == 200) {
        subscriptionCheckModel.value = SubscriptionCheckModel.fromJson(response.data);
        spController.saveSubscribedUser(subscriptionCheckModel.value?.isSubscribed??false);
        Get.find<GlobalController>().subscriptionState.value = await spController.getSubscribedUser()??false;
        isSubscriptionCheckLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isSubscriptionCheckLoading.value = false;
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
      isSubscriptionCheckLoading.value = false;
      ll('getSubscriptionCheck error: $e');
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
      ll("offerings available!!");
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
      ll("The data is from findStoreProductById");
      if (storeProductIds[j] == subscriptionPlanList[index]!.storeSubscriptionId.toString()) {
        // UtilityFunction().ll(Get.find<PurchaseController>().storeProducts[j]);
        ll("The selected id is ${storeProductIds[j]}");
        return storeProducts[j];
      }
    }
  }
}