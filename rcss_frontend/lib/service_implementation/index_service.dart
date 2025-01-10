import "dart:convert";

import "package:http/http.dart" as http;

class IndexService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future createIndexPageShortcut(
      String userUuid,
      int shortcutTypeId,
      String shortcutTitle,
      Map<String, dynamic> shortcutUrl,
      String createdDate) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/user_shortcut/create');

    final Map<String, dynamic> requestBody = {
      'user_uuid': userUuid,
      'shortcut_type_id': shortcutTypeId,
      'shortcut_title': shortcutTitle,
      'shortcut_url': shortcutUrl,
      'created_date': createdDate,
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

  Future getBottomMenuTypeAndCount(String uuid) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/user_shortcut/${uuid}');

    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody['dataMenu'];
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future getShortcutList(String uuid) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/user_shortcut/${uuid}');

    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody['dataShortcut'];
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future deleteShortcut(
      String uuid, int shortcutTypeId, String shortcutTitle) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/user_shortcut/delete');

    final requestBody = {
      'user_uuid': uuid,
      'shortcut_type_id': shortcutTypeId,
      'shortcut_title': shortcutTitle,
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
