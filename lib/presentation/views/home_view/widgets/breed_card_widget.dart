import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/core/extensions/string_extensions.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/presentation/dialogs/bottom_sheet.dart';
import 'package:petfinder/presentation/views/home_view/subviews/breed_detail_view.dart';

@immutable
final class BreedCardWidget extends StatelessWidget {
  const BreedCardWidget({required this.breedModel, required this.url, super.key});

  final BreedModel breedModel;
  final String url;

  @override
  Widget build(BuildContext context) {
    final ImageProvider image = CachedNetworkImageProvider(url, cacheKey: url)..resolve(createLocalImageConfiguration(context));

    return InkWell(
      borderRadius: context.borderRadiusLow,
      onTap: () async => AppDialogs.instance.showBottomSheet(
        context,
        backgroundColor: Colors.black.withOpacity(.4),
        child: BreedDetailViewSheetBody(image: image, breedModel: breedModel),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: context.borderRadiusLow,
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: context.borderRadiusLow.bottomLeft,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: (context.borderRadiusLow * 1.5).topRight,
                    ),
                    color: Colors.black.withOpacity(.24),
                  ),
                  padding: context.paddingLow,
                  child: Text(
                    breedModel.breedName.firstUpper,
                    style: context.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
