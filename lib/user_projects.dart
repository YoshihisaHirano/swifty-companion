import 'package:flutter/material.dart';
import 'package:swifty_companion/models/intra_user_full.dart';

class UserProjects extends StatelessWidget {
  final List<Project> projects;

  const UserProjects({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 6.0, childAspectRatio: 4 / 3),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: project.validated ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  project.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(
                  project.validated ? Icons.check_circle : Icons.cancel,
                  color: project.validated ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(
                  'Grade: ${project.grade}',
                  style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
                  textAlign: TextAlign.center,
                ),
                ],
              ),
              ],
            ),
          );
        },
      ),
    );
  }
}
