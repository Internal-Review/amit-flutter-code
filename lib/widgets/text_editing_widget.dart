import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color_resources.dart';
import '../utils/app_utils.dart';

class TextEditingWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final Color? color;
  final Color? hintColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool? isDense;
  final GestureTapCallback? onTap;
  final Function? onTapSuffixIcon;
  final double? height;
  final double? width;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShadowEnable;
  final bool isBorderEnable;
  final String? fontFamilyText;
  final String? suffixFontFamilyText;
  final String? fontFamilyHint;
  final FontWeight? fontWeightText;
  final FontWeight? suffixFontWeightText;
  final FontWeight? fontWeightHint;
  final String? suffixIconName;
  final Widget? suffixIconWidget;
  final double? suffixIconHeight;
  final double? suffixIconWidth;
  final bool passwordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool autoFocus;
  final bool expands;
  final double? fontSize;
  final double? suffixFontSize;
  final String? counterText;
  final Color? fieldBorderClr;

  const TextEditingWidget(
      {super.key,
      this.hint,
      this.labelText,
      this.suffixText,
      this.suffixWidget,
      this.expands = false,
      this.autoFocus = false,
      this.prefixIcon,
      this.color,
      this.controller,
      this.focusNode,
      this.initialValue,
      this.readOnly,
      this.textAlign,
      this.suffixIcon,
      this.textInputType,
      this.maxLines = 1,
      this.isDense,
      this.onTap,
      this.height,
      this.onFieldSubmitted,
      this.validator,
      this.maxLength,
      this.textInputAction,
      this.inputFormatters,
      this.width,
      this.hintColor,
      this.isBorderEnable = true,
      this.isShadowEnable = false,
      this.fontFamilyText,
      this.suffixFontFamilyText,
      this.suffixFontWeightText,
      this.fontFamilyHint,
      this.fontWeightHint,
      this.fontWeightText,
      this.suffixIconName,
      this.suffixIconHeight,
      this.suffixIconWidth,
      this.onTapSuffixIcon,
      this.passwordVisible = false,
      this.suffixIconWidget,
      this.onChanged,
      this.onEditingComplete,
      this.counterText,
      this.fontSize,
      this.suffixFontSize,
      this.fieldBorderClr});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        autofocus: autoFocus,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        validator: validator,
        onTap: onTap,
        obscureText: passwordVisible,
        maxLength: maxLength,
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.left,
        keyboardType: textInputType,
        expands: expands,
        style: textStyle(),
        cursorColor: color239,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
            enabled: true,
            counterText: counterText ?? "",
            isDense: isDense,
            prefixIcon: prefixIcon,
            focusColor: Colors.black12,
            suffixText: suffixText,
            suffix: suffixWidget,
            suffixStyle: GoogleFonts.acme(textStyle: textStyle()),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: fieldBorderClr ?? color13F, width: 2.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            suffixIcon: suffixIconWidget,
            hintText: hint,
            errorMaxLines: 2,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            hintStyle: textStyle(),
            filled: true,
            fillColor: color ?? Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  BorderSide(color: fieldBorderClr ?? color13F, width: 2.0),
            ),
            labelText: labelText,
            labelStyle: textStyle()),
      ),
    );
  }
}
