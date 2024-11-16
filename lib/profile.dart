import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/intra_api_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    selectedUserId = Provider.of<IntraApiProvider>(context, listen: false).selectedUserId;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedUserId == null) {
      Navigator.of(context).pop();
    }
    return Scaffold(
      body: Text('User profile: $selectedUserId'),
    );
  }
}
