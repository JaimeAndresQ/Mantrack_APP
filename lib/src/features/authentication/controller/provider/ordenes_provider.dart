import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';

class OrdenesProvider extends ChangeNotifier {
  TokenProvider tokenProvider = TokenProvider();
  AuthController authController = AuthController();
  
  late int _ordenesProceso; // Variable de ordenes en proceso

  int get ordenesProceso => _ordenesProceso;

  Future<void> fetchOrdenesProceso() async {
    String? token = await tokenProvider.verificarTokenU();
    dynamic response = await authController.obtenerOrdenesTrabajoEstadoU(token, "P");
    List<dynamic> items = response['ordenesTrabajo'];
    _ordenesProceso = items.length;
    notifyListeners();
  }

  late int _ordenesRevision; // Variable de ordenes en revision

  int get ordenesRevision => _ordenesRevision;

  Future<void> fetchOrdenesRevision() async {
    String? token = await tokenProvider.verificarTokenU();
    dynamic response = await authController.obtenerOrdenesTrabajoEstadoU(token, "R");
    List<dynamic> items = response['ordenesTrabajo'];
    _ordenesRevision = items.length;
    notifyListeners();
  }
  

  late int _ordenesFinalizadas; // Lista para almacenar las opciones de activos

  int get ordenesFinalizadas => _ordenesFinalizadas;

  Future<void> fetchOrdenesFinalizadas() async {
    String? token = await tokenProvider.verificarTokenU();
    dynamic response = await authController.obtenerOrdenesTrabajoEstadoU(token, "F");
    List<dynamic> items = response['ordenesTrabajo'];
    _ordenesFinalizadas = items.length;
    notifyListeners();
  }
  
}
