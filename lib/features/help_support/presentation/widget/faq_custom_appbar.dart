import 'package:flutter/material.dart';

class FAQsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FAQsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('FAQs'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
