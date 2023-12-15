// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder/bloc/dog_bloc/dog_bloc.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';

final class ExpandedTextFieldWidget extends StatelessWidget {
  const ExpandedTextFieldWidget({required this.textEditingController, required this.draggableScrollableController, required this.isSearchboxExpanded, super.key});
  final TextEditingController textEditingController;
  final DraggableScrollableController draggableScrollableController;
  final ValueChanged<bool> isSearchboxExpanded;

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);
    return DraggableScrollableSheet(
      controller: draggableScrollableController,
      initialChildSize: .2,
      shouldCloseOnMinExtent: false,
      snap: true,
      snapSizes: const [.2, 1],
      minChildSize: .2,
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (ctx, cts) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: context.borderRadiusNormal.topLeft),
              border: const Border(
                left: BorderSide(color: Color(0xffe5e5ea), width: 2),
                right: BorderSide(color: Color(0xffe5e5ea), width: 2),
                top: BorderSide(color: Color(0xffe5e5ea), width: 2),
              ),
            ),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              controller: scrollController,
              children: [
                SizedBox(
                  height: kMinInteractiveDimension * .5,
                  child: Center(
                    child: Container(
                      height: 3.5,
                      width: kMinInteractiveDimension,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: context.theme.inputDecorationTheme.iconColor,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: cts.maxHeight - kMinInteractiveDimension * .5,
                  ),
                  child: TextField(
                    autofocus: true,
                    expands: true,
                    maxLines: null,
                    onTapOutside: (s) {
                      draggableScrollableController.jumpTo(0);
                      isSearchboxExpanded(false);
                    },
                    onSubmitted: (s) {
                      draggableScrollableController.jumpTo(0);
                      isSearchboxExpanded(false);
                      if (s.trim().isNotEmpty) {
                        dogBloc.add(SearchBreedEvent(searchText: s.trim()));
                      }
                    },
                    onChanged: (s) {
                      if (s.trim().isNotEmpty) {
                        dogBloc.add(SearchBreedEvent(searchText: s.trim()));
                      } else {
                        dogBloc.emit(ChangeSourceState<List<BreedModel>>(data: dogBloc.breedList));
                      }
                    },
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    keyboardType: TextInputType.name,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))],
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.search,
                    style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: context.screenPadding * .5,
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search',
                    ),
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
