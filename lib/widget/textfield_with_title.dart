import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_task/gen/colors.dart';

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    required this.text,
    required this.controller,
    this.obscureText = false,
    this.isRequired = false,
    this.isSquared = false,
    this.isBold = false,
    this.isCapitalized = false,
    this.haveError = false,
    this.displayError = true,
    this.keyboardType,
    this.onChange,
    this.onEditingComplete,
    this.inputFormatters,
    this.errorMessage,
    this.maxLength,
    this.suffixIcon,
    super.key,
  });

  final String text;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isRequired;
  final bool isSquared;
  final bool isBold;
  final bool isCapitalized;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final bool haveError;
  final bool displayError;
  final String? errorMessage;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: isRequired ? '*' : '',
            style: const TextStyle(color: AppColors.primaryRed),
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: isBold ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(241, 249, 255, 1),
            borderRadius: BorderRadius.circular(isSquared ? 0 : 1),
            border: Border.all(color: haveError ? AppColors.primaryRed : Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: TextField(
              maxLength: maxLength,
              onChanged: onChange,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              onEditingComplete: onEditingComplete,
              textCapitalization: isCapitalized ? TextCapitalization.characters : TextCapitalization.sentences,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: InputBorder.none,
                suffix: Align(heightFactor: 1, widthFactor: 1, child: suffixIcon),
              ),
            ),
          ),
        ),
        if (haveError && displayError) ...[
          const SizedBox(height: 8),
          Text(
            errorMessage ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryRed,
            ),
          )
        ]
      ],
    );
  }
}
