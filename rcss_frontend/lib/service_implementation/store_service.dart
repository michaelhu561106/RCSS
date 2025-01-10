import "dart:convert";

import "package:http/http.dart" as http;

class StoreService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future fetchBusinesses() async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/businesses');
    final response = await http.get(uri);

    List<dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      Map<String, dynamic> responseBody = json.decode(response.body);
    }
  }

  Future getBusinessListByUuid(String uuid) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessListAndIsNotReadCount/${uuid}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future getBusinessServicesListByUuid(String uuid) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessServiceListAndIsNotReadCount/${uuid}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future getBusinessServicesListByUuidAndBusinessId(
      String uuid, String businessId) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessServiceListAndIsNotReadCount/${uuid}/${businessId}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }
}
