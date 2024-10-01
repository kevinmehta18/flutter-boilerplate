import 'package:boilerplate/constants/images.dart';
import 'package:boilerplate/navigation/app_router.dart';
import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/presentation/widgets/custom_button.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/bold_textstyles.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveManager.width(5)),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(verifiedIcon),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ResponsiveManager.height(2),
                      top: ResponsiveManager.height(3)),
                  child: _buildTitle(),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: ResponsiveManager.height(3)),
                child: _buildContinueBtn(),
              ))
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppLocalizations.of(navigatorKey.currentContext!)!.verificationSuccess,
      style: text28Bold,
    );
  }

  

  Widget _buildContinueBtn() {
    return CustomButton(
      btnText: AppLocalizations.of(navigatorKey.currentContext!)!.continue1,
      onPressed: () => navigatorKey.currentContext!.go(homeRoute),
    );
  }
}
