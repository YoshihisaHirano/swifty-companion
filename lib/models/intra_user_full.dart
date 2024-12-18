import 'package:swifty_companion/models/intra_user_short.dart';

const maxSkillLevel = 20;

class IntraUserFull extends IntraUserShort {
  final String email;
  final String? phone;
  final int wallet;
  final String location;
  final String level;
  final bool isActive;
  final List<Skill> skills;
  final List<Project> projects;

  IntraUserFull({
    required super.id,
    required super.login,
    required super.imageUrl,
    required this.email,
    required super.displayName,
    this.phone,
    required this.wallet,
    required this.location,
    required this.level,
    this.isActive = false,
    this.skills = const [],
    this.projects = const [],
  });

  factory IntraUserFull.fromJson(Map<String, dynamic> json) {
    final campuses = json['campus'] as List<dynamic>;
    final activeCampus = campuses.firstWhere(
      (campus) => campus['active'] == true,
      orElse: () => campuses.first,
    );
    final country = activeCampus['country'];
    final name = activeCampus['name'];
    final location = json['location'];
    final fullLocation = '$country, $name, seat: ${location ?? 'Unavailable'}';

    final cursusUsers = json['cursus_users'] as List<dynamic>;
    final mainCursus = cursusUsers.firstWhere(
        (cursus) => cursus['cursus']['kind'] == 'main',
        orElse: () => null);
    final level =
        mainCursus != null ? mainCursus['level'] as double : "Unavailable";

    List<Skill> skills = mainCursus != null
        ? (mainCursus['skills'] as List<dynamic>)
            .map((skill) => Skill.fromJson(skill))
            .toList()
        : [];

        List<dynamic> projectList = (json['projects_users'] as List<dynamic>)
        .where((project) => project['status'] == 'finished')
        .toList();

    // Sort projects by updatedAt from most recent to oldest
    projectList.sort((a, b) => DateTime.parse(b['updated_at']).compareTo(DateTime.parse(a['updated_at'])));

    List<Project> projects = projectList.map((project) => Project.fromJson(project)).toList();

    return IntraUserFull(
      id: json['id'],
      login: json['login'],
      imageUrl:
          json['image'] != null ? UserImage.fromJson(json['image']).link : null,
      email: json['email'],
      displayName: json['displayname'],
      phone: json['phone'],
      wallet: json['wallet'],
      location: fullLocation,
      level: level.toString(),
      isActive: json['active?'],
      skills: skills,
      projects: projects,
    );
  }
}

class Skill {
  final String name;
  final String level;
  final int percentage;

  Skill({
    required this.name,
    required this.level,
    required this.percentage,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    final level = json['level'] as double;
    final percentage = (level / maxSkillLevel * 100).round();
    return Skill(
      name: json['name'],
      level: level.toStringAsFixed(2),
      percentage: percentage,
    );
  }
}

class Project {
  final String name;
  final int? grade;
  final bool validated;

  Project({required this.name, this.grade, required this.validated});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['project']['name'],
      grade: json['final_mark'] ?? 0,
      validated: json['validated?'] ?? false,
    );
  }
}
