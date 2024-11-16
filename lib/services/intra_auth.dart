import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

Future<Map<String, Object>?> getIntraAccessToken() async {
  final clientId = dotenv.env['INTRA_CLIENT_UID'];
  final clientSecret = dotenv.env['INTRA_CLIENT_SECRET'];

  if (clientId == null || clientSecret == null) {
    throw Exception('Please provide your client id and secret');
  }

  final url = Uri.https(
    'api.intra.42.fr',
    '/oauth/authorize',
    {
      'client_id': clientId,
      'client_secret': clientSecret,
      'response_type': 'code',
      'redirect_uri': 'swifty-companion://oauth/callback',
    },
  );

  try {
    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme: 'swifty-companion',
    );
    final code = Uri.parse(result).queryParameters['code'];
    final tokenUrl = Uri.https('api.intra.42.fr', '/oauth/token');
    final response = await http.post(
      tokenUrl,
      body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code!,
        'redirect_uri': 'swifty-companion://oauth/callback',
      },
    );
    final accessToken = jsonDecode(response.body)['access_token'] as String;
    final expiresIn = jsonDecode(response.body)['expires_in'] as int;
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
    };
  } catch (e) {
    print(e);
  }
  return null;
}
