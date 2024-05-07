// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'auth_config.dart';

class AuthController {

// Metodo de manejador de errores

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

// Metodos de extraccion de imagenes

  Future<dynamic> getImageU(String email, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$getImagenUrl$email"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "image/jpeg",
        },
      );

      print(
          "Este es el response ${response.bodyBytes} y el código ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Imagen encontrada");
        // Retornar el contenido de la imagen en lugar de la URL
        return response.bodyBytes; // Devuelve el buffer de imagen como bytes
      } else {
        throw Exception("Error desconocido al obtener imagen.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
      return null;
    }
  }


  Future<dynamic> getImageVehiculoU(String placa, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$getVehiculoImagenUrl$placa"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "image/jpeg",
        },
      );

      print(
          "Este es el response ${response.bodyBytes} y el código ${response.statusCode}");
      print("Codigo ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Imagen del vehiculo encontrada");
        // Retornar el contenido de la imagen en lugar de la URL
        return response.bodyBytes; // Devuelve el buffer de imagen como bytes
      } else {
        throw Exception("Error desconocido al obtener imagen.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
      return null;
    }
  }


// Metodos de login y inicio de sesion 

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


 Future<int?> registerU(File file) async {
    try {
      if (emailController.text.isNotEmpty) {
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

        // Solucitud Multipart
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(registrationImagenUrl),
        );

        // Agregar el archivo al cuerpo de la solicitud
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
          ),
        );

        // Agregar otros campos al cuerpo de la solicitud
        request.fields['correo'] = emailController.text;

        // Enviar la solicitud y obtener la respuesta
        var responseImagen = await request.send();

        // Leer la respuesta del servidor
        var responseJsonImagen = await responseImagen.stream.bytesToString();

        var jsonResponseImagen = jsonDecode(responseJsonImagen);

        print(
            "este es el response $jsonResponseImagen y el codigo ${responseImagen.statusCode}");

        if (response.statusCode == 201 && responseImagen.statusCode == 200) {
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

// Metodos de los Activos

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


  Future<int?> registrarActivoU(String? token, File file) async {
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
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      // Solucitud Multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(registrationVehiculoImagenUrl),
      );

      // Agregar encabezados a la solicitud
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });

      // Agregar el archivo al cuerpo de la solicitud
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      // Agregar otros campos al cuerpo de la solicitud
      request.fields['placa_vehiculo'] = idvehicuController.text;

      // Enviar la solicitud y obtener la respuesta
      var responseImagen = await request.send();

      // Leer la respuesta del servidor
      var responseJsonImagen = await responseImagen.stream.bytesToString();

      var jsonResponseImagen = jsonDecode(responseJsonImagen);

      print(
          "este es el response $jsonResponseImagen y el codigo ${responseImagen.statusCode}");

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
      var response = await http.get(Uri.parse(getActivosUrl), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

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

  Future<Map<String, dynamic>> obtenerActivoByPlacaU(
      String? token, String placa) async {
    try {
      var response =
          await http.get(Uri.parse("$getActivoEspecificoUrl$placa"), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

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

  Future<int?> actualizarActivoU(String? token, File? file) async {
    try {
      Map<String, String> regBodyActivo = {
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
      print("$actualizarActivoUrl${idvehicuController.text}");
      var response = await http.put(
        Uri.parse("$actualizarActivoUrl${idvehicuController.text}"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (file != null) {
        // Solucitud Multipart
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(registrationVehiculoImagenUrl),
        );

        // Agregar encabezados a la solicitud
        request.headers.addAll({
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        });

        // Agregar el archivo al cuerpo de la solicitud
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
          ),
        );

        // Agregar otros campos al cuerpo de la solicitud
        request.fields['placa_vehiculo'] = idvehicuController.text;

        // Enviar la solicitud y obtener la respuesta
        var responseImagen = await request.send();

        // Leer la respuesta del servidor
        var responseJsonImagen = await responseImagen.stream.bytesToString();

        var jsonResponseImagen = jsonDecode(responseJsonImagen);

        print(
            "este es el response $jsonResponseImagen y el codigo ${responseImagen.statusCode}");
      }

      if (response.statusCode == 200) {
        print("Vehiculo actualizado");
        return 200;
      } else if (response.statusCode == 404) {
        throw Exception("Placa no encontrada.");
      } else {
        throw Exception("Error desconocido al actualizar vehiculo.");
      }
    } catch (e) {
      print("Error al actualizar: $e");
    }
    return null;
  }

// Metodos de Tareas

  // Controladores de Mantenimientos
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController tipoMantenimientoController =
      TextEditingController();
  final TextEditingController duracionMantenimientoController =
      TextEditingController();
  final TextEditingController categoriaMantenimientoController =
      TextEditingController();

  // Controladores de Registro Plan
  final TextEditingController descTareaController = TextEditingController();
  final TextEditingController asociadasTareasController =
      TextEditingController();
  final TextEditingController activosVinculadosTareaController =
      TextEditingController();


  Future<int?> registrarMantenimientoU(String token) async {
    try {

      Map<String, int> categoriaMap = {
        "Mantenimiento general": 1,
        "Cambio de aceite": 2,
        "Reparación de motor": 3,
      };

      var categoriaFk = categoriaMap[categoriaMantenimientoController.text];
      print(categoriaFk);

      Map<String, dynamic> regBodyActivo = {
        "tipo_mantenimiento": tipoMantenimientoController.text,
        "descripcion": descripcionController.text,
        "duracion_estimada": duracionMantenimientoController.text,
        "fk_id_categoria": categoriaFk,
      };

      print(regBodyActivo);

      var response = await http.post(
        Uri.parse(registrarMantenimientoUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Mantenimiento registrado");
        return 200;
      } else if (response.statusCode == 400) {
        throw Exception("Falta llenar más campos.");
      } else {
        throw Exception("Error desconocido al registrar mantenimeinto.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
    }
    return null;
  }

  Future<int?> registrarPlanTareasU(String token) async {
    try {

      Map<String, String> regBodyActivo = {
        "pl_nombre": descTareaController.text,
      };

      print(regBodyActivo);

      var response = await http.post(
        Uri.parse(registrarPlandeMantenimientoUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Plan registrado");
        return 200;
      } else if (response.statusCode == 400) {
        throw Exception("Falta llenar más campos.");
      } else {
        throw Exception("Error desconocido al registrar el plan.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
    }
    return null;
  }


  Future<int?> asociarMantenimientosU(String token, int idplan, int idtarea) async {
    try {

      Map<String, int> regBodyActivo = {
        "id_mantenimiento": idtarea,
        "id_plan_mantenimiento": idplan,
      };

      print(regBodyActivo);

      var response = await http.put(
        Uri.parse(putAsociarMantenimientosUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Mantenimiento asociado con exito");
        return 200;
      } else if (response.statusCode == 400) {
        throw Exception("Se requieren los IDs de mantenimiento y plan de mantenimiento.");
      } else if (response.statusCode == 404) {
        throw Exception("No se encontró el mantenimiento con el ID proporcionado.");
      } else {
        throw Exception("Error desconocido al asociar el mantenimiento.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
    }
    return null;
  }

  Future<int?> asociarActivosU(String token, int idplan, String idvehiculo) async {
    try {

      Map<String, dynamic> regBodyActivo = {
        "id_vehiculo": idvehiculo,
        "id_plan_mantenimiento": idplan,
      };

      print(regBodyActivo);

      var response = await http.put(
        Uri.parse(putAsociarActivoUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Activo asociado con exito");
        return 200;
      } else if (response.statusCode == 400) {
        throw Exception("Se requieren los IDs de vehiculo y plan de mantenimiento.");
      } else if (response.statusCode == 404) {
        throw Exception("No se encontró el activo con la placa proporcionada.");
      } else {
        throw Exception("Error desconocido al asociar el mantenimiento.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>> obtenerPlanesMantenimientoU(String? token) async {
      try {
        var response = await http.get(Uri.parse(getAllPlanesMantenimientoUrl), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        });

        var jsonActivoResponse = jsonDecode(response.body);

        print(
            "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Planes de Mantenimientos Encontrados");
          return jsonActivoResponse;
        } else if (response.statusCode == 404) {
          throw Exception("No hay planes de mantenimiento.");
        } else {
          throw Exception("Error desconocido al obtener los planes de mantenimiento.");
        }
      } catch (e) {
        print("Error al realizar la peticion: $e");
      }
      return {};
    }

  Future<Map<String, dynamic>> obtenerMantenimientosU(String? token, int planid) async {
      try {
        var response = await http.get(Uri.parse("$getMantenimientoTareaUrl$planid"), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        });

        var jsonActivoResponse = jsonDecode(response.body);

        print(
            "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Mantenimientos Encontrados");
          return jsonActivoResponse;
        } else {
          throw Exception("Error desconocido al obtener los mantenimiento.");
        }
      } catch (e) {
        print("Error al realizar la peticion: $e");
      }
      return {};
    }
    
  Future<Map<String, dynamic>> obtenerActivosNoAsociadosU(String? token, int planid) async {
      try {
        var response = await http.get(Uri.parse("$getActivosNoAsociadosUrl$planid"), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        });

        print(response);

        var jsonActivoResponse = jsonDecode(response.body);

        print(
            "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Activos No Asociados Encontrados");
          return jsonActivoResponse;
        } else {
          throw Exception("Error desconocido al obtener los activos no asociados.");
        }
      } catch (e) {
        print("Error al realizar la peticion: $e");
      }
      return {};
    }


// Metodos de Ordenes de trabajo

  // Controladores de Registro de Ordenes
  final TextEditingController descOTsController = TextEditingController();
  final TextEditingController tiempoEstimadoOTsController = TextEditingController();
  final TextEditingController tipoOTsController = TextEditingController();
  final TextEditingController encargadoOTsController = TextEditingController();
  final TextEditingController activoOTsController = TextEditingController();
  final TextEditingController categoriaOTsController = TextEditingController();


  Future<int?> registrarOrdenTrabajoU(String token, String usuario) async {
    try {

      Map<String, int> categoriaMap = {
        "Mantenimiento general": 1,
        "Cambio de aceite": 2,
        "Reparación de motor": 3,
      };

      var categoriaFk = categoriaMap[categoriaOTsController.text];

      Map<String, dynamic> regBodyActivo = {
        "descripcion": descOTsController.text,
        "tiempo_estimado": tiempoEstimadoOTsController.text,
        "tipo_mantenimiento": tipoOTsController.text,
        "fk_id_usuario_correo": usuario,
        "fk_id_vehiculo": activoOTsController.text,
        "fk_id_categoria": categoriaFk,
      };

      print(regBodyActivo);

      var response = await http.post(
        Uri.parse(registrarOTsUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(regBodyActivo),
      );

      var jsonActivoResponse = jsonDecode(response.body);

      print(
          "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Plan registrado");
        return 200;
      } else if (response.statusCode == 400) {
        throw Exception("Falta llenar más campos.");
      } else if (response.statusCode == 404) {
        print("El usuario al que se asocia la orden de trabajo no existe / El vehiculo al que se asocia la orden de trabajo no existe");
        return 404;
      } else {
        throw Exception("Error desconocido al registrar el plan.");
      }
    } catch (e) {
      print("Error al realizar la peticion: $e");
    }
    return null;
  }


  Future<Map<String, dynamic>> obtenerOrdenesTrabajoEstadoU(String? token, String estado) async {
      try {
        var response = await http.get(Uri.parse("$getAllOrdenesTrabajo$estado"), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        });

        print(response);

        var jsonActivoResponse = jsonDecode(response.body);

        print(
            "este es el response $jsonActivoResponse y el codigo ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Orden de trabajo de tipo $estado encontrados");
          return jsonActivoResponse;
        } else {
          throw Exception("Error desconocido al obtener las ordenes de trabajo.");
        }
      } catch (e) {
        print("Error al realizar la peticion: $e");
      }
      return {};
    }






}


