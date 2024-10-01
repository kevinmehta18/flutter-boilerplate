import 'package:boilerplate/constants/miscellaneous.dart';
import 'package:boilerplate/navigation/routes.dart';
import 'package:boilerplate/presentation/screens/auth/login/login_screen.dart';
import 'package:boilerplate/presentation/screens/auth/otp/otp_verification_screen.dart';
import 'package:boilerplate/presentation/screens/auth/otp/verification_success_screen.dart';
import 'package:boilerplate/presentation/screens/home/home_screen.dart';

import 'package:boilerplate/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: homeRoute,
  routes: [
    GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (ctx, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: kNavigationDuration,
            reverseTransitionDuration: kNavigationDuration,
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: splashRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: otpRoute,
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: otpSucessRoute,
      builder: (context, state) => const VerificationSuccessScreen(),
    ),
  ],
);
