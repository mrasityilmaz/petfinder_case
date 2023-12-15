import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';

@immutable
@LazySingleton()
final class CustomCacheManager {
  factory CustomCacheManager() {
    return instance;
  }

  CustomCacheManager._internal();
  static const _key = 'customCacheKey';
  static final CustomCacheManager instance = CustomCacheManager._internal();

  CacheManager get cacheManager => _manager;

  final CacheManager _manager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 500,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );

  Future<List<({String url, BreedModel breedModel, bool isCachedSuccessfully})>> downloadImagesToCache({
    required List<(String, BreedModel)> listOfImageUrls,
  }) async {
    final cachedImages = <({String url, BreedModel breedModel, bool isCachedSuccessfully})>[];

    await Future.wait(
      listOfImageUrls.map((item) {
        return _downloadImageToCache(
          url: item.$1,
          breedModel: item.$2,
          onCached: cachedImages.add,
        );
      }).toList(),
    );

    return cachedImages;
  }

  Future<void> _downloadImageToCache({
    required String url,
    required BreedModel breedModel,
    required ValueChanged<({String url, BreedModel breedModel, bool isCachedSuccessfully})> onCached,
  }) async {
    final fileInfo = await _manager.getFileFromCache(url);
    var fileExists = false;

    /// if file exists then var fileExists is set to true , else false
    fileExists = await fileInfo?.file.exists() ?? false;

    /// if the file does not exists , then we download it in the cache
    if (!fileExists) {
      try {
        await _manager.downloadFile(url, key: url);

        /// if file is downloaded successfully then we add it to the list
        onCached((breedModel: breedModel, isCachedSuccessfully: true, url: url));
      } catch (e) {
        /// if file url is incorrect or corrupted then we move on to next url
        debugPrint('Error in downloading image $e');
        onCached((breedModel: breedModel, isCachedSuccessfully: false, url: url));
      }
    }
  }
}
