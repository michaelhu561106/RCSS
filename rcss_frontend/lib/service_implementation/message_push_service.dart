import "dart:convert";

import "package:http/http.dart" as http;

class MessagePushService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future getBusinessMessagePushIsNotRead(String uuid) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessmessagepushisnotread/${uuid}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }
  Future setUserReadMessagePush(
      String uuid,
      int business_id,
      int business_message_push_id) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/setuserreadmessagepush');
    final Map<String, String> requestBody = {
      'uuid': uuid,
      'business_id': business_id.toString(),
      'business_message_push_id': business_message_push_id.toString()
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }
}
