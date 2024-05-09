import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/planes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class ActivosNoAsociadosBuilder extends StatefulWidget {
  final int idplan;
  const ActivosNoAsociadosBuilder({super.key, required this.idplan});

  @override
  State<ActivosNoAsociadosBuilder> createState() => _ActivosNoAsociadosBuilderState();
}

class _ActivosNoAsociadosBuilderState extends State<ActivosNoAsociadosBuilder> {
  late Future<List<ActivoPlaca>>? futureCardsData;

  // Obtener una instancia de TokenProvider

  TokenProvider tokenProvider = TokenProvider();
  // Obtener una instancia de TokenProvider
  SelectedDashboardProvider dashboardProvider = SelectedDashboardProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  Future<List<ActivoPlaca>>? fetchActivos() async {
    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al metodo obtenerActivosU() para tener el json de los activos con el token valido
    dynamic response =
        await authController.obtenerActivosNoAsociadosU(token, widget.idplan);
    print("${widget.idplan}");
    return parseActivos(response);
  }

  List<ActivoPlaca> parseActivos(Map<String, dynamic> responseBody) {
    final List<dynamic> items = responseBody['vehiculosNoAsociados'];
    
    return items
        .asMap()
        .map((index, json) => MapEntry(index, ActivoPlaca.fromJson(json)))
        .values
        .toList();
  }

  @override
  void initState() {
    super.initState();
    futureCardsData = fetchActivos();
  }

  // Actualiza los datos de la api
  Future<void> _refreshData() async {
    setState(() {
      futureCardsData = fetchActivos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    return RefreshIndicator(
      color: tPrimaryColor,
      onRefresh: () {
        return _refreshData();
      },
      child: FutureBuilder<List<ActivoPlaca>>(
        future: futureCardsData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(),
              itemBuilder: (context, index) {
                return MyActivosNoAsociados(
                  selectedIndexProvider: selectedIndexProvider,
                  activoData: snapshot.data![index],
                  index: index,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Esto paso: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class MyActivosNoAsociados extends StatefulWidget {
  final ActivoPlaca activoData;
  final SelectedDashboardProvider selectedIndexProvider;
  final int index;


  const MyActivosNoAsociados({
    super.key,
    required this.selectedIndexProvider,
    required this.activoData,
    required this.index,
  });

  @override
  State<MyActivosNoAsociados> createState() => _MyActivosNoAsociadosState();
}

class _MyActivosNoAsociadosState extends State<MyActivosNoAsociados> {
  bool isChecked = false;

    AuthController authController = AuthController();
    PlanesProvider planesBuilder = PlanesProvider();

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    final selectedIndexProvider = Provider.of<SelectedDashboardProvider>(context);

    AuthController authController = AuthController();

    refreshMantenimientos(int idPlan) async {
      var listaBuilder =
          await planesBuilder.updateMantenimeintosAsociados(idPlan);
      selectedIndexProvider.updateSelectedPlanMantenimiento(listaBuilder);
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        String? token = await tokenProvider.verificarTokenU();
        if (token != null) {
          int? statusCode = await authController.asociarActivosU(
              token, 
              widget.selectedIndexProvider.selectedPlanMantenimiento.idPlanMantenimiento,
              widget.activoData.id_vehiculo);
          if (statusCode == 200) {
            showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      title: '¡Perfecto!',
                      message: '¡Se asocio exitosamente el activo!',
                      onPressed: () {
                        refreshMantenimientos(widget.selectedIndexProvider.selectedPlanMantenimiento.idPlanMantenimiento);
                        // Cerrar el diálogo
                        Navigator.pop(context);
                        // Cerrar el modal
                        Navigator.pop(context);
                      },
                    ));
          } else {
            showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      title: '¡Ups!',
                      error: true,
                      message: '¡No se pudo asociar el activo!',
                      onPressed: () {
                        // Cerrar el diálogo
                        Navigator.pop(context);
                        // Cerrar el modal
                        Navigator.pop(context);
                      },
                    ));
          }
        }
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


