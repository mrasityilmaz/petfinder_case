// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/foundation.dart';

@immutable
final class APIConstants {
  const APIConstants._();

  static const APIConstants _instance = APIConstants._();

  static APIConstants get instance => _instance;

  ///
  ///  API Constants
  ///

  final String _baseEnvUrl = 'https://dog.ceo/api/';

  String get baseURL => _baseEnvUrl;

  ///
  /// Service Paths
  ///

  final String _allBreedPath = 'breeds/list/all';

  ///
  ///  Service Paths Public Getters
  ///

  String get allBreedPath => _allBreedPath;

  String breedRandomImagePath({required String breed, String? subBreed}) {
    if (subBreed == null) {
      return 'breed/$breed/images/random';
    } else {
      return 'breed/$breed/$subBreed/images/random';
    }
  }
}
