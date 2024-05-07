import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';

class OrdenesProvider extends ChangeNotifier {
  TokenProvider tokenProvider = TokenProvider();
  AuthController authController = AuthController();
  
  late int _ordenesPendientes; // Lista para almacenar las opciones de activos

  int get ordenesPendientes => _ordenesPendientes;

  Future<void> fetchOrdenesPendientes() async {
    String? token = await tokenProvider.verificarTokenU();
    dynamic response = await authController.obtenerOrdenesTrabajoEstadoU(token, "P");
    List<dynamic> items = response['ordenesTrabajo'];
    _ordenesPendientes = items.length;
    notifyListeners();
  }
  
}
