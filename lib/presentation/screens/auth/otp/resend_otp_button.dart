import 'package:boilerplate/presentation/providers/auth/otp_provider.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/medium_textstyles.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResendOtpButton extends StatelessWidget {
  const ResendOtpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (provider.start == 0) {
              provider.resendOtp(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: ResponsiveManager.height(3)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${AppLocalizations.of(context)!.otpNotReceived}\t',
                    style: text14RegularGrey,
                  ),
                  TextSpan(
                    text: (provider.start != 0)
                        ? '${AppLocalizations.of(context)!.resendIn} ${provider.start}s'
                        : AppLocalizations.of(context)!.resend,
                    style: text14PrimaryMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
