import 'package:flutter/cupertino.dart';

Color kGreen = CupertinoColors.systemGreen;
Color kSeaGreen = const Color(0xFF44B678);
Color kWhite = CupertinoColors.white;
Color kBlack = CupertinoColors.black;
Color kGrey = CupertinoColors.systemGrey;
Color kLightGrey = CupertinoColors.systemGrey5;
Color kRed = CupertinoColors.systemRed;
Color kBlueShadow = const Color(0xFF0098F0).withOpacity(0.2);
Color kPrimaryColor = const Color(0xFF126BE0);
Color kYellow = CupertinoColors.systemYellow;
Color kAuditSwipeCardBorder = const Color(0xFFC9DDF9);
Color kAuditSwipeCardBg = const Color(0xFFF1F7FF);

LinearGradient customButtonGradient = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0, 1.0],
  colors: [
    Color(0xFF0098F0),
    Color(0xFF126BE0),
  ],
);

LinearGradient qrButtonGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.3, 0.9],
        colors: [
          Color(0xFF0098F0),
          Color(0xFF126BE0),
        ],
      );
