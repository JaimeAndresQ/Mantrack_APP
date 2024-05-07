import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/ordenes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/ordenes_trabajo_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class OrdenTrabajoBuilder extends StatefulWidget {
  final String estado;
  const OrdenTrabajoBuilder({super.key, required this.estado});

  @override
  State<OrdenTrabajoBuilder> createState() => _OrdenTrabajoBuilderState();
}

class _OrdenTrabajoBuilderState extends State<OrdenTrabajoBuilder> {
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
    dynamic response = await authController.obtenerOrdenesTrabajoEstadoU(token, widget.estado);
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
      child: FutureBuilder<List<OrdenTrabajo>>(
        future: futureCardsData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(),
              itemBuilder: (context, index) {
                return Ordenes(
                  selectedIndexProvider: selectedIndexProvider,
                  ordenData: snapshot.data![index],
                  
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

class Ordenes extends StatelessWidget {
  const Ordenes({
    super.key, required this.selectedIndexProvider, required this.ordenData,
  });

  final SelectedDashboardProvider selectedIndexProvider;
  final OrdenTrabajo ordenData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              
              Row(children: [
                SizedBox(
                    child: Avatar(
                  name: ordenData.correoUsuario,
                  shape: AvatarShape(
                      width: 40,
                      height: 40,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                )),
                const SizedBox(
                  width: tDefaultSize - 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ordenData.correoUsuario,
                      style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(164, 0, 0, 0)),
                    ),
                    Text(
                      ordenData.fechaRealizacion.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(164, 0, 0, 0)
                              .withOpacity(0.5)),
                    ),
                  ],
                )
              ]),
              const SizedBox(height: tDefaultSize - 20,),
              Text(
                "Creado por ${ordenData.correoUsuario}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(164, 0, 0, 0).withOpacity(0.5)),
              ),
              const SizedBox(height: tDefaultSize - 20,),
              Text(
                ordenData.id_vehiculo,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(164, 0, 0, 0)),
              ),
              const SizedBox(height: tDefaultSize - 10,),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.layers_outlined, color: tPrimaryColor, size: 20,),
                      const SizedBox(width: 3,),
                      Text(
                      "1",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(164, 0, 0, 0).withOpacity(0.5)),
                    ),
                    ],
                  ),
                  const SizedBox(width: 5,),
                  Row(
                    children: [
                      const Icon(Icons.playlist_add_check, color: tPrimaryColor, size: 20,),
                      const SizedBox(width: 3,),
                      Text(
                      "1",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(164, 0, 0, 0).withOpacity(0.5)),
                    ),
                    ],
                  )
    
                ],
              ),
              
            ],
          )),
    );
  }
}




