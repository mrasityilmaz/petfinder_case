import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';

@immutable
final class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Pet Finder',
        style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
