import 'package:injectable/injectable.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/data_sources/ilocal_repository.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/data_sources/iremote_repository.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/dog_api_repository.dart';

@LazySingleton(as: IDogApiRepository)
class DogApiRepository implements IDogApiRepository {
  const DogApiRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final IDogApiRemoteRepository remoteDataSource;
  final IDogApiLocalRepository localDataSource;

  @override
  Future<DataModel<List<BreedModel>>> fetchAllBreeds() async {
    return remoteDataSource.fetchAllBreeds();
  }

  @override
  Future<DataModel<String>> fetchRandomImageBySubBreed({required String breed, String? subBreed}) async {
    return remoteDataSource.fetchRandomImageBySubBreed(breed: breed, subBreed: subBreed);
  }

  @override
  Future<DataModel<List<({String url, bool isCachedSuccessfully})>>> addListOfImagesIntoCache({required List<String> images}) async {
    return localDataSource.addListOfImagesIntoCache(images: images);
  }
}
