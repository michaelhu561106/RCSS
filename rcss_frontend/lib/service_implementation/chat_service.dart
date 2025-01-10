import "dart:convert";

import "package:http/http.dart" as http;

class ChatService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future getRecentTalkHistory(
      String uuid, String businessId, String businessServiceName) async {
    final uri = Uri.parse(
        "http://10.10.10.207:3000/api/businessServiceTalks/${uuid}/${businessId}/${businessServiceName}");
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future setUnreadMessagesCountToZero(
      String uuid, String businessId, String businessServiceName) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessServiceTalksRecetCount/${uuid}/${businessId}/${businessServiceName}');
    final response = await http.post(
      uri,
      headers: headers,
    );

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      print('[setUnreadMessagesCountToZero] -- Sucess');
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }
}
