import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:provider/provider.dart';

class VehiculosBuilder extends StatefulWidget {
  final isPressed;
  const VehiculosBuilder({super.key, this.isPressed});

  @override
  State<VehiculosBuilder> createState() => _VehiculoBuilderState();
}

class _VehiculoBuilderState extends State<VehiculosBuilder> {
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

class MyActivos extends StatefulWidget {
  final Activos activoData;
  final SelectedDashboardProvider selectedIndexProvider;
  final bool isPressed;

  const MyActivos({
    super.key,
    required this.selectedIndexProvider,
    required this.activoData,
    required this.isPressed,
  });

  @override
  State<MyActivos> createState() => _MyActivosState();
}

class _MyActivosState extends State<MyActivos> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.selectedIndexProvider.updateSelectedIndex(2);
        widget.selectedIndexProvider.updateSelectedActivo(widget.activoData);
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
              children: [
                widget.isPressed
                    ? Column(
                        children: [
                          
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
                    : const SizedBox(),
              ],
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.activoData.id_vehiculo,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                Text(
                  "// ${widget.activoData.marca} ${widget.activoData.linea} ${widget.activoData.modelo}",
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
