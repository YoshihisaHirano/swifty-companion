import 'package:swifty_companion/models/intra_user_short.dart';
import 'package:swifty_companion/util/intra_requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

Future<List<IntraUserShort>> searchStudents(String query, String token) async {
  final uri = createUri("users", {
    "search[login]": query,
    "filter[kind]": "student",
  });

  try {
    final response = await http.get(uri, headers: {
      "Authorization": createAuthHeader(token),
    });
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      return users.map((user) => IntraUserShort.fromJson(user)).toList();
    }
  } catch (e) {
    print(e);
  }
  return [];
}
