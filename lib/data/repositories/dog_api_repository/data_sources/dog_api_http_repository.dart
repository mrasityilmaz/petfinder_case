import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/base_response_model/base_response_model.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/data/requests/dog_api_requests/fetch_all_breed_request.dart';
import 'package:petfinder/data/requests/dog_api_requests/fetch_random_breed_image_request.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/data_sources/iremote_repository.dart';
import 'package:petfinder/injection/injection_container.dart';
import 'package:petfinder/vendor/rest_api_pkg/rest_api_package.dart';

@Environment('real')
@LazySingleton(as: IDogApiRemoteRepository)
class DogApiHttpRepository implements IDogApiRemoteRepository {
  RestApiHttpService get restApiHttpService => locator<RestApiHttpService>();

  @override
  Future<DataModel<List<BreedModel>>> fetchAllBreeds() async {
    try {
      final request = await restApiHttpService.requestAndHandle<BaseResponseModel<List<BreedModel>>>(
        FetchAllBreedRequest(),
        parseModel: (json) => BaseResponseModel<List<BreedModel>>.fromJson(json, (value) {
          try {
            value as Map<String, dynamic>;

            final breedList = <BreedModel>[];

            for (final element in value.entries) {
              breedList.add(BreedModel(breedName: element.key, subBreeds: (element.value as List).map((e) => e.toString()).toList()));
            }

            return breedList;
          } catch (e) {
            return <BreedModel>[];
          }
        }),
      );

      if (request.success && request.data != null) {
        return Right(request.data!);
      } else if (request.success && request.data == null) {
        return Left(ServerFailure(errorMessage: 'No data found'));
      } else {
        return Left(ServerFailure(errorMessage: 'Something went wrong while fetching data'));
      }
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<String>> fetchRandomImageBySubBreed({required String breed, String? subBreed}) async {
    try {
      final request = await restApiHttpService.requestAndHandle<BaseResponseModel<String?>>(
        FetchRandomBreedImageByBreedRequest(breed: breed, subBreed: subBreed),
        parseModel: (json) => BaseResponseModel<String?>.fromJson(json, (value) {
          return value.toString();
        }),
      );

      if (request.success && request.data != null) {
        ///
        /// Check if the link is healty
        ///

        return Right(request.data!);
      } else if (request.success && request.data == null) {
        return Left(ServerFailure(errorMessage: 'No data found'));
      } else {
        return Left(ServerFailure(errorMessage: 'Something went wrong while fetching data'));
      }
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
