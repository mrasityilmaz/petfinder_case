import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/presentation/views/home_view/widgets/text_section/expanded_text_field_widget.dart';
import 'package:petfinder/presentation/views/home_view/widgets/text_section/small_textfield_widget.dart';

part 'mixin/text_section_mixin.dart';

final class TextFieldSection extends StatefulWidget {
  const TextFieldSection({super.key});

  @override
  State<TextFieldSection> createState() => _TextFieldSectionState();
}

class _TextFieldSectionState extends State<TextFieldSection> with TextSectionMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
      child: isSearchboxExpanded
          ? ExpandedTextFieldWidget(
              textEditingController: _textEditingController,
              draggableScrollableController: _draggableScrollableController,
              isSearchboxExpanded: onChangedExpanded,
            )
          : SmallTextFieldWidget(
              isSearchboxExpanded: onChangedExpanded,
              textEditingController: _textEditingController,
            ),
    );
  }
}
