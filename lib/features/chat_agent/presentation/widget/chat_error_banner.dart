import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/typography.dart';

class ChatErrorBanner extends StatelessWidget {
  final String message;

  const ChatErrorBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: kErrormsg!,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: kErrormsg, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Style.bodysmall.copyWith(color: kTexttErrormsg),
            ),
          ),
        ],
      ),
    );
  }
}
