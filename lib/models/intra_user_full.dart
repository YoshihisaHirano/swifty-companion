import 'package:swifty_companion/models/intra_user_short.dart';

class IntraUserFull extends IntraUserShort {
  final String email;

  IntraUserFull({
    required super.id,
    required super.login,
    required String super.imageUrl,
    required this.email,
    required super.displayName,
  });
}
