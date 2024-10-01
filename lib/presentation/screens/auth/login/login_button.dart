import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/presentation/providers/auth/login_provider.dart';
import 'package:boilerplate/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Selector<LoginProvider, bool>(
      selector: (ctx, loginProvider) => loginProvider.isLoading,
      builder: (BuildContext context, isLoading, Widget? child) {
        return CustomButton(
          btnText: AppLocalizations.of(context)!.login,
          onPressed: _onLoginPressed,
          showLoader: isLoading,
        );
      },
    );
  }

  _onLoginPressed() async {
    var provider = Provider.of<LoginProvider>(context, listen: false);
    Map<String, dynamic> data = {"mobileNo": provider.mobileNoController.text};
    if (provider.formKey.currentState!.validate()) {
      // var res = await provider.logIn(data);
      // if (res) {
      _openHomeScreen();
      // }
    }
  }

  _openHomeScreen() {
    context.push(otpRoute);
  }
}
