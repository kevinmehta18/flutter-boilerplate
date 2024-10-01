import 'package:boilerplate/navigation/app_router.dart';
import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/presentation/providers/auth/otp_provider.dart';
import 'package:boilerplate/presentation/widgets/custom_button.dart';
import 'package:boilerplate/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class VerifyOtpButton extends StatelessWidget {
  const VerifyOtpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<OtpProvider, bool>(
      selector: (ctx, otpProvider) => otpProvider.isLoading,
      builder: (BuildContext context, isLoading, Widget? child) {
        return CustomButton(
          btnText: AppLocalizations.of(context)!.verifyNow,
          onPressed: _onVerifyPressed,
          showLoader: isLoading,
        );
      },
    );
  }

  _onVerifyPressed() async {
    BuildContext context = navigatorKey.currentContext!;
    var provider = Provider.of<OtpProvider>(context, listen: false);
    Map<String, dynamic> data = {"mobileNo": provider.otpController.text};
    var isOtpValid = provider.validateOtp(provider.otpController.text);
    if (isOtpValid == null) {
      // var res = provider.verifyOtp(data);
      bool isRegisteredUser = false;
      _nextScreen(context, isRegisteredUser);
    } else {
      showToast(context, isOtpValid, toastType: ToastificationType.error);
    }
  }

  _nextScreen(BuildContext context, bool isRegisteredUser) {
    String route = isRegisteredUser ? homeRoute : otpSucessRoute;
    context.go(route);
  }
}
