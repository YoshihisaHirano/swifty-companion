class IntraUserShort {
  final int id;
  final String login;
  final String displayName;
  final String? imageUrl;

  IntraUserShort({
    required this.id,
    required this.login,
    required this.displayName,
    this.imageUrl,
  });

  factory IntraUserShort.fromJson(Map<String, dynamic> json) {
    return IntraUserShort(
      id: json['id'],
      login: json['login'],
      displayName: json['displayname'],
      imageUrl: json['image'] != null ? UserImage.fromJson(json['image']).link : null,
    );
  }
}

class UserImage {
  final String? link;

  UserImage({this.link});

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      link: json['link'],
    );
  }
}

