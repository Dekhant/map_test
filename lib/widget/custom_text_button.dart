import 'package:flutter/material.dart';
import 'package:map_task/gen/colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.horizontalPadding,
    this.backgroundColor = AppColors.primaryRed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? horizontalPadding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalPadding == null ? width : null,
      height: 44,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
