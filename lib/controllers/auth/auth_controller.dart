// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/models/auth/interest_model.dart';
import 'package:flixoo_flutter_app/models/auth/login_model.dart';
import 'package:flixoo_flutter_app/models/auth/phone_login_user_model.dart';
import 'package:flixoo_flutter_app/models/common/common_data_model.dart';
import 'package:flixoo_flutter_app/models/common/common_error_model.dart';
import 'package:flixoo_flutter_app/models/common/common_user_model.dart';
import 'package:flixoo_flutter_app/services/api_services.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/utils/constants/urls.dart';

class AuthController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final GlobalController globalController = Get.find<GlobalController>();
  //signin
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController forgotEmailTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  //*sign up
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController userNameTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  //*otp
  final TextEditingController otpTextEditingController =
      TextEditingController();

  //* Create new password
  final TextEditingController newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTextEditingController =
      TextEditingController();

  final RxBool isPasswordShow = RxBool(false);
  final RxBool isConfirmPasswordShow = RxBool(false);
  final RxBool isRememberMe = RxBool(false);

  void resetAuth() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    forgotEmailTextEditingController.clear();
    phoneNumberTextEditingController.clear();
    firstNameTextEditingController.clear();
    lastNameTextEditingController.clear();
    userNameTextEditingController.clear();
    confirmPasswordTextEditingController.clear();
    isPasswordShow.value = false;
    isConfirmPasswordShow.value = false;
    isRememberMe.value = false;
    selectedInterestIdList.clear();
    selectedInterestList.clear();
  }

  //sign in
  Future<void> signIn() async {
    try {
      Map<String, dynamic> body = {
        'email': emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuSignIn,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        SignInModel loginData = SignInModel.fromJson(response.data);
        await spController.saveBearerToken(loginData.token);
        await spController.saveRememberMe(isRememberMe.value);
        await spController.saveUserId(loginData.user!.id);
        await spController.saveUserImage(loginData.user!.image);
        await spController.saveUserEmail(loginData.user!.email);
        await spController.saveUserFirstName(loginData.user!.firstName);
        await spController.saveUserLastName(loginData.user!.lastName);
        await spController.saveUserPhoneNumber(loginData.user!.phone);
        await spController.saveUserGender(loginData.user!.gender);
        await Get.find<HomeController>().getHomePage();
        Get.offAllNamed(krHomeScreen);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
        globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
        globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
        globalController.userImage.value =
            await spController.getUserImage() ?? "";
        globalController.userId.value = await spController.getUserId() ?? -1;
        globalController.userToken.value =
            await spController.getBearerToken() ?? "";
        globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
        globalController.userGender.value =
            await spController.getUserGender() ?? "";

      //await OneSignal;
      
      // await OneSignal.login(globalController.userId.value.toString());


      } else {
        showSnackBar(
            title: ksError.tr, message: "signIn Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('signIn error: $e');
    }
  }

//sign up
  Future<void> signUp() async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstNameTextEditingController.text.trim().toString(),
        "last_name": lastNameTextEditingController.text.trim().toString(),
        "username": userNameTextEditingController.text.trim().toString(),
        "email": emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.trim().toString(),
        "confirm_password":
            confirmPasswordTextEditingController.text.trim().toString(),
        "user_type": "user",
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuSignUp,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
         SignInModel signUpData = SignInModel.fromJson(response.data);
         await getInterestList();
        await spController.saveBearerToken(signUpData.token);
        await spController.saveRememberMe(isRememberMe.value);
        await spController.saveUserId(signUpData.user!.id);
        await spController.saveUserImage(signUpData.user!.image);
        await spController.saveUserEmail(signUpData.user!.email);
        await spController.saveUserFirstName(signUpData.user!.firstName);
        await spController.saveUserLastName(signUpData.user!.lastName);
        await spController.saveUserPhoneNumber(signUpData.user!.phone);
        await spController.saveUserGender(signUpData.user!.gender);
        await Get.find<HomeController>().getHomePage();
        Get.toNamed(krChooseInterestScreen);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
        globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
        globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
        globalController.userImage.value =
            await spController.getUserImage() ?? "";
        globalController.userId.value = await spController.getUserId() ?? -1;
        globalController.userToken.value =
            await spController.getBearerToken() ?? "";
        globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
        globalController.userGender.value =
            await spController.getUserGender() ?? "";

      } else {
        showSnackBar(
            title: ksError.tr, message: "signUp Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('signUp error: $e');
    }
  }

  final RxBool isInterestLoading = RxBool(false);
  final RxList interestList = RxList([]);
  Future<void> getInterestList() async {
    try {
      isInterestLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuInterest,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        InterestListModel inetrestListModel =
            InterestListModel.fromJson(response.data);
        interestList.clear();
        interestList.addAll(inetrestListModel.interests!);
        isInterestLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isInterestLoading.value = false;
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
      isInterestLoading.value = false;
      ll('getInterestList error: $e');
    }
  }

  // selectedInterestIdList
  Future<void> interestStore() async {
    try {
      Map<String, dynamic> body = {
        "email": Get.find<GlobalController>().userEmail.value,
        for (int i = 0; i < selectedInterestIdList.length; i++)
          "interest_ids[$i]": "${selectedInterestIdList[i]}"
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuInterestStore,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        Get.toNamed(krHomeScreen);
      } else {
        showSnackBar(
            title: ksError.tr,
            message: "interestStore Error!",
            color: cPrimaryColor2);
      }
    } catch (e) {
      ll('interestStore error: $e');
    }
  }

  //forget password
  final RxBool isForgotPasswordLoading = RxBool(false);
  Future<void> forgotPassword() async {
    try {
      isForgotPasswordLoading.value = true;
      Map<String, dynamic> body = {
        'email': forgotEmailTextEditingController.text.trim().toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuForgotPassword,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        Get.toNamed(krOTPScreen);
        isForgotPasswordLoading.value = false;
      } else {
        showSnackBar(
            title: ksError.tr,
            message: "forgetPassword Error!",
            color: cPrimaryColor2);
        isForgotPasswordLoading.value = false;
      }
    } catch (e) {
      ll('forgotPassword error: $e');
    }
  }

  //otp verify
  final Rx<CommonLoginUserModel?> phoneLoginUserModel = Rx<CommonLoginUserModel?>(null);
  final Rx<CommonUserModel?> userData = Rx<CommonUserModel?>(null);
  final RxBool isVerifyOtpLoading = RxBool(false);
  Future<void> otpVerification() async {
    try {
      isVerifyOtpLoading.value = true;
      Map<String, dynamic> body = {
        'email_or_phone': forgotEmailTextEditingController.text.trim()!="" ? forgotEmailTextEditingController.text.trim().toString() : "+88${phoneNumberTextEditingController.text.trim().toString()}",
        'otp': otpTextEditingController.text.trim().toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuOtpVerify,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        if(Get.previousRoute=="/phonesignin-screen"){
        phoneLoginUserModel.value = CommonLoginUserModel.fromJson(response.data);
        userData.value = phoneLoginUserModel.value?.user;
        await spController.saveBearerToken(phoneLoginUserModel.value?.token);
        await spController.saveUserId(userData.value?.id);
        await spController.saveUserImage(userData.value?.image);
        await spController.saveUserEmail(userData.value?.email);
        await spController.saveUserFirstName(userData.value?.firstName);
        await spController.saveUserLastName(userData.value?.lastName);
        await spController.saveUserPhoneNumber(userData.value?.phone);
        await spController.saveUserGender(userData.value?.gender);
          Get.offAllNamed(krHomeScreen);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
        globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
        globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
        globalController.userImage.value =
            await spController.getUserImage() ?? "";
        globalController.userId.value = await spController.getUserId() ?? -1;
        globalController.userToken.value =
            await spController.getBearerToken() ?? "";
        globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
        globalController.userGender.value =
            await spController.getUserGender() ?? "";
        }
        else{
          Get.toNamed(krResetPasswordScreen);
        }
        isVerifyOtpLoading.value = false;
      } else { 
        showSnackBar(
            title: ksError.tr,
            message: "otpVerification Error!",
            color: cPrimaryColor2);
        isVerifyOtpLoading.value = false;
      }
    } catch (e) {
      ll('otpVerification error: $e');
    }
  }

    //Reset password
  final RxBool isResetPasswordLoading = RxBool(false);
  Future<void> resetPassword() async {
    try {
      isResetPasswordLoading.value = true;
      Map<String, dynamic> body = {
        'email': forgotEmailTextEditingController.text.trim().toString(),
        'password': passwordTextEditingController.text.trim().toString(),
        'confirm_password': confirmPasswordTextEditingController.text.trim().toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuUpdatePassword,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        Get.toNamed(krSignInScreen);
        isResetPasswordLoading.value = false;
      } else { 
        showSnackBar(
            title: ksError.tr,
            message: "resetPassword Error!",
            color: cPrimaryColor2);
        isResetPasswordLoading.value = false;
      }
    } catch (e) {
      ll('resetPassword error: $e');
    }
  }

   //!phone login
  Future<void> phoneLogin() async {
    try {
      Map<String, dynamic> body = {
       "phone" : "+88${phoneNumberTextEditingController.text.trim().toString()}",
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuPhoneLogin,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        Get.toNamed(krOTPScreen);
      } else {
        showSnackBar(
            title: ksError.tr, message: "phoneLogin Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('phoneLogin error: $e');
    }
  }

  void resetUserData(){
  globalController.userId.value = -1;
  globalController.userFirstName.value = "";
  globalController.userLastName.value = "";
  globalController.userImage.value = "";
  globalController.userPhone.value = "";
  globalController.userEmail.value = "";
  globalController.userToken.value = "";
  }

  //! signOut
  void signOut() async {
    await SpController().onLogout();
    resetUserData();
    // bool isRememberMe = await spController.getRememberMe()??false;
    bool isRememberMe = false;
    await spController.saveRememberMe(isRememberMe);
    // await googleSignOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.find<HomeController>().watchHistoryList.clear();
    if (isRememberMe == false) {
      emailTextEditingController.text = "";
      passwordTextEditingController.text = "";
    } else {
      emailTextEditingController.text = await spController.getUserEmail() ?? "";
      passwordTextEditingController.text =
          await spController.getUserPassword() ?? "";
    }
    Get.offAllNamed(krSignInScreen);
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

//  //!Google sign in
  Future<void> signInWithGoogle() async {
  try {
    final account = await googleSignIn.signIn();
    ll("The account is $account");
    if (account == null) return;
    final auth = await account.authentication;
    final accessToken = auth.accessToken;
    ll("the access token is $accessToken");
    Map<String, dynamic> body = {
      "access_token": accessToken,
      "provider": "google",
    };

    ll("the access token is $accessToken");
    var response = await apiServices.commonApiCall(
      url: kuSocialLogin,
      body: body,
      requestMethod: kPost,
    ) as CommonDM;
    if (response.code == 200) {
      phoneLoginUserModel.value = CommonLoginUserModel.fromJson(response.data);
        userData.value = phoneLoginUserModel.value?.user;
        await spController.saveBearerToken(phoneLoginUserModel.value?.token);
        await spController.saveUserId(userData.value?.id);
        await spController.saveUserImage(userData.value?.image);
        await spController.saveUserEmail(userData.value?.email);
        await spController.saveUserFirstName(userData.value?.firstName);
        await spController.saveUserLastName(userData.value?.lastName);
        await spController.saveUserPhoneNumber(userData.value?.phone);
        await spController.saveUserGender(userData.value?.gender);
          Get.offAllNamed(krHomeScreen);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
        globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
        globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
        globalController.userImage.value =
            await spController.getUserImage() ?? "";
        globalController.userId.value = await spController.getUserId() ?? -1;
        globalController.userToken.value =
            await spController.getBearerToken() ?? "";
        globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
        globalController.userGender.value =
            await spController.getUserGender() ?? "";
    } else {
      showSnackBar(
        title: ksError.tr,
        message: "Google login failed!",
        color: cPrimaryColor2,
      );
    }
  } catch (e) {
    ll('Google login error: $e');
    showSnackBar(
      title: ksError.tr,
      message: "Google login error",
      color: cPrimaryColor2,
    );
  }
}

    Future<void> googleSignOut() async {
    await googleSignIn.signOut();
  }

//!changes

//   // Updated for v7.x: Use GoogleSignIn.instance instead of GoogleSignIn()
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // static AuthController authInstance =
//   // Get.put(AuthController(), permanent: true);

//   // Manual state management for current user (v7.x requirement)
//   final Rx<GoogleSignInAccount?> _currentGoogleUser = Rx<GoogleSignInAccount?>(null);
//   GoogleSignInAccount? get currentGoogleUser => _currentGoogleUser.value;

//   // Initialization state tracking
//   final RxBool _isGoogleSignInInitialized = false.obs;
//   bool get isGoogleSignInInitialized => _isGoogleSignInInitialized.value;

//   @override
//   void onReady() {
//     super.onReady();
//     // Initialize Google Sign-In asynchronously (v7.x requirement)
//     _initializeGoogleSignIn();
//   }

//     /// Ensure Google Sign-In is initialized before use
//   Future<void> _ensureGoogleSignInInitialized() async {
//     if (!_isGoogleSignInInitialized.value) {
//       await _initializeGoogleSignIn();
//     }
//   }

//   /// Initialize Google Sign-In (v7.x requirement)
// Future<void> _initializeGoogleSignIn() async {
//   try {
//     await _googleSignIn.initialize(
//       serverClientId: "518845356344-g6ge34uccq3ssn86oq40knhjrppim83o.apps.googleusercontent.com",
//     );
//     _isGoogleSignInInitialized.value = true;
//     log("Google Sign-In initialized successfully");
//   } catch (e) {
//     log("Failed to initialize Google Sign-In: $e");
//     _isGoogleSignInInitialized.value = false;
//   }
// }

// Future<void> signInWithGoogle() async {
//   try {
//     // Use mobile-compatible signIn() (v7.x) instead of authenticate()
//     // final GoogleSignInAccount? googleUser = await _googleSignIn();
//         await _ensureGoogleSignInInitialized();

//       if (!_isGoogleSignInInitialized.value) {
//         throw Exception("Google Sign-In not initialized");
//       }

//       // Use authenticate() instead of signIn() (v7.x)
//       GoogleSignInAccount googleSignInAccount = await _googleSignIn.authenticate(
//         scopeHint: ['email','profile'],
//       );

//     _currentGoogleUser.value = googleSignInAccount;
//     // if (googleSignInAccount == null) return; // user canceled
//      GoogleSignInAuthentication googleSignInAuthentication =
//           googleSignInAccount.authentication;
//         AuthCredential credential = GoogleAuthProvider.credential(
//   idToken: googleSignInAuthentication.idToken,
//   accessToken: _currentGoogleUser.value?.id,
// );
//    log("the credential is $credential");
//       final User? user = (await _auth.signInWithCredential(credential)).user;

//     if (user != null) {
//       // Get access token for your API
//       final accessToken = googleSignInAuthentication.idToken;
//       ll('The access token is $accessToken');

//       Map<String, dynamic> body = {
//         "access_token": accessToken,
//         "provider": "google",
//       };

//       // Call your API
//       var response = await apiServices.commonApiCall(
//       url: kuSocialLogin,
//        body: body,
//       requestMethod: kPost,
//     ) as CommonDM;
//       ll("the response is $response");

//       if (response.code == 200) {
//         // Save API response to shared preferences
//         phoneLoginUserModel.value = CommonLoginUserModel.fromJson(response.data);
//         userData.value = phoneLoginUserModel.value?.user;

//         await spController.saveBearerToken(phoneLoginUserModel.value?.token);
//         await spController.saveUserId(userData.value?.id);
//         await spController.saveUserImage(userData.value?.image);
//         await spController.saveUserEmail(userData.value?.email);
//         await spController.saveUserFirstName(userData.value?.firstName);
//         await spController.saveUserLastName(userData.value?.lastName);
//         await spController.saveUserPhoneNumber(userData.value?.phone);
//         await spController.saveUserGender(userData.value?.gender);

//         // Update global state
//         globalController.userFirstName.value = await spController.getUserFirstName() ?? "";
//         globalController.userLastName.value = await spController.getUserLastName() ?? "";
//         globalController.userEmail.value = await spController.getUserEmail() ?? "";
//         globalController.userImage.value = await spController.getUserImage() ?? "";
//         globalController.userId.value = await spController.getUserId() ?? -1;
//         globalController.userToken.value = await spController.getBearerToken() ?? "";
//         globalController.userPhone.value = await spController.getUserPhoneNumber() ?? "";
//         globalController.userGender.value = await spController.getUserGender() ?? "";

//         // Navigate to home
//         Get.offAllNamed(krHomeScreen);
//       } else {
//         Get.snackbar("Error", "Google login failed!");
//       }
//     } else {
//       Get.snackbar("Error", "Firebase login failed!");
//     }
//   } on FirebaseAuthException catch (e) {
//     ll("Firebase Error: ${e.message}");
//     Get.snackbar("Error", "Firebase login failed!");
//   } catch (e) {
//     ll("Google login error: $e");
//     Get.snackbar("Error", "Google login error");
//   }
// }

  
//   /// Silent authentication for v7.x
  
  
//   Future<GoogleSignInAccount?> attemptSilentGoogleSignIn() async {
//     try {
//       await _ensureGoogleSignInInitialized();

//       if (!_isGoogleSignInInitialized.value) {
//         return null;
//       }

//       // Use attemptLightweightAuthentication() instead of signInSilently() (v7.x)
//       final result = _googleSignIn.attemptLightweightAuthentication();

//       // Handle both sync and async returns
//       GoogleSignInAccount? account;
//       if (result is Future<GoogleSignInAccount?>) {
//         account = await result;
//       } else {
//         account = result as GoogleSignInAccount?;
//       }
//       // Update manual state management
//       _currentGoogleUser.value = account;
//       return account;
//     } catch (error) {
//       ll('Silent Google sign-in failed: $error');
//       _currentGoogleUser.value = null;
//       return null;
//     }
//   }

//   /// Enhanced scope management for v7.x
//   Future<String?> getAccessTokenForScopes(List<String> scopes) async {
//     try {
//       await _ensureGoogleSignInInitialized();

//       if (!_isGoogleSignInInitialized.value) {
//         return null;
//       }

//       final authClient = _googleSignIn.authorizationClient;

//       // Try to get existing authorization
//       var authorization = await authClient.authorizationForScopes(scopes);

//       if (authorization == null) {
//         // Request new authorization from user
//         authorization = await authClient.authorizeScopes(scopes);
//       }

//       return authorization.accessToken;
//     } catch (error) {
//       ll('Failed to get access token for scopes: $error');
//       return null;
//     }
//   }

//   /// Error message helper for Google Sign-In exceptions (v7.x)
//   String _getGoogleSignInErrorMessage(GoogleSignInException exception) {
//     switch (exception.code.name) {
//       case 'canceled':
//         return 'Sign-in was cancelled. Please try again if you want to continue.';
//       case 'interrupted':
//         return 'Sign-in was interrupted. Please try again.';
//       case 'clientConfigurationError':
//         return 'There is a configuration issue with Google Sign-In. Please contact support.';
//       case 'providerConfigurationError':
//         return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
//       case 'uiUnavailable':
//         return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
//       case 'userMismatch':
//         return 'There was an issue with your account. Please sign out and try again.';
//       case 'unknownError':
//       default:
//         return 'An unexpected error occurred during Google Sign-In. Please try again.';
//     }
//   }


  //!Facebook login
//   Future<void> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: ['email', 'public_profile'],
//     );
//     if (result.status == LoginStatus.success) {
//       final accessToken = result.accessToken?.tokenString??"";
//    ll("The access key is $accessToken");

//       // if (accessToken == null) {
//       //   ll("Facebook access token is null");
//       //   return;
//       // }

//       Map<String, dynamic> body = {
//         "access_token": accessToken,
//         "provider": "facebook",
//       };

//       // ll("Sending Facebook login request with body: $body");

//       var response = await apiServices.commonApiCall(
//         url: kuSocialLogin,
//         body: body,
//         requestMethod: kPost,
//       ) as CommonDM;
//   ll("The status code is ${response.code}");
//       if (response.code == 200) {
//             phoneLoginUserModel.value = CommonLoginUserModel.fromJson(response.data);
//         userData.value = phoneLoginUserModel.value?.user;
//         await spController.saveBearerToken(phoneLoginUserModel.value?.token);
//         await spController.saveUserId(userData.value?.id);
//         await spController.saveUserImage(userData.value?.image);
//         await spController.saveUserEmail(userData.value?.email);
//         await spController.saveUserFirstName(userData.value?.firstName);
//         await spController.saveUserLastName(userData.value?.lastName);
//         await spController.saveUserPhoneNumber(userData.value?.phone);
//         await spController.saveUserGender(userData.value?.gender);
//           Get.offAllNamed(krHomeScreen);
//         globalController.userFirstName.value =
//             await spController.getUserFirstName() ?? "";
//         globalController.userLastName.value =
//             await spController.getUserLastName() ?? "";
//         globalController.userEmail.value =
//             await spController.getUserEmail() ?? "";
//         globalController.userImage.value =
//             await spController.getUserImage() ?? "";
//         globalController.userId.value = await spController.getUserId() ?? -1;
//         globalController.userToken.value =
//             await spController.getBearerToken() ?? "";
//         globalController.userPhone.value =
//             await spController.getUserPhoneNumber() ?? "";
//         globalController.userGender.value =
//             await spController.getUserGender() ?? "";

//       } else {
//         showSnackBar(
//           title: ksError.tr,
//           message: "Facebook login failed!",
//           color: cPrimaryColor2,
//         );
//       }
//     } else if (result.status == LoginStatus.cancelled) {
//       ll("Facebook login cancelled by user");
//     } else {
//       ll("Facebook login failed: ${result.message}");
//     }
//   } catch (e) {
//     ll('Facebook login error: $e');
//     showSnackBar(
//       title: ksError.tr,
//       message: 'Facebook login error: $e',
//       color: cPrimaryColor2,
//     );
//   }
// }

  
  final RxList selectedInterestList = RxList([]);
  final RxList selectedInterestIdList = RxList([]);
}
