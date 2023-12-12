import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

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

  Future<List<({String url, bool isCachedSuccessfully})>> downloadImagesToCache({
    required List<String> listOfImageUrls,
  }) async {
    final cachedImages = <({String url, bool isCachedSuccessfully})>[];
    await Future.forEach(listOfImageUrls, (item) async {
      final fileInfo = await _manager.getFileFromCache(item);
      var fileExists = false;

      /// if file exists then var fileExists is set to true , else false
      fileExists = await fileInfo?.file.exists() ?? false;

      /// if the file does not exists , then we download it in the cache
      if (!fileExists) {
        try {
          await _manager.downloadFile(item, key: item);

          /// if file is downloaded successfully then we add it to the list
          cachedImages.add((isCachedSuccessfully: true, url: item));
        } catch (e) {
          /// if file url is incorrect or corrupted then we move on to next url
          debugPrint('Error in downloading image $e');
          cachedImages.add((isCachedSuccessfully: false, url: item));
        }
      }
    }).timeout(const Duration(seconds: 5));

    return cachedImages;
  }
}
