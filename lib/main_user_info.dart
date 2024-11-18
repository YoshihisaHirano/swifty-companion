import 'package:flutter/material.dart';

class MainUserInfo extends StatelessWidget {
  final String? imageUrl;
  final String displayName;
  final String login;
  final String? phone;
  final String email;
  final String location;
  final int wallet;
  final String level;
  final bool isActive;

  const MainUserInfo({
    super.key,
    required this.imageUrl,
    required this.displayName,
    required this.login,
    this.phone,
    required this.email,
    required this.location,
    required this.wallet,
    required this.level,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            imageUrl != null
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 60,
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        login,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        softWrap: true,
                      ),
                      const SizedBox(width: 8),
                      if (!isActive)
                        const Tooltip(
                          message: 'User is not active',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Level',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    level,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 18, // Adjust the height as needed
              color: Colors.teal,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wallet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$wallet ₳",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (phone != null && phone != "hidden") ...[
          Row(
            children: [
              const Icon(
                Icons.phone,
                size: 16,
                color: Colors.teal,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  phone!,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        Row(
          children: [
            const Icon(Icons.email, size: 18, color: Colors.teal),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                email,
                style: const TextStyle(fontSize: 18),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.teal),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                location,
                style: const TextStyle(fontSize: 17),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
