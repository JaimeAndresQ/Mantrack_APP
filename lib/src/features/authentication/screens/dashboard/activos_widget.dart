import 'package:flutter/material.dart';

class ActivosHome extends StatelessWidget {
  const ActivosHome({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(10),
      height: size.height * 0.95,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
    );
    
  }
}