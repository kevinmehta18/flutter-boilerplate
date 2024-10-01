
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/presentation/providers/theme_provider.dart';
import 'package:boilerplate/utils/responsive_manager.dart';
import 'package:boilerplate/utils/textstyles/semi_bold_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.btnText,
      this.btnTextStyle,
      this.onPressed,
      this.width,
      this.height,
      this.showLoader,
      this.padding,
      this.decoration});

  @override
  State<CustomButton> createState() => _CustomButtonState();
  final String btnText;
  final TextStyle? btnTextStyle;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool? showLoader;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
}

class _CustomButtonState extends State<CustomButton> {
  bool _isButtonDisabled = false;
  Duration debounceTime = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: _onTap,
        child: Selector<ThemeProvider, bool>(
          selector: (context, themeProvider) => themeProvider.isDarkMode,
          builder: (BuildContext context, isDarkMode, Widget? child) {
            return Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? ResponsiveManager.height(6.5),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                      horizontal: ResponsiveManager.width(1.4),
                      vertical: ResponsiveManager.width(1)),
              decoration: widget.decoration ??
                  BoxDecoration(
                    gradient: customButtonGradient,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
              alignment: Alignment.center,
              child: (widget.showLoader ?? false)
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: isDarkMode ? kPrimaryColor : kWhite,
                        strokeWidth: 2,
                      ))
                  : Text(widget.btnText,
                      textAlign: TextAlign.center,
                      style: widget.btnTextStyle ??
                          TextStyle(
                              color: isDarkMode ? kPrimaryColor : kWhite,
                              fontWeight: kSemiBold,
                              fontSize: 18)),
            );
          },
        ),
      ),
    );
  }

  _onTap() {
    if (!_isButtonDisabled) {
      setState(() {
        _isButtonDisabled = true;
      });
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
      Future.delayed(debounceTime, () {
        if (mounted) {
          setState(() {
            _isButtonDisabled = false;
          });
        }
      });
    }
  }
}
