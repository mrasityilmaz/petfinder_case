import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/core/navigator/app_navigator.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/dog_api_repository.dart';
import 'package:petfinder/injection/injection_container.dart';
import 'package:petfinder/vendor/rest_api_pkg/requests/rest_api_request.dart';

part 'dog_bloc_event.dart';
part 'dog_bloc_state.dart';

final class DogBloc extends Bloc<DogBlocEvent, DogBlocState> {
  DogBloc() : super(InitialState()) {
    on<DogBlocEvent>(
      (event, emit) async {
        if (event is FetchAllBreedsEvent) {
          await _fetchAllBreeds(emit: emit);
        }
        if (event is FetchRandomImageForeachBreed) {
          await _fetchRandomImageForeachAllBreed(emit: emit, breedList: event.breedList);
        }
        if (event is FetchRandomImageByBreedEvent) {
          await _fetchRandomImageByBreed(emit: emit, breed: event.breed);
        }
        if (event is AddNewBreedToBreedListWithImageEvent) {
          _addNewBreedToBreedListWithImage(emit: emit, breedModel: event.breedModel);
        }
        if (event is RemoveNewBreedToBreedListWithImageEvent) {
          _removeNewBreedToBreedListWithImage(emit: emit, breedModel: event.breedModel);
        }
        if (event is SearchBreedEvent) {
          await _searchBreed(emit: emit, searchText: event.searchText);
        }
      },
      transformer: sequential(),
    );
  }

  final IDogApiRepository dogApiRepository = locator<IDogApiRepository>();

  List<BreedModel> _breedList = List<BreedModel>.empty(growable: true);
  List<BreedModel> get breedList => _breedList.where((element) => element.imageUrl != null).toList();
  List<BreedModel> _searchList = List<BreedModel>.empty(growable: true);
  List<BreedModel> get searchList => _searchList.where((element) => element.imageUrl != null).toList();

  Future<void> _fetchAllBreeds({
    required Emitter<DogBlocState> emit,
  }) async {
    try {
      emit(LoadingState());
      final result = await dogApiRepository.fetchAllBreeds();
      if (result.isRight()) {
        _breedList
          ..clear()
          ..addAll(result.getOrElse(() => []));
        emit(SuccessState<FetchAllBreedsEvent, List<BreedModel>>(data: result.getOrElse(() => [])));
      } else {
        emit(FailureState(failure: result.asLeft()));
      }
    } catch (e) {
      emit(FailureState(failure: ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _fetchRandomImageByBreed({
    required Emitter<DogBlocState> emit,
    required String breed,
    String? subBreed,
  }) async {
    try {
      emit(LoadingState());
      final result = await dogApiRepository.fetchRandomImageBySubBreed(breed: breed, subBreed: subBreed);
      if (result.isRight()) {
        final isHealty = await Dio().getUri(Uri.parse(result.asRight())).then((value) => value.statusCode == 200).catchError((e) => false);
        if (isHealty) {
          await precacheImage(
            CachedNetworkImageProvider(result.asRight(), cacheKey: result.asRight()),
            locator<AppRouter>().navigatorKey.currentContext!,
            size: const Size.square(256),
            onError: (err, s) {
              emit(FailureState(failure: ServerFailure(errorMessage: err.toString())));
              return;
            },
          ).then((value) {
            emit(SuccessState<FetchRandomImageByBreedEvent, String>(data: result.asRight()));
          });
        } else {
          emit(FailureState(failure: ServerFailure(errorMessage: 'Something went wrong while fetching data')));
        }
      } else {
        emit(FailureState(failure: result.asLeft()));
      }
    } catch (e) {
      emit(FailureState(failure: ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _fetchRandomImageForeachAllBreed({
    required Emitter<DogBlocState> emit,
    required List<BreedModel> breedList,
  }) async {
    try {
      emit(LoadingState());
      final fetchResult = await Future.wait(
        breedList.map((element) {
          return dogApiRepository.fetchRandomImageBySubBreed(breed: element.breedName).then((value) {
            if (value.isRight()) {
              return (value.asRight(), element);
            }
            return null;
          });
        }).toList(),
      );

      final imageUrls = fetchResult.whereType<(String, BreedModel)>().toList();

      _breedList = _breedList.map((e) {
        if (imageUrls.any((element) => element.$2 == e)) {
          return e.copyWith(imageUrl: imageUrls.firstWhere((element) => element.$2 == e).$1);
        }
        return e;
      }).toList();

      await Future.wait(
        _breedList.where((element) => element.imageUrl != null).map((e) {
          _addNewBreedToBreedListWithImage(emit: emit, breedModel: e);
          return precacheImage(
            CachedNetworkImageProvider(e.imageUrl!, cacheKey: e.imageUrl),
            locator<AppRouter>().navigatorKey.currentContext!,
            size: const Size.square(256),
            onError: (err, s) {
              _removeNewBreedToBreedListWithImage(emit: emit, breedModel: e);
            },
          );
        }).toList(),
      ).whenComplete(() {
        emit(SuccessState<FetchRandomImageForeachBreed, List<BreedModel>>(data: _breedList.where((element) => element.imageUrl != null).toList()));
      });
    } catch (e) {
      emit(FailureState(failure: ServerFailure(errorMessage: e.toString())));
    }
  }

  void _addNewBreedToBreedListWithImage({
    required Emitter<DogBlocState> emit,
    required BreedModel breedModel,
  }) {
    try {
      if (_breedList.any((element) => element == breedModel || element.breedName == breedModel.breedName)) {
        _breedList[_breedList.indexOf(breedModel)] = breedModel;
      }
    } catch (e) {}
  }

  void _removeNewBreedToBreedListWithImage({
    required Emitter<DogBlocState> emit,
    required BreedModel breedModel,
  }) {
    try {
      _breedList.removeWhere((element) => element == breedModel || element.breedName == breedModel.breedName);
    } catch (e) {}
  }

  Future<void> _searchBreed({
    required Emitter<DogBlocState> emit,
    required String searchText,
  }) async {
    try {
      final searchResult = breedList.where((element) {
        return element.breedName.contains(searchText.toLowerCase()) || element.breedName.startsWith(searchText.toLowerCase());
      }).toList();

      _searchList = searchResult;

      emit(SuccessState<SearchBreedEvent, List<BreedModel>>(data: searchResult));
    } catch (e) {
      emit(FailureState(failure: ServerFailure(errorMessage: e.toString())));
    }
  }
}
