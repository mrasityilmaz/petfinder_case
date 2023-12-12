import 'package:petfinder/core/constants/api_constants.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';

final class FetchAllBreedRequest extends IRestApiRequest {
  FetchAllBreedRequest() {
    endPoint = APIConstants.instance.allBreedPath;
    requestMethod = RequestMethod.GET;
  }
}
