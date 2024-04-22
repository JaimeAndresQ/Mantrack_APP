// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'auth_config.dart';

class AuthController {
  // Controladores de texto de Inicio de Sesion y Registro
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechanacimientoController =
      TextEditingController();
  final TextEditingController cedulaciudadanaController =
      TextEditingController();

  // Controladores de Activos
  final TextEditingController idvehicuController = TextEditingController();
  final TextEditingController marcaVehiController = TextEditingController();
  final TextEditingController modeloVehiController = TextEditingController();
  final TextEditingController lineaVehiController = TextEditingController();
  final TextEditingController colorVehiController = TextEditingController();
  final TextEditingController capacidadVehiController = TextEditingController();
  final TextEditingController claseVehiController = TextEditingController();
  final TextEditingController cilindrajeVehiController =
      TextEditingController();
  final TextEditingController tipoCombustibleVehiemailController =
      TextEditingController();
  final TextEditingController numeroMotorController = TextEditingController();
  final TextEditingController numeroChasisController = TextEditingController();
  final TextEditingController vinVehiController = TextEditingController();
  final TextEditingController ciudadRegristroVehiController =
      TextEditingController();
  final TextEditingController fechaMatriculoVehiController =
      TextEditingController();


  // Controladores de Tareas
  final TextEditingController descTareaController = TextEditingController();
  final TextEditingController asociadasTareasController = TextEditingController();
  final TextEditingController activosVinculadosTareaController = TextEditingController();
  

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

  Future<int?> registrarActivoU(String? token) async {
    try {

        Map<String, String> regBodyActivo = {
          "id_vehiculo": idvehicuController.text,
          "marca": marcaVehiController.text,
          "modelo": modeloVehiController.text,
          "linea": lineaVehiController.text,
          "color": colorVehiController.text,
          "capacidad": capacidadVehiController.text,
          "clase_vehiculo": claseVehiController.text,
          "cilindraje": cilindrajeVehiController.text,
          "tipo_combustible": tipoCombustibleVehiemailController.text,
          "numero_motor": numeroMotorController.text,
          "numero_chasis": numeroChasisController.text,
          "vin": vinVehiController.text,
          "ciudad_registro": ciudadRegristroVehiController.text,
          "fecha_matricula": fechaMatriculoVehiController.text
        };
        var response = await http.post(
          Uri.parse(registrarActivoUrl),
          headers: {
            "Authorization":"Bearer $token", 
            "Content-Type":"application/json", 
          },
          body: jsonEncode(regBodyActivo),
        );

        var jsonActivoResponse = jsonDecode(response.body);

        print("este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Vehiculo registrado");
          return 200;
        } else if (response.statusCode == 400) {
          throw Exception("Falta llenar más campos.");
        } else if (response.statusCode == 409) {
          // handleRegistrationError(response.statusCode, jsonActivoResponse['msg']);
        } else {
          throw Exception("Error desconocido al registrar vehiculo.");
        }

    } catch (e) {
      print("Error al registrar usuario: $e");
    }
    return null;
  }

  Future<List<dynamic>> obtenerActivosU(String? token) async {
    try {
        var response = await http.get(
          Uri.parse(getActivosUrl),
          headers: {
            "Authorization":"Bearer $token", 
            "Content-Type":"application/json", 
          }
        );

        var jsonActivoResponse = jsonDecode(response.body);

        print("este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Vehiculo Encontrado");
          return jsonActivoResponse;
        } else if (response.statusCode == 404) {
          throw Exception("No hay vehiculos.");
        } else {
          throw Exception("Error desconocido al obtener vehiculos.");
        }

    } catch (e) {
      print("Error al registrar usuario: $e");
    }
    return [];
  }

  Future<Map<String, dynamic>> obtenerActivoByPlacaU(String? token, String placa) async {
    try {
        var response = await http.get(
          Uri.parse("$getActivoEspecificoUrl$placa"),
          headers: {
            "Authorization":"Bearer $token", 
            "Content-Type":"application/json", 
          }
        );

        var jsonActivoResponse = jsonDecode(response.body);

        print("este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Vehiculo con la placa $placa encontrado");
          return jsonActivoResponse;
        } else if (response.statusCode == 400) {
          throw Exception("La placa es obligatoria.");
        } else if (response.statusCode == 404) {
          throw Exception("Vehiculo con la placa $placa no encontrado.");
        } else {
          throw Exception("Error desconocido al obtener vehiculos.");
        }

    } catch (e) {
      print("Error al registrar usuario: $e");
    }
    return {};
  }


}
  

