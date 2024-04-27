import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:provider/provider.dart';

class PlanesBuilder extends StatefulWidget {
  final isPressed;
  const PlanesBuilder({super.key, this.isPressed});

  @override
  State<PlanesBuilder> createState() => _PlanesBuilderState();
}

class _PlanesBuilderState extends State<PlanesBuilder> {
  late Future<List<PlanMantenimiento>>? futureCardsData;

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  Future<List<PlanMantenimiento>>? fetchActivos() async {
    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al metodo obtenerActivosU() para tener el json de los activos con el token valido
    dynamic response = await authController.obtenerPlanesMantenimientoU(token);
    return parseActivos(response);
  }

  List<PlanMantenimiento> parseActivos(Map<String, dynamic> responseBody) {
    print("Response del response: ${responseBody['planesMantenimiento']}");
    final List<dynamic> items = responseBody['planesMantenimiento'];
    return items
        .asMap()
        .map((index, json) => MapEntry(index, PlanMantenimiento.fromJson(json)))
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

    return FutureBuilder<List<PlanMantenimiento>>(
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
                isPressed: widget.isPressed,
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
  final PlanMantenimiento planesData;
  final SelectedDashboardProvider selectedIndexProvider;
  final bool isPressed;

  const Planes({
    super.key,
    required this.selectedIndexProvider,
    required this.isPressed,
    required this.planesData
  });

  @override
  State<Planes> createState() => _PlanesState();
}

class _PlanesState extends State<Planes> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.selectedIndexProvider.updateSelectedIndex(9);
        widget.selectedIndexProvider.updateSelectedPlanMantenimiento(widget.planesData);
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
            widget.isPressed
            ?
            Column(
              children: [
                const Icon(
                  Icons.precision_manufacturing_outlined,
                  color: tPrimaryColor,
                ),
                Checkbox(
                    activeColor: tPrimaryColor,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    })
              ],
            )
            :
            const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.planesData.nombre,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Tareas asociadas: 0",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: tPrimaryColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Activos vinculados: 0",
                  style: TextStyle(
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