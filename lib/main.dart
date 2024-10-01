import 'dart:io';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'constants/miscellaneous.dart';
import 'constants/themes.dart';
import 'navigation/app_router.dart';
import 'presentation/providers/auth/login_provider.dart';
import 'presentation/providers/auth/otp_provider.dart';
import 'presentation/providers/locale_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/https_override.dart';
import 'utils/responsive_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocaleProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => OtpProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveManager.init(context);
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder:
          (BuildContext context, themeProvider, localeProvider, Widget? child) {
        return ToastificationWrapper(
          config: const ToastificationConfig(
              animationDuration: kToastAnimationDuration),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppLocalizations.of(context)!.appName,
            routerConfig: router,
            theme: lightTheme,
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            themeAnimationCurve: Curves.easeIn,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: localeProvider.locale,
          ),
        );
      },
    );
  }
}
