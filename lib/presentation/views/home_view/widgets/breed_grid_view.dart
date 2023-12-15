import 'package:flutter/material.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/presentation/views/home_view/widgets/breed_card_widget.dart';

@immutable
final class BreedGridView extends StatelessWidget {
  const BreedGridView({
    required this.data,
    super.key,
  });

  final List<BreedModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: context.screenPaddingHorizontal,
            child: GridView.builder(
              shrinkWrap: true,
              padding: context.screenPaddingVertical + EdgeInsets.only(bottom: context.screenPaddingVertical.vertical + kToolbarHeight + kBottomNavigationBarHeight + context.normalValue * 2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.screenPaddingHorizontal.left,
                mainAxisSpacing: context.screenPaddingHorizontal.left,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return BreedCardWidget(
                  breedModel: data[index],
                  url: data[index].imageUrl!,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
