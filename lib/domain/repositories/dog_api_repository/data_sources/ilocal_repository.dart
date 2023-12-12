import 'package:petfinder/core/extensions/dartz_extension.dart';

abstract class IDogApiLocalRepository {
  ///
  ///  Local repository interface
  ///  This is where you define your local data source methods
  ///  For example:
  ///  Future<Either<Failure, DataModel<Data>>> getDataFromLocal();
  ///

  Future<DataModel<List<({String url, bool isCachedSuccessfully})>>> addListOfImagesIntoCache({required List<String> images});
}
