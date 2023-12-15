import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder/bloc/dog_bloc/dog_bloc.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/core/extensions/string_extensions.dart';
import 'package:petfinder/core/navigator/app_navigator.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/injection/injection_container.dart';
import 'package:petfinder/presentation/dialogs/bottom_sheet.dart';
import 'package:petfinder/presentation/views/home_view/subviews/new_random_image_view.dart';

@immutable
final class BreedDetailViewSheetBody extends StatelessWidget {
  const BreedDetailViewSheetBody({required this.image, required this.breedModel, super.key});
  final ImageProvider image;
  final BreedModel breedModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: context.mediaQuery.removeViewInsets().removeViewPadding().size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              context.screenPaddingVertical.vertical * 2 -
              context.normalValue * 2,
          width: context.screenSize.width * .85,
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: context.borderRadiusLow * 1.5,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: (context.borderRadiusLow * 1.5).topRight),
                    image: DecorationImage(image: image, fit: BoxFit.cover, filterQuality: FilterQuality.high),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: context.paddingLow * .5,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(1, 1),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          locator<AppRouter>().pop();
                        },
                        child: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: context.paddingNormalVertical * .5,
                      child: Text(
                        'Breed',
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: context.colors.primary),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 2,
                      indent: context.screenPadding.left * 2,
                      endIndent: context.screenPadding.right * 2,
                      color: context.theme.inputDecorationTheme.iconColor,
                    ),
                    Padding(
                      padding: context.paddingNormalVertical * .5,
                      child: Text(
                        breedModel.breedName.firstUpper,
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: context.normalValue),
                    Padding(
                      padding: context.paddingNormalVertical * .5,
                      child: Text(
                        'Sub Breed',
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: context.colors.primary),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 2,
                      indent: context.screenPadding.left * 2,
                      endIndent: context.screenPadding.right * 2,
                      color: context.theme.inputDecorationTheme.iconColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: context.paddingNormalVertical * .5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: breedModel.subBreeds.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: context.paddingLowBottom,
                              child: Center(
                                child: Text(
                                  breedModel.subBreeds[index].firstUpper,
                                  style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: context.normalValue),
                    _GenerateButton(breedModel: breedModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({
    required this.breedModel,
  });

  final BreedModel breedModel;

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);
    return Padding(
      padding: context.screenPadding * .8,
      child: Row(
        children: [
          Expanded(
            child: BlocConsumer<DogBloc, DogBlocState>(
              listener: (previous, current) async {
                if (current is SuccessState<FetchRandomImageByBreedEvent, String>) {
                  await AppDialogs.instance.showBottomSheet<void>(
                    context,
                    backgroundColor: Colors.black.withOpacity(.2),
                    child: NewRandomImageViewSheetBody(
                      imageUrl: current.data,
                      onError: () {},
                    ),
                  );
                } else if (current is FailureState) {
                  dogBloc.add(
                    FetchRandomImageByBreedEvent(
                      breed: breedModel.breedName,
                      subBreed: breedModel.subBreeds.isNotEmpty ? (breedModel.subBreeds[Random().nextInt(breedModel.subBreeds.length)]) : null,
                    ),
                  );
                }
              },
              bloc: dogBloc,
              buildWhen: (previous, current) => previous is! LoadingState || current is SuccessState<FetchRandomImageByBreedEvent, String>,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    dogBloc.add(
                      FetchRandomImageByBreedEvent(
                        breed: breedModel.breedName,
                        subBreed: breedModel.subBreeds.isNotEmpty ? (breedModel.subBreeds[Random().nextInt(breedModel.subBreeds.length)]) : null,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    shape: RoundedRectangleBorder(borderRadius: context.borderRadiusLow),
                    padding: context.paddingNormalVertical,
                  ),
                  child: (state is LoadingState)
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 1.5,
                          ),
                        )
                      : Text(
                          'Generate',
                          style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
