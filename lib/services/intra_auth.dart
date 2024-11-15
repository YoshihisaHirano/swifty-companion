import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

Future<String?> getAccessToken() async {
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
    print(result);
    final token = Uri.parse(result).queryParameters['code'];
    return token;
  } catch (e) {
    print(e);
  }
  return null;
}
