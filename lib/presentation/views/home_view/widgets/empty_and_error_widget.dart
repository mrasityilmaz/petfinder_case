import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';

@immutable
final class EmptyAndErrorWidget extends StatelessWidget {
  const EmptyAndErrorWidget({
    this.title,
    super.key,
    this.message,
  });
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title ?? 'Something went wrong',
          style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        SizedBox(height: context.normalValue),
        Center(
          child: Text(
            message ?? '',
            style: context.theme.inputDecorationTheme.hintStyle,
          ),
        ),
      ],
    );
  }
}
