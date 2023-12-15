import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petfinder/assets.dart';
import 'package:petfinder/core/extensions/context_extension.dart';

final class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  static const platform = MethodChannel('com.rasityilmaz.osversion');
  String _osVersion = '0.0.0';

  @override
  void initState() {
    _getOsVersion();
    super.initState();
  }

  Future<void> _getOsVersion() async {
    try {
      final result = await platform.invokeMethod<String>('getOsVersion');
      _osVersion = result ?? '0.0.0';
    } catch (e) {
      _osVersion = '0.0.0';
    }

    setState(() {
      _osVersion = _osVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Assets.info_icon_svg, 'Help', null),
        (Assets.star_icon_svg, 'Rate Us', null),
        (Assets.export_icon_svg, 'Share with Friends', null),
        (Assets.terms_icon_svg, 'Terms of Use', null),
        (Assets.privacy_icon_svg, 'Privacy Policy', null),
        (Assets.os_icon_svg, 'Os Version', _osVersion),
      ].indexed.map((e) {
        final index = e.$1;
        final icon = e.$2.$1;
        final title = e.$2.$2;
        final osVersion = e.$2.$3;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: context.screenPaddingHorizontal,
              child: SizedBox(
                height: kMinInteractiveDimension * 1.3,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: 32,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: context.lowValue),
                    Text(
                      title,
                      style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                    ),
                    const Spacer(),
                    if (osVersion != null) ...[
                      Text(
                        '${Platform.operatingSystem.toUpperCase()}\t$osVersion',
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xFFC7C7CC)),
                      ),
                    ] else ...[
                      Transform.rotate(
                        angle: (math.pi * 135) / 180,
                        child: const Icon(Icons.arrow_back_rounded, size: 20, color: Color(0xFFC7C7CC)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (index != 6)
              Divider(
                height: 0,
                thickness: 2,
                indent: context.screenPadding.left,
              ),
          ],
        );
      }).toList(),
    );
  }
}
