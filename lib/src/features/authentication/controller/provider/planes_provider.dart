import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';

class PlanesProvider extends ChangeNotifier {

  SelectedDashboardProvider selectedDashboardProvider = SelectedDashboardProvider();
  TokenProvider token = TokenProvider();
  AuthController authController = AuthController();
  late Future<List<PlanMantenimiento>>? futureCardsData;

  Future<PlanMantenimiento> updateMantenimeintosAsociados(int idPlan) async {
    final futureCardsData = await fetchNewPlanData(idPlan);
    return futureCardsData![idPlan - 1];
  }

  Future<List<PlanMantenimiento>>? fetchNewPlanData(int idPlan) async {
    String? tokenActual = await token.verificarTokenU();
    dynamic response =
        await authController.obtenerPlanesMantenimientoU(tokenActual);
    return parseMantenimiento(response, idPlan);
  }

  List<PlanMantenimiento> parseMantenimiento(Map<String, dynamic> responseBody, int idPlan) {
    final List<dynamic> items = responseBody['planesMantenimiento'];
    print(items[idPlan - 1]);
    return items
        .asMap()
        .map((index, json) => MapEntry(index, PlanMantenimiento.fromJson(json)))
        .values
        .toList();

  }


}
