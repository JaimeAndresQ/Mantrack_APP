import 'dart:typed_data';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/ordenes_trabajo_modal.dart';
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

  TokenProvider tokenProvider = TokenProvider();

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
    String tipoMantenimiento =
        widget.ordenActual.tipoMantenimiento.toLowerCase();
    String tipoMantenimientoCapitalizado =
        tipoMantenimiento.substring(0, 1).toUpperCase() +
            tipoMantenimiento.substring(1);

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
                          widget.ordenActual.fechaRealizacion.toString(),
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
                  const SizedBox(
                    height: tDefaultSize - 10,
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
                  Text(
                    "Tareas",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(164, 0, 0, 0)),
                  ),
                  Divider(
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

                                           SizedBox(width: 10,),
                                           GestureDetector(
                                            onTap: (){
                                              widget.selectedIndexProvider.updateSelectedIndex(17);
                                            },
                                             child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: tPrimaryOpacity,
                                                shape: BoxShape.circle
                                              ),
                                              child: Icon(Icons.visibility_outlined, size: 20,color:  tPrimaryColor)),
                                           )
                       ],
                     ),
                   ),

                                     Divider(
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
                            text: widget.ordenActual.tiempoEstimado.toString(),
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
                ],
              )),
        ),
      ],
    );
  }
}
