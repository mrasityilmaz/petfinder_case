import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:petfinder/core/extensions/string_extensions.dart';
import 'package:petfinder/presentation/views/home_view/home_view.dart';

part 'app_navigator.gr.dart';

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeViewRoute.page,
          path: HomeViewRoute.name.toRouterPath,
          initial: true,
        ),
      ];
}
