import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          'Cerrar sesión',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
