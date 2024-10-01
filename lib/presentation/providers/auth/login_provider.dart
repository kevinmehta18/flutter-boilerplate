
import 'package:boilerplate/data/api_service/api_service.dart';
import 'package:boilerplate/navigation/app_router.dart';
import 'package:boilerplate/shared_preferences/shared_preference.dart';
import 'package:boilerplate/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileNoController = TextEditingController();
  FocusNode mobileNoFocusNode = FocusNode();

  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  String? validateMobileNo(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.phoneNoError;
    } else if (value.length != 10) {
      return AppLocalizations.of(navigatorKey.currentContext!)!
          .mobileNoLengthError;
    }
    return null;
  }

  /// Log In API
  Future logIn(Map<String, dynamic> data) async {
    startLoader();
    await ApiService().networkService().login(data).then((value) {
      stopLoader();
      if (value != null) {
        PrefUtils().saveUserLoggedIn(true);
        PrefUtils().saveAuthToken(value['data']['cookie']);
        showToast(navigatorKey.currentContext!, value['message']);
        return value;
      }
    });
  }

  /// Clear Auth Provider
  clearProvider() {
    isLoading = false;
    mobileNoController.clear();
    mobileNoFocusNode.unfocus();
    formKey.currentState?.reset();
    notifyListeners();
  }
}
