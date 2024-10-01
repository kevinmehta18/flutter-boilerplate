import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/shared_preferences/shared_preference.dart';
import 'package:boilerplate/utils/textstyles/extra_bold_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _setDeviceId();
    _setActions();
  }

  _setDeviceId() async {
    var deviceId = await PrefUtils().getDeviceUUID();
    if (deviceId.isEmpty) {
      await _fetchDeviceUUID();
    }
  }

  Future _fetchDeviceUUID() async {
    String uuid = await FlutterUdid.udid;
    PrefUtils().saveDeviceUUID(uuid);
  }

  _setActions() {
    Future.delayed(const Duration(milliseconds: 800), () async {
      bool isUserLoggedIn = await _isUserLoggedIn();
      String path = isUserLoggedIn ? homeRoute : loginRoute;
      context.go(path);
    });
  }

  Future<bool> _isUserLoggedIn() async {
    bool isUserLoggedIn = await PrefUtils().getUserLoggedIn();
    return isUserLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(AppLocalizations.of(context)!.appName, style: text14ExtraBold),
      ),
    );
  }
}
