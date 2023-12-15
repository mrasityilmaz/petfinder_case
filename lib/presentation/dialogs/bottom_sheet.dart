import 'package:flutter/material.dart';

final class AppDialogs {
  const AppDialogs._();

  static const AppDialogs _instance = AppDialogs._();

  static AppDialogs get instance => _instance;

  Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool showDragHandle = false,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    bool enableDrag = false,
    bool isDismissible = false,
    double elevation = 0,
    Color barrierColor = Colors.transparent,
    Color? backgroundColor = Colors.white,
    bool useSafeArea = false,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor,
      useRootNavigator: useRootNavigator,
      enableDrag: enableDrag,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      elevation: 0,
      useSafeArea: useSafeArea,
      builder: (context) {
        return child;
      },
    );
  }
}
