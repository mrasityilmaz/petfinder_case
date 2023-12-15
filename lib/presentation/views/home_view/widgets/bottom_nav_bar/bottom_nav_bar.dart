import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petfinder/assets.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/presentation/dialogs/bottom_sheet.dart';
import 'package:petfinder/presentation/views/home_view/subviews/settings_view.dart';

part 'bottom_nav_bar_painter.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BottomAppBarPainter(
        horizontalPadding: context.screenPaddingHorizontal.left,
        backgroundColor: const Color(0xFFF2F2F7),
        borderColor: context.theme.inputDecorationTheme.iconColor,
      ),
      willChange: true,
      child: SafeArea(
        child: Padding(
          padding: context.paddingNormalTop + context.paddingNormalBottom * .5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.home_icon_svg),
                  SizedBox(height: context.lowValue * .5),
                  Text(
                    'Home',
                    style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: context.colors.primary),
                  ),
                ],
              ),
              Container(
                width: 2.5,
                height: kMinInteractiveDimension * .6,
                decoration: BoxDecoration(
                  color: context.theme.inputDecorationTheme.iconColor,
                  borderRadius: context.borderRadiusLow * .5,
                ),
              ),
              GestureDetector(
                onTap: () async => AppDialogs.instance.showBottomSheet<void>(
                  context,
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  enableDrag: true,
                  isDismissible: true,
                  showDragHandle: true,
                  useSafeArea: true,
                  child: const SettingView(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.settings_icon_svg),
                    SizedBox(height: context.lowValue * .5),
                    Text(
                      'Settings',
                      style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
