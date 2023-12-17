import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/core/services/mock_reader_service.dart';
import 'package:petfinder/data/models/base_response_model/base_response_model.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/data_sources/iremote_repository.dart';
import 'package:petfinder/injection/injection_container.dart';
import 'package:petfinder/vendor/rest_api_pkg/requests/rest_api_request.dart';

@Environment('mock')
@LazySingleton(as: IDogApiRemoteRepository)
class DogApiMockRepository implements IDogApiRemoteRepository {
  @override
  Future<DataModel<List<BreedModel>>> fetchAllBreeds() async {
    try {
      final response = await locator<MockReaderService>().callMock<BaseResponseModel<List<BreedModel>>>(
        'test/fixtures/dog_breed_list.json',
        parseModel: (Map<String, dynamic> json) {
          final baseResponseModel = BaseResponseModel<List<BreedModel>>.fromJson(json, (value) {
            value as Map<String, dynamic>;

            final breedList = <BreedModel>[];

            for (final element in value.entries) {
              breedList.add(BreedModel(breedName: element.key, subBreeds: (element.value as List).map((e) => e.toString()).toList()));
            }

            return breedList;
          });
          return baseResponseModel;
        },
      );

      if (response.success) {
        return Right(response.data ?? []);
      } else {
        return Left(ServerFailure(errorMessage: 'Something went wrong while fetching data'));
      }
    } catch (e) {
      if (e is Response) {
        ///
        /// This is the case when you have some error from parsing or something else
        ///
        return Left(UnExpectedFailure(data: e, errorMessage: e.statusMessage));
      } else {
        ///
        /// I dont know what is the error so I will return server failure
        ///

        return Left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<DataModel<String>> fetchRandomImageBySubBreed({required String breed, String? subBreed}) async {
    return Right('https://images.dog.ceo/breeds/$breed${subBreed != null ? '-$subBreed' : ''}/fake.jpg');
  }
}
