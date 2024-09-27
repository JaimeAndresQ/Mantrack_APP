import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  late String email;
  late String name;
  late String lastname;
  late dynamic tokenw;


  Future<String?> verificarTokenU({bool? rol}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    String? rolActual = prefs.getString('rol');
    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      await prefs.remove('rol');
      Get.to(() => const WelcomeScreen());
      throw Exception("El token ha expirado!");
    } else if (tokenActual != null) {
      // ignore: avoid_print
      print(tokenActual);
      return rol == true ? rolActual : tokenActual;
    } else {
      Get.to(() => const WelcomeScreen());
      throw Exception("No hay token");
    }
  }

  // Para cuando se inicializa la app y verificar el estado
  Future<String?> getTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      await prefs.remove('rol');
      return tokenActual;
    } else {
      // ignore: avoid_print
      print(tokenActual);
      return tokenActual;
    }
  }

  Future<void> setTokenU(String result, String rol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result);
    prefs.setString('rol', rol);
  }



  Future<void> eliminarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');

    // Verificar si el token está presente
    if (tokenActual != null) {
      // Borrar el token
      await prefs.remove('token');
      await prefs.remove('rol');
      Get.to(() => const WelcomeScreen());
      throw Exception("Token eliminado");
    }
  }
}
