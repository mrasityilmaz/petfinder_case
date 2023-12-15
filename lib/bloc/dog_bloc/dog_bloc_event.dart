part of 'dog_bloc.dart';

abstract class DogBlocEvent extends Equatable {}

final class FetchRandomImageByBreedEvent extends DogBlocEvent {
  FetchRandomImageByBreedEvent({required this.breed, this.subBreed});

  final String breed;
  final String? subBreed;
  @override
  List<Object?> get props => [breed, subBreed];
}

final class FetchAllBreedsEvent extends DogBlocEvent {
  @override
  List<Object> get props => [this];
}

final class FetchRandomImageForeachBreed extends DogBlocEvent {
  FetchRandomImageForeachBreed({required this.breedList});

  final List<BreedModel> breedList;
  @override
  List<Object> get props => [this];
}

final class AddNewBreedToBreedListWithImageEvent extends DogBlocEvent {
  AddNewBreedToBreedListWithImageEvent({required this.breedModel});

  final BreedModel breedModel;
  @override
  List<Object> get props => [breedModel];
}

final class RemoveNewBreedToBreedListWithImageEvent extends DogBlocEvent {
  RemoveNewBreedToBreedListWithImageEvent({required this.breedModel});

  final BreedModel breedModel;
  @override
  List<Object> get props => [breedModel];
}

final class SearchBreedEvent extends DogBlocEvent {
  SearchBreedEvent({required this.searchText});

  final String searchText;
  @override
  List<Object> get props => [searchText];
}
