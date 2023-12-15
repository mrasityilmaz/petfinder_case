import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';

abstract class IDogApiRepository {
  Future<DataModel<List<BreedModel>>> fetchAllBreeds();

  Future<DataModel<String>> fetchRandomImageBySubBreed({required String breed, String? subBreed});

  Future<DataModel<List<({String url, BreedModel breedModel, bool isCachedSuccessfully})>>> addListOfImagesIntoCache({required List<(String, BreedModel)> images});
}
