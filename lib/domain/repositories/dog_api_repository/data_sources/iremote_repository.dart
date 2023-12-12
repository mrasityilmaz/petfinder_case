import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';

abstract class IDogApiRemoteRepository {
  Future<DataModel<List<BreedModel>>> fetchAllBreeds();

  Future<DataModel<String>> fetchRandomImageBySubBreed({required String breed, String? subBreed});
}
