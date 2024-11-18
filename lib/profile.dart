import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/main_user_info.dart';
import 'package:swifty_companion/providers/intra_api_provider.dart';

import 'models/intra_user_full.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  late Future<IntraUserFull?> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = _fetchUserProfile();
  }

  Future<IntraUserFull?> _fetchUserProfile() async {
    final selectedUserId =
        Provider.of<IntraApiProvider>(context, listen: false).selectedUserId;
    if (selectedUserId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return null;
    }
    return Provider.of<IntraApiProvider>(context, listen: false)
        .getUserProfile(selectedUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<IntraUserFull?>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    MainUserInfo(
                      imageUrl: user.imageUrl,
                      displayName: user.displayName,
                      login: user.login,
                      email: user.email,
                      location: user.location,
                      phone: user.phone,
                      wallet: user.wallet,
                      level: user.level,
                      isActive: user.isActive,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('User not found'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
