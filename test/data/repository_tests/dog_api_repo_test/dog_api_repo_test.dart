import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petfinder/core/errors/errors.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/dog_api_repository.dart';
import 'package:petfinder/injection/injection_container.dart';

void main() async {
  ///
  /// That part is unnecessary for testing but this way provides you to test your repository with your mock or real data.
  ///

  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Dependency Injection Configuration for Mock Data
  /// You can change the default environment from here.
  ///
  ///
  await configureDependencies(defaultEnv: 'real');

  ///
  /// Here is the repository definition.
  ///
  late IDogApiRepository dogApiRepository;
  var breedImageList = <String>[];
  var breedList = <BreedModel>[];

  setUp(() {
    dogApiRepository = locator<IDogApiRepository>();
  });

  group('Dog Api Repository Tests', () {
    test('Fetch BreedList Test', () async {
      final result = await dogApiRepository.fetchAllBreeds();

      expect(result.isRight(), true);

      expect(result.asRight(), isA<List<BreedModel>>());

      expect(result.asRight(), isNotEmpty);

      if (result.isRight()) {
        breedList = result.asRight();
      }
    });

    test('Fetch Random Dog Image by only Breed Test', () async {
      const breed = 'akita';

      final result = await dogApiRepository.fetchRandomImageBySubBreed(breed: breed);

      expect(result.isRight(), true);

      expect(result.asRight(), isA<String>());

      expect(result.asRight(), isNotEmpty);

      expect(result.asRight(), contains(breed));
    });
    test('Fetch Random Dog Image by Breed Test', () async {
      const breed = 'terrier';
      const subBreed = 'american';

      final result = await dogApiRepository.fetchRandomImageBySubBreed(breed: breed, subBreed: subBreed);

      expect(result.isRight(), true);

      expect(result.asRight(), isA<String>());

      expect(result.asRight(), isNotEmpty);

      expect(result.asRight(), contains('$breed-$subBreed'));
    });

    test('Fetch Random Image for each Breed Test', () async {
      final futureList = await Future.wait(
        breedList.map((e) {
          return dogApiRepository.fetchRandomImageBySubBreed(breed: e.breedName);
        }).toList(),
      );

      expect(futureList, everyElement(isA<Right<Failure, String>>()));

      if (futureList.every((element) => element.isRight() && element.asRight().isNotEmpty)) {
        breedImageList = futureList.map((e) => e.asRight()).toList();
      }

      expect(breedImageList.length, equals(breedList.length));
    });
  });
}
// https://dog.ceo/api/breed/hound/images/random
// https://dog.ceo/api/breed/hound/afghan/images/random 
