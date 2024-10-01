import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/uri.dart';
import 'package:boilerplate/utils/textstyles/medium_textstyles.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TnCPPText extends StatelessWidget {
  const TnCPPText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppLocalizations.of(context)!.agreeTnC,
        style: text14Regular.copyWith(color: kGrey),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.tnc,
            style: text14PrimaryMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(tncUrl); // Replace with your terms URL
              },
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.and,
            style: text14Regular.copyWith(color: kGrey),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.privacyPolicy,
            style: text14PrimaryMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(privacyPolicyUrl);
              },
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
