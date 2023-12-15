import 'package:dartz/dartz.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/core/services/cache_manager_service.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/data_sources/ilocal_repository.dart';
import 'package:petfinder/injection/injection_container.dart';

class DogApiHiveRepository implements IDogApiLocalRepository {
  @override
  Future<DataModel<List<({String url, BreedModel breedModel, bool isCachedSuccessfully})>>> addListOfImagesIntoCache({required List<(String, BreedModel)> images}) async {
    try {
      final result = await locator<CustomCacheManager>().downloadImagesToCache(listOfImageUrls: images);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  ///
  /// If you want to use Hive, you can use this class.
  /// You can use this class to save data to the local database and etc.
  ///
}
