import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/ordenes_trabajo_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_hist_detalles.dart';
import 'package:provider/provider.dart';

class ActivosHistorialesBuilder extends StatefulWidget {
  final String vehiculoId;
  const ActivosHistorialesBuilder({super.key, required this.vehiculoId});

  @override
  State<ActivosHistorialesBuilder> createState() => _ActivosHistorialesBuilderState();
}

class _ActivosHistorialesBuilderState extends State<ActivosHistorialesBuilder> {
  late Future<List<OrdenTrabajo>>? futureCardsData;

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Obtener una instancia de TokenProvider
  SelectedDashboardProvider dashboardProvider = SelectedDashboardProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  Future<List<OrdenTrabajo>>? fetchActivos() async {
    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al metodo obtenerActivosU() para tener el json de los activos con el token valido
    dynamic response = await authController.obtenerOrdenesTrabajoVehiculoU(token, widget.vehiculoId);
    return parseActivos(response);
  }

  List<OrdenTrabajo> parseActivos(Map<String, dynamic> responseBody) {
    final List<dynamic> items = responseBody['ordenesTrabajo'];


    return items
        .asMap()
        .map((index, json) =>
            MapEntry(index, OrdenTrabajo.fromJson(json)))
        .values
        .toList();
  }


  @override
  void initState() {
    super.initState();
    futureCardsData = fetchActivos();
  }



  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    return FutureBuilder<List<OrdenTrabajo>>(
      future: futureCardsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              return Planes(
                selectedIndexProvider: selectedIndexProvider,
                planesData: snapshot.data![index],
                index: index,

              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("Esto paso: ${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}


class Planes extends StatefulWidget {
  final OrdenTrabajo planesData;
  final SelectedDashboardProvider selectedIndexProvider;
  final int index;

  const Planes({
    super.key,
    required this.selectedIndexProvider,
    required this.planesData,
    required this.index
  });

  @override
  State<Planes> createState() => _PlanesState();
}

class _PlanesState extends State<Planes> {
  bool isChecked = false;

    String getCategoriaText(int categoriaValue) {
    switch (categoriaValue) {
      case 1:
        return 'Mantenimiento general';
      case 2:
        return 'Cambio de aceite';
      case 3:
        return 'Reparación de motor';
      default:
        return 'Sin categoría definida';
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.selectedIndexProvider.updateSelectedOrdenTrabajo(widget.planesData);
        Get.to(() => const HistorialesDetalles());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 0.2, 
        ))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.planesData.descripcion,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Orden de Trabajo: ${widget.planesData.id_ordenTrabajo}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: tPrimaryColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Tipo de Tarea: ${getCategoriaText(widget.planesData.categoriaFk)}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: tPrimaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}