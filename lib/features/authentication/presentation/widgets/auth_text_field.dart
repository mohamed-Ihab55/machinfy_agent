import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.errorText,
    this.onChanged,
    this.hintStyle,
  });

  final String label;
  final String hint;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType? keyboardType;

  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Style.fieldLabel),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            style: Style.fieldText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hintStyle ?? Style.fieldHint,
              filled: true,
              fillColor: kFieldFillColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),

              prefixIcon: Icon(prefixIcon, size: 20),
              prefixIconColor: kHintTextColor,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 46,
                minHeight: 20,
              ),

              suffixIcon: suffixIcon == null
                  ? null
                  : InkWell(
                      onTap: onSuffixTap,
                      borderRadius: BorderRadius.circular(999),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(suffixIcon, size: 20),
                      ),
                    ),
              suffixIconColor: kHintTextColor,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kPrimaryColor, width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kErrorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kErrorColor, width: 1.2),
              ),

              errorText: errorText,
              errorStyle: Style.errorSmall,
            ),
          ),
        ),
      ],
    );
  }
}
