// ignore_for_file: use_build_context_synchronously, omit_local_variable_types

part of '../home_view.dart';

mixin HomeViewMixin on State<HomeView> {
  late final DogBloc dogBlocProvider;

  @override
  void initState() {
    dogBlocProvider = BlocProvider.of<DogBloc>(context);

    dogBlocProvider.add(FetchAllBreedsEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  /// Fetch random image for each breed and add them into cache
  ///
  void removeSplash() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        debugPrint('Removing splash screen');
        FlutterNativeSplash.remove();
      });
    } catch (e) {
      FlutterNativeSplash.remove();
      debugPrint(e.toString());
    }
  }

  void onListenDogBloc(BuildContext context, DogBlocState state) {
    if (state is SuccessState<FetchAllBreedsEvent, List<BreedModel>>) {
      dogBlocProvider.add(FetchRandomImageForeachBreed(breedList: state.data));
    }
    if (state is SuccessState<FetchRandomImageForeachBreed, List<BreedModel>>) {
      removeSplash();
    }
  }

  bool buildWhen(DogBlocState previous, DogBlocState current) {
    if (current is SuccessState<FetchRandomImageForeachBreed, List<BreedModel>>) {
      return true;
    } else if (current is SuccessState<SearchBreedEvent, List<BreedModel>>) {
      return true;
    } else if (current is ChangeSourceState<List<BreedModel>>) {
      return true;
    } else {
      return false;
    }
  }
}
