import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/login_&_register/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:mantrack_app/src/features/authentication/screens/registrarse/registrarse_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  final SharedPreferences prefs;

  LoginForm({
    super.key,
    required this.prefs,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //  Inicializa una instancia de AuthController para gestionar la autenticación JWT y la clase en general.
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: "Email",
                hintText: "Email",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.passwordController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: "Contraseña",
                hintText: "Contraseña",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder(),
                suffixIcon: const IconButton(
                    onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: const Text("Olvidaste la contraseña?"))),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  String result = await authController.loginU();

                  if (result != "error") {
                    widget.prefs.setString('token', result);
                    Get.to(() => DashboardScreen(
                          token: result,
                        ));
                  } else {
                    //Hacer las validaciones de borrar los formularios
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: tPrimaryColor,
                    side: const BorderSide(color: tPrimaryColor),
                    padding:
                        const EdgeInsets.symmetric(vertical: tButtonHeight)),
                child: const Text("INICIAR SESION")),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  Get.to(() => const RegistrarseScreen());
                },
                child: const Text.rich(TextSpan(
                    text: "No tienes una cuenta?",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: " Registrarse",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: tPrimaryColor),
                      )
                    ]))),
          )
        ],
      ),
    ));
  }
}
