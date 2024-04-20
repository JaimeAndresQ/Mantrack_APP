import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:provider/provider.dart';

class ActivosBuilder extends StatefulWidget {
  const ActivosBuilder({super.key});

  @override
  State<ActivosBuilder> createState() => _ActivosBuilderState();
}

class _ActivosBuilderState extends State<ActivosBuilder> {
  late Future<List<Activos>>? futureCardsData;

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  Future<List<Activos>>? fetchActivos() async {
    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al metodo obtenerActivosU() para tener el json de los activos con el token valido
    dynamic response = await authController.obtenerActivosU(token);
    return parseActivos(response);
    
  }

  List<Activos> parseActivos(List<dynamic> responseBody) {
    return responseBody
        .asMap()
        .map((index, json) => MapEntry(index, Activos.fromJson(json)))
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

    return FutureBuilder<List<Activos>>(
      future: futureCardsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              return MyActivos(
                selectedIndexProvider: selectedIndexProvider,
                activoData: snapshot.data![index],
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

class MyActivos extends StatelessWidget {
  final Activos activoData;
  final SelectedDashboardProvider selectedIndexProvider;

  const MyActivos({
    super.key,
    required this.selectedIndexProvider,
    required this.activoData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        selectedIndexProvider.updateSelectedIndex(2);
        selectedIndexProvider.updateSelectedActivo(activoData);

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
            const Icon(
              Icons.token_outlined,
              color: tPrimaryColor,
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activoData.id_vehiculo,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                Text(
                  "// ${activoData.marca} ${activoData.linea} ${activoData.modelo}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
