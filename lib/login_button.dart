import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/intra_api_provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IntraApiProvider>(context, listen: false);
    final token = provider.accessToken;
    final isTokenExpired = provider.isTokenExpired;

    void handleLogin() async {
      if (token != null && !isTokenExpired) {
        Navigator.of(context).pushNamed('/search');
        return;
      }
      await provider.getAccessToken();
      if (!context.mounted) return;
      Navigator.of(context).pushNamed('/search');
    }

    return Column(children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
        ),
        onPressed: handleLogin,
        child: const Text(
          'Login with 42',
          style: TextStyle(fontSize: 28),
        ),
      ),
      // if (token != null) Text('Token: $token'),
      // Text('Token expired: $isTokenExpired'),
    ]);
  }
}
