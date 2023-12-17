import 'package:petfinder/core/constants/api_constants.dart';
import 'package:petfinder/vendor/rest_api_pkg/requests/rest_api_request.dart';

final class FetchAllBreedRequest extends IRestApiRequest {
  FetchAllBreedRequest() {
    endPoint = APIConstants.instance.allBreedPath;
    requestMethod = RequestMethod.GET;
  }
}
