import 'package:flutter/material.dart';

class ProfileInfoList extends StatelessWidget {
  final String email;
  final String name;
  final String lastname;

  const ProfileInfoList({
    Key? key,
    required this.email,
    required this.name,
    required this.lastname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileInfoListItem(
          icon: Icons.email,
          text: email,
        ),
        ProfileInfoListItem(
          icon: Icons.person,
          text: name,
        ),
        ProfileInfoListItem(
          icon: Icons.person,
          text: lastname,
        ),
      ],
    );
  }
}

class ProfileInfoListItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileInfoListItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
