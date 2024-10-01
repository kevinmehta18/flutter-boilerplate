
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/presentation/providers/auth/otp_provider.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/semi_bold_textstyles.dart';
import 'package:boilerplate/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:toastification/toastification.dart';
import 'sms_retriever.dart';

class OtpTextField extends StatefulWidget {
  const OtpTextField({super.key});

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  final defaultPinTheme = PinTheme(
    width: ResponsiveManager.width(14),
    height: ResponsiveManager.height(7),
    textStyle: text14SemiBold,
    decoration: BoxDecoration(
      color: kLightGrey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: kLightGrey.withOpacity(0.6),
      ),
    ),
  );

  late final SmsRetrieverImpl smsRetrieverImpl;

  @override
  void initState() {
    super.initState();
    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            color: kLightGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: kBlack,
            ),
          ),
          animationCurve: Curves.easeIn,
          controller: provider.otpController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          showCursor: true,
          smsRetriever: smsRetrieverImpl,
          cursor: VerticalDivider(
              color: kPrimaryColor,
              endIndent: ResponsiveManager.height(2.5),
              indent: ResponsiveManager.height(2.5),
              thickness: 2),
          onCompleted: _onCompleted,
          separatorBuilder: (index) =>
              SizedBox(width: ResponsiveManager.width(5)),
          focusNode: provider.otpFocusNode,
          onTapOutside: (event) => provider.otpFocusNode.unfocus(),
        );
      },
    );
  }

  _onCompleted(String value) async {
    var provider = Provider.of<OtpProvider>(context, listen: false);
    Map<String, dynamic> data = {"otp": provider.otpController.text};
    var isOtpValid = provider.validateOtp(provider.otpController.text);
    if (isOtpValid == null) {
      // await provider.verifyOtp(data);

     bool isRegisteredUser = false;
      _nextScreen(context, isRegisteredUser);
    } else {
      showToast(context, isOtpValid, toastType: ToastificationType.error);
    }
  }

   _nextScreen(BuildContext context,bool isRegisteredUser) {
    String route = isRegisteredUser ? homeRoute : otpSucessRoute;
    context.go(route);
  }
}
