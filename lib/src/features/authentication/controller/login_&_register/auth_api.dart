// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_config.dart';

class AuthController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechanacimientoController =
      TextEditingController();
  final TextEditingController cedulaciudadanaController =
      TextEditingController();

  String nombreError = '';
  String apellidoError = '';
  String emailError = '';
  String telefonoError = '';
  String cedulaError = '';
  String fechaNacimientoError = '';
  String contraseniaError = '';

  void handleRegistrationError(int statusCode, String errorMsg) {
    switch (statusCode) {
      case 400:
        updateErrorMessages(
          contraseniaError: errorMsg,
        );
        break;
      case 409:
        // Código para manejar el error 409 (correo o número de identificación ya en uso)
        RegExp regex =
            RegExp(r"correo ([^ ]+) o número de identificación (\d+)");
        Match? match = regex.firstMatch(errorMsg);
        if (match != null && match.groupCount == 2) {
          String emailPart = match.group(1) ?? '';
          String cedulaPart = match.group(2) ?? '';
          updateErrorMessages(
              emailError: "Ya existe un usuario con el correo $emailPart",
              cedulaError: "Ya existe un número de identificación $cedulaPart");
        }
        break;
      case 404:
        // Código para manejar el error 409 (correo o número de identificación ya en uso)
        updateErrorMessages(
          emailError: errorMsg,
        );

        break;
      default:
        // Otros códigos de error
        break;
    }
  }

  final _errorController = StreamController<Map<String, String>>.broadcast();
  Stream<Map<String, String>> get errorStream => _errorController.stream;

  void updateErrorMessages({
    String? emailError,
    String? cedulaError,
    String? nombreError,
    String? apellidoError,
    String? telefonoError,
    String? fechaNacimientoError,
    String? contraseniaError,
  }) {
    Map<String, String> errors = {
      'email': emailError ?? '',
      'cedula': cedulaError ?? '',
      'nombre': nombreError ?? '',
      'apellido': apellidoError ?? '',
      'telefono': telefonoError ?? '',
      'fechaNacimiento': fechaNacimientoError ?? '',
      'contrasenia': contraseniaError ?? '',
    };
    _errorController.add(errors);
  }

  void dispose() {
    _errorController.close();
  }

  Future<int?> registerU() async {
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Map<String, String> regBody = {
          "id_correo": emailController.text,
          "contrasenia": passwordController.text,
          "id_persona": cedulaciudadanaController.text,
          "nombres": nombreController.text,
          "apellidos": apellidoController.text,
          "telefono": cellphoneController.text,
          "fecha_nacimiento": fechanacimientoController.text,
        };
        var response = await http.post(
          Uri.parse(registrationUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        var jsonResponse = jsonDecode(response.body);

        print(
            "este es el response $jsonResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 201) {
          print("Usuario registrado");
          // Get.to(() => const LoginScreen());
          return 201;
        } else if (response.statusCode == 400) {
          throw Exception("Falta llenar más campos.");
        } else if (response.statusCode == 409) {
          handleRegistrationError(response.statusCode, jsonResponse['msg']);
        } else {
          throw Exception("Error desconocido al registrar usuario.");
        }
      } else {
        throw Exception("El correo y la contraseña son obligatorios");
      }
    } catch (e) {
      print("Error al registrar usuario: $e");
    }
    return null;
  }

  Future<String> loginU() async {
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Map<String, String> regBody = {
          "id_correo": emailController.text,
          "contrasenia": passwordController.text,
        };

        var responseLogin = await http.post(Uri.parse(loginUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var jsonResponseLog = jsonDecode(responseLogin.body);

        print("Token: ${jsonResponseLog['token']}");
        print("Respuesta Login: ${responseLogin.statusCode}");

        if (responseLogin.statusCode == 200) {
          String myToken = jsonResponseLog['token'];
          return myToken;
        } else if (responseLogin.statusCode == 404) {
          handleRegistrationError(
              responseLogin.statusCode, jsonResponseLog['msg']);
          throw Exception("Error 404");
        } else if (responseLogin.statusCode == 400) {
          handleRegistrationError(
              responseLogin.statusCode, jsonResponseLog['msg']);
          throw Exception("Error 400");
        } else {
          throw Exception("Error en la solicitud: ${responseLogin.statusCode}");
        }
      } else {
        throw Exception("El correo y la contraseña son obligatorios");
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      return "error";
    }
  }

  Future verificarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    print(prefs.getString('token'));

    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      print('Token expirado. Se ha eliminado.');
      return "NoToken";
    } else {
      return "Token";
    }
  }

  Future eliminarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    print(prefs.getString('token'));

    // Verificar si el token está presente
    if (tokenActual != null) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      print('Token expirado. Se ha eliminado.');
      return "NoToken";
    } else {
      return "Token";
    }
  }
}
