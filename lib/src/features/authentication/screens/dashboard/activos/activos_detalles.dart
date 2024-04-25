import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:provider/provider.dart';

class ActivosDetalles extends StatefulWidget {
  const ActivosDetalles({super.key});

  @override
  State<ActivosDetalles> createState() => _ActivosDetallesState();
}

class _ActivosDetallesState extends State<ActivosDetalles> {
  TextStyle textoListitle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(209, 0, 0, 0));
  late Future<List<ActivoPlaca>>? futureCardsData;

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Obtener una instancia del AuthController
  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    futureCardsData = fetchActivoPlaca();
  }

  Future<List<ActivoPlaca>> fetchActivoPlaca() async {
    // Obtener la instancia de SelectedDashboardProvider
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context, listen: false);

    // Llamar al método verificarTokenU() y esperar su resultado del token si existe
    String? token = await tokenProvider.verificarTokenU();

    // Llamar al método obtenerActivoByPlacaU() para obtener el json de los activos con el token válido
    dynamic response = await authController.obtenerActivoByPlacaU(
        token, selectedIndexProvider.selectedActivo.id_vehiculo);

    return parseActivoPlaca(response);
  }

  List<ActivoPlaca> parseActivoPlaca(Map<String, dynamic> responseBody) {
    return [ActivoPlaca.fromJson(responseBody)];
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final size = MediaQuery.of(context).size;

    String idVehiculo = selectedIndexProvider.selectedActivo.id_vehiculo;
    String primeraParte = idVehiculo.substring(0, 3); // Primeros 3 caracteres
    String segundaParte = idVehiculo.substring(3); // Últimos 3 caracteres
    String idVehiculoFormateado = '$primeraParte•$segundaParte';

    String imagen = authController.getImageVehiculoU(idVehiculo);

    return FutureBuilder<List<ActivoPlaca>>(
      future: futureCardsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ActivoPlaca activo = snapshot.data![0];
          return Detalles(
            size: size,
            selectedIndexProvider: selectedIndexProvider,
            idVehiculo: idVehiculo,
            idVehiculoFormateado: idVehiculoFormateado,
            textoListitle: textoListitle,
            activoplaca: activo,
            imageUrl: imagen,
          );
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los activos');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class Detalles extends StatelessWidget {
  Detalles({
    super.key,
    required this.size,
    required this.selectedIndexProvider,
    required this.idVehiculo,
    required this.idVehiculoFormateado,
    required this.textoListitle,
    required this.activoplaca,
    required this.imageUrl,
  });

  final Size size;
  final SelectedDashboardProvider selectedIndexProvider;
  final String idVehiculo;
  final String idVehiculoFormateado;
  final TextStyle textoListitle;
  final ActivoPlaca activoplaca;
  final String imageUrl;

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.88,
        width: size.width * 0.95,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(bottom: 5),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.2))),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        selectedIndexProvider.updateSelectedIndex(1);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: tPrimaryColor, size: 28),
                    ),
                    const SizedBox(
                      width: 15.5,
                    ),
                    if ((idVehiculo.length == 6))
                      Text(
                        idVehiculoFormateado,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      )
                    else
                      Text(
                        idVehiculo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    image: NetworkImage(imageUrl),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Devolver la imagen predeterminada o el icono aquí
                      return const Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Icono predeterminado si no hay imagen seleccionada
                ),
              ),
              Divider(thickness: 1, color: Colors.black26),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  "Detalles",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.house_siding_rounded,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'General',
                  style: textoListitle,
                ),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedActivoxPlaca(activoplaca);
                  selectedIndexProvider.updateSelectedIndex(4);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.history,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'Historiales',
                  style: textoListitle,
                ),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(1);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.description_outlined,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'Gestión Documental',
                  style: textoListitle,
                ),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(1);
                },
              ),
            ]));
  }
}
