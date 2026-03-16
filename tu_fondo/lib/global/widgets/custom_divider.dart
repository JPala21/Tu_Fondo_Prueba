import 'package:flutter/material.dart';

class CustomDividerText extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final Color dividerColor;
  final Color textColor;
  final double textSize;
  final double thickness;

  const CustomDividerText({
    super.key,
    required this.text,
    this.horizontalPadding = 14,
    this.dividerColor = const Color(0xFFDDDDDD),
    this.textColor = const Color(0xFF666666),
    this.textSize = 14,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: dividerColor, thickness: thickness),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(
            text,
            style: TextStyle(fontSize: textSize, color: textColor),
          ),
        ),
        Expanded(
          child: Divider(color: dividerColor, thickness: thickness),
        ),
      ],
    );
  }
}
