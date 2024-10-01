import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/presentation/providers/theme_provider.dart';
import 'package:boilerplate/utils/textstyles/regular_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? contentPadding;
  final bool? autofocus;
  final VoidCallback? onTap;
  final Icon? icon;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final String? prefixIcon;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final InputBorder? textFieldBorder;
  final Function()? onEditingCompleted;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final List<String>? autofillHints;
  final TextStyle? textStyle;
  final ScrollController? scrollController;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.keyboardType,
    this.enable,
    this.onChanged,
    this.contentPadding,
    this.onTap,
    this.icon,
    this.labelTextStyle,
    this.prefixIcon,
    this.validator,
    this.autoValidateMode,
    this.inputFormatters,
    this.focusNode,
    this.suffixIcon,
    this.filled,
    this.maxLines,
    this.fillColor,
    this.floatingLabelBehavior,
    this.hintText,
    this.hintTextStyle,
    this.textFieldBorder,
    this.autofocus,
    this.onEditingCompleted,
    this.textCapitalization,
    this.obscureText,
    this.autofillHints,
    this.textStyle,
    this.minLines,
    this.scrollController,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  static OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: kLightGrey),
      borderRadius: const BorderRadius.all(Radius.circular(100.0)));

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (context, themeProvider) => themeProvider.isDarkMode,
      builder: (BuildContext context, isDarkMode, Widget? child) {
        return TextFormField(
          onTap: () {
            setState(() {});

            /// update state to trigger color change of underline
          },
          scrollController: widget.scrollController,
          autofillHints: widget.autofillHints,
          controller: widget.controller,
          autocorrect: false,
          autofocus: widget.autofocus ?? false,
          enabled: widget.enable,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          cursorColor: isDarkMode ? kWhite : kPrimaryColor,
          style: widget.textStyle ?? text14Regular,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode:
              widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          focusNode: widget.focusNode ?? FocusNode(),
          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines ?? 1,
          obscureText: widget.obscureText ?? false,
          onTapOutside: (a) => widget.focusNode?.unfocus(),
          decoration: InputDecoration(
            filled: widget.filled ?? false,
            fillColor: widget.fillColor ?? kPrimaryColor.withOpacity(0.2),
            focusedBorder: widget.textFieldBorder ??
                inputBorder.copyWith(
                  borderSide: widget.focusNode != null &&
                          widget.focusNode!.hasFocus
                      ? BorderSide(color: isDarkMode ? kWhite : kPrimaryColor)
                      : inputBorder.borderSide,
                ),
            enabledBorder: widget.textFieldBorder ?? inputBorder,
            disabledBorder: widget.textFieldBorder ?? inputBorder,
            errorBorder: widget.textFieldBorder ??
                inputBorder.copyWith(borderSide: BorderSide(color: kRed)),
            focusedErrorBorder: widget.textFieldBorder ??
                inputBorder.copyWith(
                  borderSide:
                      widget.focusNode != null && widget.focusNode!.hasFocus
                          ? BorderSide(color: kRed)
                          : inputBorder.borderSide,
                ),
            // isDense: true,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20),
            labelText: widget.labelText ?? '',
            hintText: widget.hintText ?? '',
            floatingLabelBehavior:
                widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
            labelStyle: widget.labelTextStyle ?? text14RegularGrey,
            hintStyle: widget.hintTextStyle ?? text14RegularGrey,
            suffixIcon: widget.suffixIcon,
          ),
          keyboardType: widget.keyboardType,
          onEditingComplete: widget.onEditingCompleted,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}
