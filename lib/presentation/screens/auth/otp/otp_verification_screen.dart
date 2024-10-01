import 'package:boilerplate/presentation/providers/auth/otp_provider.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/bold_textstyles.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'otp_textfield.dart';
import 'resend_otp_button.dart';
import 'verify_otp_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    super.initState();
    _clearOtpController();
  }

  void _clearOtpController() {
    var provider = Provider.of<OtpProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.clearOtpController();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppLocalizations.of(context)!.otpVerification,
      style: text28Bold,
    );
  }

  Widget _buildDesc() {
    return Text(
      AppLocalizations.of(context)!.otpVerificationDesc,
      style: text14RegularGrey,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveManager.width(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            SizedBox(height: ResponsiveManager.height(1)),
            _buildDesc(),
            SizedBox(height: ResponsiveManager.height(3)),
            const OtpTextField(),
            const ResendOtpButton(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ResponsiveManager.height(3)),
              child: const VerifyOtpButton(),
            ),
          ],
        ),
      ),
    );
  }
}
