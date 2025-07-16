import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";
const kUserId = 'kUserId';
const kUserImage = "kUserImage";
const kUserEmail = "kUserEmail";
const kFirstName = "kFirstName";
const kLastName = "kLastName";
const kUserPassword = "kUserPassword";
const kPhoneNumber = "kPhoneNumber";
const kUserGender = "kUserGender";
const kPrivacyPolicy = "kPrivacyPolicy";
const kPaymentPolicy = "kPaymentPolicy";
const kTermsAndCondition = "kTermsAndCondition";
const kCurrency = "kCurrency";
const kGeneralNotificationState = "kGeneralNotificationState";
const kNewReleaseState = "kNewReleaseState";
const kPaymentNotificationState = "kPaymentNotificationState";
const kAppUpdateState = "kAppUpdateState";
const kSubscriptionState = "kSubscriptionState";
const kWifiOnlyState = "kWifiOnlyState";
const kSubscriptionId = 'kSubscriptionId';
const kVideoQualityIndex = 'kVideoQualityIndex';

class SpController {
  //* save Bearer Token
  Future<void> saveBearerToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kBearerToken, token.toString());
  }

  Future<String?> getBearerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kBearerToken);
  }

  //* Remember me status
  Future<void> saveRememberMe(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kRememberMe, value);
  }

  Future<bool?> getRememberMe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kRememberMe);
  }

    //* save user id
  Future<void> saveUserId(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(kUserId, id);
  }

  Future<int?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(kUserId);
  }

    //* save user Image
  Future<void> saveUserImage(imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserImage, imageUrl.toString());
  }

  Future<String?> getUserImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserImage);
  }

  //* save user email
  Future<void> saveUserEmail(email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserEmail, email.toString());
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserEmail);
  }
  //* save user first name
  Future<void> saveUserFirstName(firstName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kFirstName, firstName.toString());
  }

  Future<String?> getUserFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kFirstName);
  }
    //* save user last name
  Future<void> saveUserLastName(lastName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kLastName, lastName.toString());
  }

  Future<String?> getUserLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kLastName);
  }

   //* save user phone number
  Future<void> saveUserPhoneNumber(phoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kPhoneNumber, phoneNumber.toString());
  }

  Future<String?> getUserPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kPhoneNumber);
  }

   //* save user 
  Future<void> saveUserGender(gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserGender, gender.toString());
  }

  Future<String?> getUserGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserGender);
  }

      //* save user password
  Future<void> saveUserPassword(password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserPassword, password.toString());
  }

  Future<String?> getUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserPassword);
  }

  //* save privacy Policy
  Future<void> savePrivacyPolicy(privacyPolicyUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kPrivacyPolicy, privacyPolicyUrl.toString());
  }

  Future<String?> getPrivacyPolicy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kPrivacyPolicy);
  }

  //* save payment policy
  Future<void> savePaymentPolicy(paymentPolicyUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kPaymentPolicy, paymentPolicyUrl.toString());
  }

  Future<String?> getPaymentPolicy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kPaymentPolicy);
  }

    //* save payment policy
  Future<void> saveTermsAndCondition(termsAndConditionUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kTermsAndCondition, termsAndConditionUrl.toString());
  }

  Future<String?> getTermsAndCondition() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kTermsAndCondition);
  }

  //* save user currency name
  Future<void> saveCurrency(String currency) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kCurrency, currency.toString());
  }

  Future<String?> getCurrency() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kCurrency);
  }
  //* save General Notification State
  Future<void> saveGeneralNotificationState(bool generalNotificationState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kGeneralNotificationState, generalNotificationState);
  }
  
  Future<bool?> getGeneralNotificationState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kGeneralNotificationState);
  }
  //* save New Release State
  Future<void> saveNewReleaseState(bool newReleaseState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kNewReleaseState, newReleaseState);
  }

  Future<bool?> getNewReleaseState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kNewReleaseState);
  }
  //* save Payment Notification State
  Future<void> savePaymentNotificationState(bool paymentNotificationState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kPaymentNotificationState, paymentNotificationState);
  }

  Future<bool?> getPaymentNotificationState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kPaymentNotificationState);
  }

  //* save App Update State
  Future<void> saveAppUpdateState(bool appUpdateState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kAppUpdateState, appUpdateState);
  }

  Future<bool?> getAppUpdateState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kAppUpdateState);
  }
  //* save Subscription State
  Future<void> saveSubscriptionState(bool subscriptionState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kSubscriptionState, subscriptionState);
  }

  Future<bool?> getSubscriptionState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kSubscriptionState);
  }
  //* save Subscription State
  Future<void> saveWifiOnlyState(bool wifiOnlyState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kWifiOnlyState, wifiOnlyState);
  }

  Future<bool?> getWifiOnlyState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kWifiOnlyState);
  }

      //! save One signal Subscription Id
  Future<void> saveOneSignalSubscriptionId(subscriptionId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kSubscriptionId, subscriptionId.toString());
  }

  Future<String?> getOneSignalSubscriptionId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kSubscriptionId);
  }

      //* save user id
  Future<void> saveVideoQualityIndex(videoQualityIndex) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(kVideoQualityIndex, videoQualityIndex);
  }

  Future<int?> getVideoQualityIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(kVideoQualityIndex);
  }


   //* on logout
  Future<void> onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kBearerToken);
  }
}