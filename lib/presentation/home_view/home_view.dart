import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:petfinder/core/extensions/dartz_extension.dart';
import 'package:petfinder/core/navigator/app_routes.dart';
import 'package:petfinder/core/services/cache_manager_service.dart';
import 'package:petfinder/data/models/breed_model/breed_model.dart';
import 'package:petfinder/domain/repositories/dog_api_repository/dog_api_repository.dart';
import 'package:petfinder/injection/injection_container.dart';

part 'mixin/home_view_mixin.dart';

@RoutePage(name: AppRoutes.homeViewRoute)
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _breedList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        cacheKey: _breedList[index].url,
                        imageUrl: _breedList[index].url,
                        fit: BoxFit.cover,
                        cacheManager: locator<CustomCacheManager>().cacheManager,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        placeholderFadeInDuration: Duration.zero,
                      ),
                    ),
                    Text(_breedList[index].breedModel.breedName),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
