import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';

abstract class IDogApiLocalRepository {
  ///
  ///  Local repository interface
  ///  This is where you define your local data source methods
  ///  For example:
  ///  Future<Either<Failure, DataModel<Data>>> getDataFromLocal();
  ///

  Future<DataModel<List<({String url, BreedModel breedModel, bool isCachedSuccessfully})>>> addListOfImagesIntoCache({required List<(String, BreedModel)> images});
}
