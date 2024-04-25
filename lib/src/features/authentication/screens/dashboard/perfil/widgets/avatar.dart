import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;

  const CircularAvatar({super.key, required this.size, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: size / 2,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? Icon(Icons.person, size: size * 0.8) : null,
      ),
    );
  }
}
