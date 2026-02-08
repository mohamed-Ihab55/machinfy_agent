import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';

class Style {
  // ================= HEADINGS =================
  static const headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: kTextColor,
  );

  static const headingMedium = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: kTextColor,
  );

  // ================= BODY =================
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kTextColor,
  );

  static const bodysmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kTextColor,
  );

  // ================= SUBTITLES =================
  static const subTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6B7280),
  );

  // ================= SMALL GREY TEXT =================
  static const smallGrey = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6B7280),
  );

  // ================= LINKS =================
  static const link = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2563EB),
  );

  static const linkUnderline = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2563EB),
    decoration: TextDecoration.underline,
    decorationThickness: 1.2,
  );

  static const errorSmall = TextStyle(
    fontSize: 11.5,
    height: 1.1,
    color: Color(0xFFEF4444),
  );

  static const appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: kTextColor,
  );
  // ================= FORMS =================
  static const fieldLabel = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: kTextColor,
  );

  static const fieldText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kTextColor,
  );

  static const fieldHint = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    color: Color(0xFF9CA3AF),
  );
}
