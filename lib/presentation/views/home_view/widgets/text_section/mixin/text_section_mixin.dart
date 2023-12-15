// ignore_for_file: avoid_positional_boolean_parameters, omit_local_variable_types

part of '../textfield_section.dart';

mixin TextSectionMixin on State<TextFieldSection> {
  late final TextEditingController _textEditingController;
  late final DraggableScrollableController _draggableScrollableController;
  bool isSearchboxExpanded = false;

  @override
  void initState() {
    _textEditingController = TextEditingController()..addListener(textEditingControllerListener);

    _draggableScrollableController = DraggableScrollableController();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  void onChangedExpanded(bool value) {
    setState(() {
      isSearchboxExpanded = value;
    });
  }

  (int, double) getsize(String text, double maxW) {
    final tp = TextPainter(
      text: TextSpan(
        children: [
          for (final t in text.characters)
            TextSpan(
              text: t,
            ),
        ],
        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxW);

    final lines = tp.computeLineMetrics();

    final numberOfLines = lines.length;

    return (numberOfLines, lines.isNotEmpty ? lines.first.height : 19);
  }

  void textEditingControllerListener() {
    final text = _textEditingController.text;
    final size = getsize(text, context.screenSize.width - (context.screenPadding * .5).horizontal - 6);
    final double x = ((size.$1) * size.$2) + kMinInteractiveDimension * .5 + context.screenPadding.top;

    _draggableScrollableController.jumpTo(_draggableScrollableController.pixelsToSize(x < _draggableScrollableController.sizeToPixels(1) ? x : _draggableScrollableController.sizeToPixels(1)));
  }
}
