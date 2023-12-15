import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';

final class SmallTextFieldWidget extends StatelessWidget {
  const SmallTextFieldWidget({required this.isSearchboxExpanded, required this.textEditingController, super.key});
  final ValueChanged<bool> isSearchboxExpanded;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSearchboxExpanded(true);
      },
      child: Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: context.borderRadiusLow,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.black.withOpacity(.16),
            ),
          ],
          border: Border.all(color: const Color(0xffe5e5ea), width: 2),
        ),
        margin: context.screenPaddingVertical + EdgeInsets.symmetric(horizontal: context.screenPaddingHorizontal.left - 2),
        padding: context.paddingLow,
        child: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: textEditingController,
                builder: (BuildContext context, TextEditingValue value, Widget? child) {
                  return Text(
                    value.text.trim().isNotEmpty ? value.text.trim() : 'Search',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.inputDecorationTheme.hintStyle,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
