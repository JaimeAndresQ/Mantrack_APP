import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class MantenimientoBuilder extends StatefulWidget {
  final int idplan;
  const MantenimientoBuilder({super.key, required this.idplan});

  @override
  State<MantenimientoBuilder> createState() => _MantenimientoBuilderState();
}

class _MantenimientoBuilderState extends State<MantenimientoBuilder> {
  late Future<List<TareasMantenimiento>>? futureCardsData;

  // Obtener una instancia de TokenProvider

  TokenProvider tokenProvider = TokenProvider();
  // Obtener una instancia de TokenProvider
  SelectedDashboardProvider dashboardProvider = SelectedDashboardProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  Future<List<TareasMantenimiento>>? fetchActivos() async {
    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al metodo obtenerActivosU() para tener el json de los activos con el token valido
    dynamic response =
        await authController.obtenerMantenimientosU(token, widget.idplan);
    return parseActivos(response);
  }

  List<TareasMantenimiento> parseActivos(Map<String, dynamic> responseBody) {
    final List<dynamic> items = responseBody['mantenimientosNoAsociados'];
    return items
        .asMap()
        .map((index, json) =>
            MapEntry(index, TareasMantenimiento.fromJson(json)))
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
      onRefresh: (){
         return _refreshData();
      },
      child: FutureBuilder<List<TareasMantenimiento>>(
        future: futureCardsData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(),
              itemBuilder: (context, index) {
                return Tareas(
                  selectedIndexProvider: selectedIndexProvider,
                  tareasData: snapshot.data![index],
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

class Tareas extends StatefulWidget {
  final TareasMantenimiento tareasData;
  final SelectedDashboardProvider selectedIndexProvider;
  final int index;

  const Tareas(
      {super.key,
      required this.selectedIndexProvider,
      required this.tareasData,
      required this.index});

  @override
  State<Tareas> createState() => _TareasState();
}

class _TareasState extends State<Tareas> {
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
    final tokenProvider = Provider.of<TokenProvider>(context);

    AuthController authController = AuthController();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        String? token = await tokenProvider.verificarTokenU();
        if (token != null) {
          int? statusCode = await authController.asociarMantenimientosU(
              token,
              widget.selectedIndexProvider.selectedPlanMantenimiento
                  .idPlanMantenimiento,
              widget.tareasData.id);
          if (statusCode == 200) {
            showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      title: '¡Perfecto!',
                      message: '¡Se asocio exitosamente el mantenimiento!',
                      onPressed: () {
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
                      message: '¡No se pudo asociar el mantenimiento!',
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
                RichText(
                  text: TextSpan(
                    text:
                        'Descripcion: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.tareasData.descripcion,
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Duracion estimada: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.tareasData.duracion.toString(),
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Tipo de tarea: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.tareasData.tipo,
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Categoria: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: getCategoriaText(widget.tareasData.fkcategoria),
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
