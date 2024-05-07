import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';

class ActivosProvider extends ChangeNotifier {
  TokenProvider tokenProvider = TokenProvider();
  AuthController authController = AuthController();
  
  late List<String> _opcionesActivos = []; // Lista para almacenar las opciones de activos

  List<String> get opcionesActivos => _opcionesActivos;

  Future<void> fetchActivos() async {
    String? token = await tokenProvider.verificarTokenU();
    dynamic response = await authController.obtenerActivosU(token);

    // Transformar los datos y almacenar las opciones en la lista del Provider
    _opcionesActivos.clear(); // Limpiar la lista antes de agregar nuevas opciones
    for (var activo in response) {
      // String opcion = '${activo['id_vehiculo']} - ${activo['veh_marca']} ${activo['veh_modelo']} ${activo['veh_linea']}';
      String opcion = '${activo['id_vehiculo']}';
      _opcionesActivos.add(opcion);
    }

    notifyListeners(); // Notificar a los consumidores del Provider que los datos han cambiado

    print(_opcionesActivos);
  }
}
