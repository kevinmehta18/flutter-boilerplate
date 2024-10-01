import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/presentation/screens/auth/login/login_button.dart';
import 'package:boilerplate/presentation/screens/auth/login/login_textfield.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/bold_textstyles.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_image.dart';
import 'tnc_pp_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          const Column(
            children: [
              LoginImage(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                reverse: true,
                child: Container(
                  color: kWhite,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveManager.width(5))
                        .copyWith(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ResponsiveManager.height(3)),
                          child: _buildLoginTitle(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ResponsiveManager.height(3)),
                          child: const MobileNoTextField(),
                        ),
                        const TnCPPText(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ResponsiveManager.height(3)),
                          child: const LoginButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTitle() {
    return Text(
      AppLocalizations.of(context)!.login,
      style: text28Bold,
    );
  }

  
}
