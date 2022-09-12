import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color_resources.dart';

class TextWidget extends StatefulWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? textHeight;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  const TextWidget({
    super.key,
    this.text,
    this.color = colorBlack,
    this.fontSize,
    this.fontFamily,
    this.letterSpacing,
    this.textAlign,
    this.onTap,
    this.fontWeight = FontWeight.normal,
    this.textOverflow,
    this.maxLines,
    this.textHeight,
    this.textStyle,
    this.decoration,
  });

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Text(
        widget.text!,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        softWrap: true,
        overflow: widget.textOverflow,
        style: widget.textStyle ??
            GoogleFonts.acme(
                textStyle: TextStyle(
              color: widget.color,
              height: widget.textHeight,
              fontSize: widget.fontSize ?? 14,
              letterSpacing: widget.letterSpacing,
              decoration: widget.decoration,
              fontWeight: widget.fontWeight,
            )),
      ),
    );
  }
}
