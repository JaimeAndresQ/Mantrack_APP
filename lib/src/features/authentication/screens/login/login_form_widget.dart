import 'dart:async';

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

  // Inicializamos una variable para controlar la visibilidad de la contraseña
  bool visiIcon = false;

  // Inicializamos variables para el control de errores
  String emailError = '';
  String contraseniaError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  late StreamSubscription<Map<String, String>> _errorSubscription;

  @override
  void initState() {
    super.initState();
    _errorSubscription = authController.errorStream.listen((errors) {
      setState(() {
        emailError = errors['email'] ?? '';
        contraseniaError = errors['contrasenia'] ?? '';
      });
    });
  }

  @override
  void dispose() {
    _errorSubscription.cancel();
    super.dispose();
  }

  visibilityIcon() {
    setState(() {
      visiIcon = !visiIcon;
    });
  }

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
                errorText: emailError.isNotEmpty ? emailError : null,
                errorStyle: errorStyle,
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            obscureText: visiIcon ? false : true,
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.passwordController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: "Contraseña",
                hintText: "Contraseña",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                errorStyle: errorStyle,
                errorText:
                    contraseniaError.isNotEmpty ? contraseniaError : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      visibilityIcon();
                    },
                    icon: visiIcon
                        ? const Icon(
                            Icons.remove_red_eye_sharp,
                          )
                        : const Icon(Icons.visibility_off))),
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
                  try {
                    // Limpiar mensajes de error antes de la validación
                    setState(() {
                      emailError = '';
                      contraseniaError = '';
                    });

                    if (authController.emailController.text.isEmpty) {
                      setState(() {
                        emailError = 'Ingrese un correo electronico';
                      });
                    }

                    if (authController.passwordController.text.isEmpty) {
                      setState(() {
                        contraseniaError = 'Ingrese una contraseña';
                      });
                    }

                    // Verificar si hay errores antes de llamar a la función de registro
                    if (emailError.isEmpty && contraseniaError.isEmpty) {
                      // Llamar a la función de registro en el AuthController
                      String result = await authController.loginU();
                      if (result != "error") {
                        widget.prefs.setString('token', result);
                        Get.to(() => DashboardScreen(
                              token: result,
                            ));
                      }
                    }
                  } catch (e) {
                    print("Error al registrar usuario: $e");
                    // Manejar otros posibles errores aquí
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
