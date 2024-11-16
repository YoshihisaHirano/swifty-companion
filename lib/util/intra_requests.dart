const host = 'api.intra.42.fr';

String createAuthHeader(String token) {
  return "Bearer $token";
}

Uri createUri(String path, Map<String, String> queryParameters) {
  return Uri.https(host, "/v2/$path", queryParameters);
}
