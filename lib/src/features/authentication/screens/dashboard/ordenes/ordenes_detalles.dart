// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/ordenes_trabajo_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_formulario.dart';
import 'package:provider/provider.dart';

class OrdenesDetalles extends StatefulWidget {
  const OrdenesDetalles({super.key});

  @override
  State<OrdenesDetalles> createState() => _OrdenesDetallesState();
}

class _OrdenesDetallesState extends State<OrdenesDetalles> {
  TextStyle textoListitle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(209, 0, 0, 0));

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final size = MediaQuery.of(context).size;

    final activo = selectedIndexProvider.selectedOTs;

    return DetallesOTs(
      size: size,
      selectedIndexProvider: selectedIndexProvider,
      textoListitle: textoListitle,
      ordenActual: activo,
    );
  }
}

class DetallesOTs extends StatefulWidget {
  DetallesOTs({
    super.key,
    required this.size,
    required this.selectedIndexProvider,
    required this.textoListitle,
    required this.ordenActual,
  });

  final Size size;
  final SelectedDashboardProvider selectedIndexProvider;
  final TextStyle textoListitle;
  final OrdenTrabajo ordenActual;

  @override
  State<DetallesOTs> createState() => _DetallesOTsState();
}

class _DetallesOTsState extends State<DetallesOTs> {
  AuthController authController = AuthController();

  late TokenProvider tokenProvider;
  late String? rol;
  bool isLoading = true;

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

  String detalleDescOTsError = '';
  String detallesTiempoEjecuOTsError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      detalleDescOTsError =
          authController.detallesDescOTsController.text.isEmpty
              ? 'Escriba una observacion'
              : '';
      detallesTiempoEjecuOTsError =
          authController.detallesTiempoEstimadoOTsController.text.isEmpty
              ? 'Ingrese un tiempo de duracion estimada'
              : '';
    });
  }

  late int horasEje;
  late int minutosRestantesEje;
  late String tiempoEstimadoFormateadoEje;

  @override
  void initState() {
    super.initState();
    _initRol();

  }

  void _initRol() async {
    tokenProvider = TokenProvider();
    try {
      rol = await tokenProvider.verificarTokenU(rol: true);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Manejar excepciones
      print('Error al obtener el rol: $e');
      setState(() {
        isLoading = false; // También puedes manejar el estado de error aquí
      });
    }
  }

  String formatTiempoEjecucion(int? tiempoEjecucion) {
  if (tiempoEjecucion != null) {
    int horas = tiempoEjecucion ~/ 60;
    int minutosRestantes = tiempoEjecucion % 60;
    return horas >= 1
        ? '$horas:${minutosRestantes.toString().padLeft(2, '0')}:00 horas'
        : '${minutosRestantes.toString().padLeft(2, '0')}:00 minutos';
  } else {
    return 'No disponible';
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedOTsProvider = Provider.of<SelectedDashboardProvider>(context);

    String tipoMantenimiento =
        widget.ordenActual.tipoMantenimiento.toLowerCase();
    String tipoMantenimientoCapitalizado =
        tipoMantenimiento.substring(0, 1).toUpperCase() +
            tipoMantenimiento.substring(1);

    // Convertir la cadena de fecha a DateTime
    DateTime fecha = DateTime.parse(widget.ordenActual.fechaRealizacion);

    // Formatear la fecha y el tiempo por separado
    String fechaFormateada = DateFormat('yyyy-MM-dd').format(fecha);
    String tiempoFormateado = DateFormat('HH:mm:ss').format(fecha);

    // Dividir los minutos en horas y minutos
    int horas = widget.ordenActual.tiempoEstimado ~/ 60;
    int minutosRestantes = widget.ordenActual.tiempoEstimado % 60;

    // Formatear la cadena de tiempo
    String tiempoEstimadoFormateado = horas >= 1
        ? '$horas:${minutosRestantes.toString().padLeft(2, '0')}:00'
        : '${minutosRestantes.toString().padLeft(2, '0')}:00';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.2)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  widget.selectedIndexProvider.updateSelectedIndex(14);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: tPrimaryColor, size: 28),
              ),
              const SizedBox(
                width: 15.5,
              ),
              Text(
                widget.ordenActual.correoUsuario,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        Container(
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
                      name:
                          "${widget.ordenActual.usuario.persona.nombres} ${widget.ordenActual.usuario.persona.apellidos}",
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
                          widget.ordenActual.correoUsuario,
                          style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(164, 0, 0, 0)),
                        ),
                        Text(
                          "$fechaFormateada / $tiempoFormateado",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(164, 0, 0, 0)
                                  .withOpacity(0.5)),
                        ),
                      ],
                    )
                  ]),
                  const SizedBox(
                    height: tDefaultSize - 20,
                  ),
                  Text(
                    "Creado por ${widget.ordenActual.usuario.persona.nombres} ${widget.ordenActual.usuario.persona.apellidos}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(164, 0, 0, 0)
                            .withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: tDefaultSize - 20,
                  ),
                  Text(
                    widget.ordenActual.id_vehiculo,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(164, 0, 0, 0)),
                  ),
                  selectedOTsProvider.selectedOTs.estado == "R" ||
                          selectedOTsProvider.selectedOTs.estado == "F"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Notas: ',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: tPrimaryColor),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.ordenActual.observaciones,
                                    style: const TextStyle(
                                        color: Color.fromARGB(155, 0, 0, 0))),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  isLoading
                      ? const CircularProgressIndicator() // Indicador de carga
                      : rol == "A" &&
                              selectedOTsProvider.selectedOTs.estado == "P"
                          ? Form(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: tFormHeight - 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormularioRich(
                                      controller: authController
                                          .detallesDescOTsController,
                                      nombreError:
                                          detalleDescOTsError.isNotEmpty
                                              ? detalleDescOTsError
                                              : null,
                                      errorStyle: errorStyle,
                                      texto: "Observaciones",
                                      icono:
                                          const Icon(Icons.note_add_outlined),
                                    ),
                                    const SizedBox(
                                      height: tFormHeight,
                                    ),
                                    Formulario(
                                      controller: authController
                                          .detallesTiempoEstimadoOTsController,
                                      nombreError:
                                          detallesTiempoEjecuOTsError.isNotEmpty
                                              ? detallesTiempoEjecuOTsError
                                              : null,
                                      errorStyle: errorStyle,
                                      texto: "Tiempo de Ejecucion",
                                      icono: const Icon(Icons.av_timer),
                                      permitirSoloNumeros: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: tDefaultSize - 20,
                            ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.layers_outlined,
                            color: tPrimaryColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "1",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(164, 0, 0, 0)
                                    .withOpacity(0.5)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.playlist_add_check,
                            color: tPrimaryColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "1",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(164, 0, 0, 0)
                                    .withOpacity(0.5)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tareas",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(164, 0, 0, 0)),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: tDefaultSize - 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.ordenActual.id_vehiculo,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(164, 0, 0, 0)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.selectedIndexProvider
                                .updateSelectedIndex(17);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: tPrimaryOpacity,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.visibility_outlined,
                                  size: 20, color: tPrimaryColor)),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Descripcion: ',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: tPrimaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.ordenActual.descripcion,
                            style: const TextStyle(color: Colors.black54)),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: tPrimaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: horas >= 1
                                ? "$tiempoEstimadoFormateado horas"
                                : "$tiempoEstimadoFormateado minutos",
                            style: const TextStyle(color: Colors.black54)),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: tPrimaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: tipoMantenimientoCapitalizado,
                            style: const TextStyle(color: Colors.black54)),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: tPrimaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: getCategoriaText(
                                widget.ordenActual.categoriaFk),
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : selectedOTsProvider.selectedOTs.estado == "R" ||
                              selectedOTsProvider.selectedOTs.estado == "F"
                                  // Dividir los minutos en horas y minutos
                          ? RichText(
                              text: TextSpan(
                                text: 'Tiempo Ejecucion: ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: tPrimaryColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: formatTiempoEjecucion(widget.selectedIndexProvider.selectedOTs.tiempoEjecucion),
                                      style: const TextStyle(
                                          color: Colors.black54)),
                                ],
                              ),
                            )
                          : SizedBox(),
                  isLoading
                      ? const CircularProgressIndicator() // Indicador de carga
                      : rol == "A" &&
                              selectedOTsProvider.selectedOTs.estado == "P"
                          ? GestureDetector(
                              onTap: () async {
                                validateAndSetErrors();
                                try {
                                  if (detalleDescOTsError.isEmpty &&
                                      detallesTiempoEjecuOTsError.isEmpty) {
                                    // Llamar a la funcion del provider
                                    String? token =
                                        await tokenProvider.verificarTokenU();

                                    if (token != null) {
                                      int? statusCode = await authController
                                          .finalizarOrdenTrabajoU(
                                              token,
                                              selectedOTsProvider
                                                  .selectedOTs.id_ordenTrabajo);

                                      if (statusCode == 200) {
                                        showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                                  title: '¡Perfecto!',
                                                  message:
                                                      'Se paso a revision el OTs',
                                                  onPressed: () {
                                                    selectedOTsProvider
                                                        .updateSelectedIndex(
                                                            14);

                                                    // Salir del Modal
                                                    Navigator.pop(context);
                                                  },
                                                ));
                                      } else if (statusCode == 404) {
                                        showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                                  title: '¡Error!',
                                                  error: true,
                                                  message:
                                                      'No se pudo pasar a revision el OTs',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ));
                                      }
                                    }
                                  }
                                } catch (e) {
                                  print("Error al registrar usuario: $e");
                                  // Manejar otros posibles errores aquí
                                }
                              },
                              child: IntrinsicWidth(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: tDashboardBackground,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color:
                                              Color.fromARGB(255, 18, 184, 18)),
                                      SizedBox(width: 5),
                                      Text(
                                        "Completado",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : rol == "A" &&
                                  selectedOTsProvider.selectedOTs.estado == "R"
                              ? GestureDetector(
                                  onTap: () async {
                                    try {
                                      // Llamar a la funcion del TokenProvider
                                      String? token =
                                          await tokenProvider.verificarTokenU();

                                      if (token != null) {
                                        int? statusCode = await authController
                                            .aprobarOrdenTrabajoU(
                                                token,
                                                selectedOTsProvider.selectedOTs
                                                    .id_ordenTrabajo);

                                        if (statusCode == 200) {
                                          showDialog(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog(
                                                    title: '¡Excelente!',
                                                    message:
                                                        '¡Se finalizo el OTs!',
                                                    onPressed: () {
                                                      selectedOTsProvider
                                                          .updateSelectedIndex(
                                                              14);

                                                      // Salir del Modal
                                                      Navigator.pop(context);
                                                    },
                                                  ));
                                        } else {
                                          showDialog(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog(
                                                    title: '¡Error!',
                                                    error: true,
                                                    message:
                                                        'No se pudo finalizar el OTs',
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ));
                                        }
                                      }
                                    } catch (e) {
                                      print("Error al registrar usuario: $e");
                                      // Manejar otros posibles errores aquí
                                    }
                                  },
                                  child: IntrinsicWidth(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: tDashboardBackground,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .playlist_add_check_circle_outlined,
                                              color: Color.fromARGB(
                                                  255, 18, 184, 162)),
                                          SizedBox(width: 5),
                                          Text(
                                            "Terminar",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                ],
              )),
        ),
      ],
    );
  }
}
