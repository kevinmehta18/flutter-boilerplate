import 'dart:async';

import 'package:boilerplate/data/api_service/api_service.dart';
import 'package:boilerplate/navigation/app_router.dart';
import 'package:boilerplate/shared_preferences/shared_preference.dart';
import 'package:boilerplate/utils/toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpProvider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  bool isLoading = false;
  Timer? timer;
  int start = 0;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  void clearOtpController() {
    otpController.clear();
    notifyListeners();
  }

  String? validateOtp(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.otpError;
    }
    if (value != null && value.length != 4) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.otpLengthError;
    }
    return null;
  }

  /// Resend OTP
  Future<void> resendOtp(BuildContext context) async {
    const oneSec = Duration(seconds: 1);
    start = 60; // Reset the countdown timer
    notifyListeners();

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
          notifyListeners();
        }
      },
    );

    clearOtpController();
  }

  /// OTP Verification API
  Future verifyOtp(Map<String, dynamic> data) async {
    startLoader();
    await ApiService().networkService().verifyOtp(data).then((value) {
      stopLoader();
      if (value != null) {
        PrefUtils().saveUserLoggedIn(true);
        showToast(navigatorKey.currentContext!, value['message']);
        return value;
      }
    });
  }

  /// Clear Auth Provider
  clearProvider() {
    isLoading = false;
    otpController.clear();
  }
}
