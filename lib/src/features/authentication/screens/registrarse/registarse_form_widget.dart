import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/login_&_register/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../dashboard/dashboard_screen.dart';

// ignore: must_be_immutable
class RegistrarseForm extends StatelessWidget {
  final SharedPreferences prefs;
  RegistrarseForm({
    super.key,
    required this.prefs,
  });

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    print("build registeRFORM");
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.nombreController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: "Nombre",
                hintText: "Nombre",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.apellidoController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: "Apellidos",
                hintText: "Apellidos",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
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
            controller: authController.cellphoneController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.numbers),
                labelText: "No Telefono",
                hintText: "No Telefono",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder()),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.cedulaciudadanaController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.badge_outlined),
              labelText: "Cedula de Ciudadania",
              hintText: "Cedula de Ciudadania",
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: authController.fechanacimientoController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_month_outlined),
              labelText: "Fecha de Nacimiento",
              hintText: "Fecha de Nacimiento",
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              border: const OutlineInputBorder(),
            ),
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
            ),
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  authController.registerU();
                  Get.to(() => const LoginScreen(
                          
                        ));

                
                
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: tPrimaryColor,
                    side: const BorderSide(color: tPrimaryColor),
                    padding:
                        const EdgeInsets.symmetric(vertical: tButtonHeight)),
                child: const Text("REGISTRARSE")),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                child: const Text.rich(TextSpan(
                    text: "Ya tienes una cuenta?",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: " Inicia Sesion",
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
