import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class RegistrarseForm extends StatefulWidget {
  final SharedPreferences prefs;
  const RegistrarseForm({
    super.key,
    required this.prefs,
  });

  @override
  State<RegistrarseForm> createState() => _RegistrarseFormState();
}

class _RegistrarseFormState extends State<RegistrarseForm> {
  AuthController authController = AuthController();

  String nombreError = '';
  String apellidoError = '';
  String emailError = '';
  String telefonoError = '';
  String cedulaError = '';
  String fechaNacimientoError = '';
  String contraseniaError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  late StreamSubscription<Map<String, String>> _errorSubscription;

  @override
  void initState() {
    super.initState();
    _errorSubscription = authController.errorStream.listen((errors) {
      setState(() {
        nombreError = errors['nombre'] ?? '';
        apellidoError = errors['apellido'] ?? '';
        emailError = errors['email'] ?? '';
        telefonoError = errors['telefono'] ?? '';
        cedulaError = errors['cedula'] ?? '';
        fechaNacimientoError = errors['fechaNacimiento'] ?? '';
        contraseniaError = errors['contrasenia'] ?? '';
      });
    });
  }

  @override
  void dispose() {
    _errorSubscription.cancel();
    super.dispose();
  }

  void validateAndSetErrors() {
    setState(() {
      nombreError = authController.nombreController.text.isEmpty ? 'Ingrese un nombre' : '';
      apellidoError = authController.apellidoController.text.isEmpty ? 'Ingrese un apellido' : '';
      emailError = authController.emailController.text.isEmpty ? 'Ingrese un correo electrónico' : '';
      telefonoError = authController.cellphoneController.text.isEmpty ? 'Ingrese un número de teléfono válido' : '';
      cedulaError = authController.cedulaciudadanaController.text.isEmpty ? 'Ingrese un número de identificación' : '';
      fechaNacimientoError = authController.fechanacimientoController.text.isEmpty ? 'Ingrese una fecha de nacimiento' : '';
      contraseniaError = authController.passwordController.text.isEmpty ? 'Ingrese una contraseña' : '';
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                errorText: nombreError.isNotEmpty ? nombreError : null,
                errorStyle: errorStyle,
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
                errorText: apellidoError.isNotEmpty ? apellidoError : null,
                errorStyle: errorStyle,
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
                errorText: emailError.isNotEmpty ? emailError : null,
                errorStyle: errorStyle,
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
                errorText: telefonoError.isNotEmpty ? telefonoError : null,
                errorStyle: errorStyle,
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
              errorText: cedulaError.isNotEmpty ? cedulaError : null,
              errorStyle: errorStyle,
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
              prefixIcon: const Icon(Icons.calendar_today),
              labelText: "Fecha de Nacimiento",
              hintText: "Fecha de Nacimiento",
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              errorText:
                  fechaNacimientoError.isNotEmpty ? fechaNacimientoError : null,
              errorStyle: errorStyle,
              border: const OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  authController.fechanacimientoController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
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
              errorText: contraseniaError.isNotEmpty ? contraseniaError : null,
              errorStyle: errorStyle,
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
                  try {
                    
                    // Validamos los campos de error
                    validateAndSetErrors();

                    // Agregar más validaciones para los demás campos según sea necesario

                    // Verificar si hay errores antes de llamar a la función de registro
                    if (nombreError.isEmpty &&
                        apellidoError.isEmpty &&
                        emailError.isEmpty &&
                        telefonoError.isEmpty &&
                        cedulaError.isEmpty &&
                        fechaNacimientoError.isEmpty &&
                        contraseniaError.isEmpty) {
                      // Llamar a la función de registro en el AuthController
                      int? statusCode = await authController.registerU();

                      if (statusCode == 201) {
                          showDialog<String>(
                          
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                      top: size.height / -13.2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        color: tPrimaryColor,
                                        ),
                                        width: 332,
                                        height: 70,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 25),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: tDefaultSize,
                                        ),
                                        const Text(
                                          '¡Perfecto!',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: tDefaultSize - 5,
                                        ),
                                        const SizedBox(
                                            width: 290,
                                            child: Text(
                                              'Se creo tu usuario de forma exitosa, ya puedes iniciar sesion en Mantrack.',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87),
                                              textAlign: TextAlign.center,
                                            )),
                                        const SizedBox(height: tDefaultSize - 5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(() => const LoginScreen());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor: tPrimaryColor,
                                                  side: const BorderSide(
                                                      color: tPrimaryColor),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: tButtonHeight)),
                                              child: const Text(
                                                "OK",
                                                style: TextStyle(fontSize: 16),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height / -19.4,
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: tPrimaryColor,
                                        border: Border.all(color: Colors.white)
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.check_rounded,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
