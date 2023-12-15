import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/core/navigator/app_navigator.dart';
import 'package:petfinder/injection/injection_container.dart';

@immutable
final class NewRandomImageViewSheetBody extends StatelessWidget {
  const NewRandomImageViewSheetBody({required this.imageUrl, required this.onError, super.key});
  final String imageUrl;
  final void Function() onError;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: context.borderRadiusLow * 1.5,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            cacheKey: imageUrl,
            width: context.screenSize.width * .65,
            height: context.screenSize.width * .65,
            fit: BoxFit.cover,
            errorListener: (err) {
              onError();
            },
          ),
        ),
        SizedBox(height: context.normalValue),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: context.paddingLow,
            backgroundColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.padded,
            minimumSize: const Size(1, 1),
          ),
          onPressed: () {
            locator<AppRouter>().pop();
          },
          child: const Icon(Icons.close, color: Colors.black),
        ),
      ],
    );
  }
}
