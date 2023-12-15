import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:petfinder/bloc/dog_bloc/dog_bloc.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/context_extension.dart';
import 'package:petfinder/core/navigator/app_routes.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/presentation/views/home_view/widgets/app_bar.dart';
import 'package:petfinder/presentation/views/home_view/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:petfinder/presentation/views/home_view/widgets/breed_grid_view.dart';
import 'package:petfinder/presentation/views/home_view/widgets/empty_and_error_widget.dart';
import 'package:petfinder/presentation/views/home_view/widgets/text_section/textfield_section.dart';

part 'mixin/home_view_mixin.dart';

@RoutePage(name: AppRoutes.homeViewRoute)
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: const AppBarWidget(),
        bottomNavigationBar: const BottomNavigationBarWidget(),
        bottomSheet: const TextFieldSection(),
        body: BlocConsumer<DogBloc, DogBlocState>(
          listener: onListenDogBloc,
          buildWhen: buildWhen,
          builder: (context, state) {
            if (state is FailureState) {
              return EmptyAndErrorWidget(message: (state.failure as Failure).errorMessage);
            }

            if (state is SuccessState<FetchRandomImageForeachBreed, List<BreedModel>> || state is SuccessState<SearchBreedEvent, List<BreedModel>> || state is ChangeSourceState<List<BreedModel>>) {
              final data = state is ChangeSourceState<List<BreedModel>>
                  ? state.data
                  : (state is SuccessState<SearchBreedEvent, List<BreedModel>> ? state.data : (state as SuccessState<FetchRandomImageForeachBreed, List<BreedModel>>).data);

              if (data.isEmpty) {
                return const EmptyAndErrorWidget(
                  title: 'No result found',
                  message: 'Try searching with another word',
                );
              }
              return BreedGridView(data: data);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
