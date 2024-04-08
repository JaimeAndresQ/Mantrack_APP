import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/screens/registrarse/registarse_form_widget.dart';



class RegistrarseScreen extends StatelessWidget {
  const RegistrarseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                SvgPicture.asset(
                  tRegistrarImage1,
                  height: size.height * 0.2,
                ),
                const SizedBox(height: tFormHeight),

                Text(
                  "Registrarse",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Crea un nuevo usuario para Mantrack",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RegistrarseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


