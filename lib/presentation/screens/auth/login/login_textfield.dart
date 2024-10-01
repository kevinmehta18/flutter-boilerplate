import 'package:boilerplate/presentation/providers/auth/login_provider.dart';
import 'package:boilerplate/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MobileNoTextField extends StatefulWidget {
  const MobileNoTextField({
    super.key,
  });

  @override
  State<MobileNoTextField> createState() => _MobileNoTextFieldState();
}

class _MobileNoTextFieldState extends State<MobileNoTextField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (BuildContext context, LoginProvider provider, Widget? child) {
        return Form(
          key: provider.formKey,
          child: CustomTextField(
            controller: provider.mobileNoController,
            hintText: AppLocalizations.of(context)!.phoneNo,
            labelText: AppLocalizations.of(context)!.phoneNo,
            focusNode: provider.mobileNoFocusNode,
            validator: provider.validateMobileNo,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
        );
      },
    );
  }
}
