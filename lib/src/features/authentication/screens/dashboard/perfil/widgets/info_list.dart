import 'package:flutter/material.dart';

class ProfileInfoList extends StatelessWidget {
  final String email;
  final String name;
  final String lastname;

  const ProfileInfoList({
    super.key,
    required this.email,
    required this.name,
    required this.lastname,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileInfoListItem(Icons.email, email),
        _buildProfileInfoListItem(Icons.person, name),
        _buildProfileInfoListItem(Icons.person, lastname),
      ],
    );
  }

  Widget _buildProfileInfoListItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5), // Color del borde
            width: 1.0, // Ancho del borde
          ),
          borderRadius: BorderRadius.circular(8.0), // Radio de borde
        ),
        child: ProfileInfoListItem(
          icon: icon,
          text: text,
        ),
      ),
    );
  }
}

class ProfileInfoListItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileInfoListItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
