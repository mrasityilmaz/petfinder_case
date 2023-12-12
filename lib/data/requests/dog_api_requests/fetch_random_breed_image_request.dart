import 'package:petfinder/core/constants/api_constants.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';

final class FetchRandomBreedImageByBreedRequest extends IRestApiRequest {
  FetchRandomBreedImageByBreedRequest({required this.breed, this.subBreed}) {
    endPoint = APIConstants.instance.breedRandomImagePath(breed: breed, subBreed: subBreed);
    requestMethod = RequestMethod.GET;
  }

  final String breed;
  final String? subBreed;
}
