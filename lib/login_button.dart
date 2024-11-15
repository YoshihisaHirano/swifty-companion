import 'package:flutter/material.dart';
import 'package:swifty_companion/services/intra_auth.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  String? _token;

  void handleLogin() async {
    final token = await getAccessToken();
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
        ),
        onPressed: _token == null ? handleLogin : null,
        child: const Text('Login with 42', style: TextStyle(fontSize: 28),),
      ),
      if (_token != null) Text('Token: $_token'),
    ]);
  }
}
