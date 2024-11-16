import 'package:flutter/material.dart';
import 'package:swifty_companion/models/intra_user_short.dart';
import 'package:swifty_companion/services/intra_auth.dart';
import 'package:swifty_companion/services/search_users.dart';

class IntraApiProvider with ChangeNotifier {
  String? _accessToken;
  int _tokenExpiration = 0;
  // List<IntraUserShort> _users = [];
  int? _selectedUserId;

  String? get accessToken => _accessToken;
  bool get isTokenExpired =>
      DateTime.now().millisecondsSinceEpoch > _tokenExpiration;
  // List<IntraUserShort> get users => _users;
  int? get selectedUserId => _selectedUserId;

  void setAccessToken(String? token) {
    _accessToken = token;
    notifyListeners();
  }

  void setTokenExpiration(int expiration) {
    _tokenExpiration = expiration;
    notifyListeners();
  }

  // void setUsers(List<IntraUserShort> users) {
  //   _users = users;
  //   notifyListeners();
  // }

  void setSelectedUser(int userId) {
    _selectedUserId = userId;
    notifyListeners();
  }

  Future<void> getAccessToken() async {
    final tokenData = await getIntraAccessToken();
    if (tokenData != null) {
      setAccessToken(tokenData['access_token'] as String);
      setTokenExpiration(DateTime.now().millisecondsSinceEpoch +
          (tokenData['expires_in'] as int) * 1000);
    }
  }

  Future<List<IntraUserShort>> searchUsers(String query) async {
    String? token = _accessToken;
    if (isTokenExpired || token == null) {
      await getAccessToken();
    }
    final users = await searchStudents(query, _accessToken ?? token!);
    return users;
  }
}
