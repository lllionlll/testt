import 'package:flutter/widgets.dart';

import 'app_touchable.dart';


class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final double? textSize;
  final FontStyle? textFontStyle;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final LinearGradient? gradient;
  final Color? color;
  final Color? textColor;

  const AppButton(
      {Key? key,
      this.width,
      this.height,
      this.radius,
      this.padding,
      this.text,
      this.textSize,
      required this.onPressed,
      this.margin,
      this.child,
      this.boxShadow,
      this.gradient,
      this.color,
      this.textColor,
      this.textFontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: AppTouchable(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.symmetric(vertical: 6.0, horizontal: 36.0),
        onPressed: onPressed,
        outlinedBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 17),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 17),
          boxShadow: boxShadow,
        ),
        child: child ??
            Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize ?? 16.0,
                color: textColor ?? const Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontStyle: textFontStyle ?? FontStyle.normal,
              ),
            ),
      ),
    );
  }
}
