import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  late String email;
  late String name;
  late String lastname;
  late dynamic tokenw;

  String getTokenInfo(String? token, String infoToken) {
    if (token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
      tokenw = jwtDecodedToken;
      email = jwtDecodedToken['correo'];
      name = jwtDecodedToken['nombres'];
      lastname = jwtDecodedToken['apellidos'];
      switch (infoToken) {
        case "email":
          return email;
        case "name":
          return name;
        case "lastname":
          return lastname;
        default:
          return tokenw;
      }
    } else {
      throw Exception("No hay token");
    }
  }

  Future<String?> verificarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      Get.to(() => const WelcomeScreen());
      throw Exception("El token ha expirado!");
      
    } else if (tokenActual != null) {
      // ignore: avoid_print
      print(tokenActual);
      return tokenActual;

    } else {
      Get.to(() => const WelcomeScreen());
      throw Exception("No hay token");
    }
  }

  Future<void> eliminarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');

    // Verificar si el token está presente
    if (tokenActual != null) {
      // Borrar el token
      await prefs.remove('token');
      Get.to(() => const WelcomeScreen());
      throw Exception("Token eliminado");
    }
  }
}
