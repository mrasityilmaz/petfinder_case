// ignore_for_file: use_build_context_synchronously

part of '../home_view.dart';

mixin HomeViewMixin on State<HomeView> {
  late List<({BreedModel breedModel, String url})> _breedList;
  @override
  void initState() {
    _breedList = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchImageAndCloseSplash();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchImageAndCloseSplash() async {
    try {
      await _fetchDogImagesForEach().then((value) {
        FlutterNativeSplash.remove();
      });
    } catch (e) {
      FlutterNativeSplash.remove();
    }
  }

  ///
  /// Fetch random image for each breed and add them into cache
  ///
  Future<void> _fetchDogImagesForEach() async {
    try {
      final stopwatch = Stopwatch()..start();
      final dogApiRepository = locator<IDogApiRepository>();

      ///
      ///  Fetch all breeds from the api
      ///
      final breedList = await dogApiRepository.fetchAllBreeds();

      ///
      /// If the result is right, then fetch random image for each breed
      ///
      if (breedList.isRight()) {
        ///
        /// Create a list of futures to fetch random image for each breed
        ///
        final futureList = await Future.wait(
          breedList.getOrElse(() => []).map((element) {
            return dogApiRepository.fetchRandomImageBySubBreed(breed: element.breedName).then((value) {
              if (value.isRight()) {
                return (value.asRight(), element);
              }
              return null;
            });
          }).toList(),
        );

        ///
        /// Wait for all futures to complete and get the result
        ///
        final imageUrls = futureList.whereType<(String, BreedModel)>().toList();

        ///
        /// Add the list of images into cache
        ///

        await Future.wait(
          imageUrls.map((e) {
            try {
              return precacheImage(
                CachedNetworkImageProvider(e.$1, cacheKey: e.$1, cacheManager: locator<CustomCacheManager>().cacheManager),
                context,
                onError: (err, s) {
                  _breedList.removeWhere((element) => element.url == e.$1 && element.breedModel == e.$2);
                },
              );
            } catch (e) {
              return Future<void>.value();
            } finally {
              _breedList.add((breedModel: e.$2, url: e.$1));
            }
          }).toList(),
        );
      }

      stopwatch.stop();
      debugPrint('Fetch dog images for each breed took ${stopwatch.elapsed}');
      debugPrint('Total images fetched successfully: ${_breedList.length}/${breedList.getOrElse(() => []).length}');
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
