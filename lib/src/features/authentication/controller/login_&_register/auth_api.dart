// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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

  Future<void> registerU() async {
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

        var response = await http.post(Uri.parse(registrationUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse);

        if (response.statusCode == 200) {
          print("Usuario registrado");
        } else {
          throw Exception(
              "Error al registrar usuario: ${jsonResponse['message']}");
        }
      } else {
        throw Exception("El correo y la contraseña son obligatorios");
      }
    } catch (e) {
      print("Error al registrar usuario: $e");
    }
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
