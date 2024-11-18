import 'package:swifty_companion/models/intra_user_full.dart';
import 'package:swifty_companion/util/intra_requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

Future<IntraUserFull?> getIntraUser(int userId, String token) async {
  final uri = createUri("users/$userId", {});

  try {
    final response = await http.get(uri, headers: {
      "Authorization": createAuthHeader(token),
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      return IntraUserFull.fromJson(user);
    }
  } catch (e) {
    print(e);
  }
  return null;
}
