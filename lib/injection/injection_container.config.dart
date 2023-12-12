// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/navigator/app_navigator.dart' as _i3;
import '../core/platform/network_info.dart' as _i12;
import '../core/services/cache_manager_service.dart' as _i4;
import '../core/services/mock_reader_service.dart' as _i11;
import '../data/repositories/dog_api_repository/data_sources/dog_api_http_repository.dart'
    as _i6;
import '../data/repositories/dog_api_repository/data_sources/dog_api_mock_repository.dart'
    as _i7;
import '../data/repositories/dog_api_repository/dog_api_repository.dart' as _i9;
import '../domain/repositories/dog_api_repository/data_sources/ilocal_repository.dart'
    as _i10;
import '../domain/repositories/dog_api_repository/data_sources/iremote_repository.dart'
    as _i5;
import '../domain/repositories/dog_api_repository/dog_api_repository.dart'
    as _i8;

const String _real = 'real';
const String _mock = 'mock';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.CustomCacheManager>(() => _i4.CustomCacheManager());
  gh.lazySingleton<_i5.IDogApiRemoteRepository>(
    () => _i6.DogApiHttpRepository(),
    registerFor: {_real},
  );
  gh.lazySingleton<_i5.IDogApiRemoteRepository>(
    () => _i7.DogApiMockRepository(),
    registerFor: {_mock},
  );
  gh.lazySingleton<_i8.IDogApiRepository>(() => _i9.DogApiRepository(
        remoteDataSource: gh<_i5.IDogApiRemoteRepository>(),
        localDataSource: gh<_i10.IDogApiLocalRepository>(),
      ));
  gh.lazySingleton<_i11.MockReaderService>(() => _i11.MockReaderService());
  gh.lazySingleton<_i12.NetworkInfo>(() => _i12.NetworkInfoImpl());
  return getIt;
}
