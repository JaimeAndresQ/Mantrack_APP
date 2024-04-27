import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_formulario.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class TareaMantenimiento extends StatefulWidget {
  const TareaMantenimiento({
    super.key,
  });

  @override
  State<TareaMantenimiento> createState() => _TareaMantenimientoState();
}

class _TareaMantenimientoState extends State<TareaMantenimiento> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.height * 0.88,
          width: size.width * 0.95,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2))),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            selectedIndexProvider.updateSelectedIndex(9);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined,
                              color: tPrimaryColor, size: 28),
                        ),
                        const SizedBox(
                          width: 15.5,
                        ),
                        const Text(
                          "Mantenimientos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        Positioned(
          right: tDefaultSize - 5,
          bottom: tDefaultSize - 5,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                builder: (BuildContext context) {
                  return const DrawerMantenimiento();
                },
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          right: tDefaultSize - 5,
          bottom: tDefaultSize * 3.5,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                builder: (BuildContext context) {
                  return SizedBox();
                },
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}

class DrawerMantenimiento extends StatefulWidget {
  const DrawerMantenimiento({
    super.key,
  });

  @override
  State<DrawerMantenimiento> createState() => _DrawerMantenimientoState();
}

class _DrawerMantenimientoState extends State<DrawerMantenimiento> {
  AuthController authController = AuthController();

  String descError = '';
  String categoriaError = '';
  String tipoManteError = '';
  String duracionManteError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      descError = authController.descripcionController.text.isEmpty
          ? 'Ingrese una descripcion'
          : '';
      categoriaError =
          authController.categoriaMantenimientoController.text.isEmpty
              ? 'Elija una categoria'
              : '';
      tipoManteError = authController.tipoMantenimientoController.text.isEmpty
          ? 'Elija un tipo de mantenimiento'
          : '';
      duracionManteError =
          authController.duracionMantenimientoController.text.isEmpty
              ? 'Ingrese una duracion en minutos'
              : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedTokenProvider = Provider.of<TokenProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: size.height * 0.45,
        child: Drawer(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.88,
                width: size.width * 0.95,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderSave(
                        size: size,
                        titulo: "Nuevo Mantenimiento",
                        flechaAtras: () {
                          Navigator.pop(context);
                        },

                        botonGuardar: () async {
                          validateAndSetErrors();

                          if (descError.isEmpty &&
                              categoriaError.isEmpty &&
                              tipoManteError.isEmpty &&
                              duracionManteError.isEmpty) {
                            // Llamar a la funcion del provider
                            String? token =
                                await selectedTokenProvider.verificarTokenU();
                            if (token != null) {
                              int? statusCode = await authController
                                  .registrarMantenimientoU(token);

                              if (statusCode == 200) {
                                showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                          title: '¡Perfecto!',
                                          message:
                                              '¡Se creó exitosamente el mantenimiento!',
                                          onPressed: () {
                                            // Cerrar el diálogo
                                            Navigator.pop(context);
                                            // Cerrar el modal
                                            Navigator.pop(context);
                                          },
                                        ));
                              }
                            }
                          }
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          child: Form(
                              child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: tFormHeight - 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Formulario(
                                  controller:
                                      authController.descripcionController,
                                  nombreError:
                                      descError.isNotEmpty ? descError : null,
                                  errorStyle: errorStyle,
                                  texto: "Descripcion",
                                  icono: const Icon(Icons.description_outlined),
                                ),
                                const SizedBox(
                                  height: tFormHeight,
                                ),
                                FormularioSelect(
                                  opciones: const ["Preventivo", "Correctivo"],
                                  controller: authController
                                      .tipoMantenimientoController,
                                  nombreError: tipoManteError.isNotEmpty
                                      ? tipoManteError
                                      : null,
                                  errorStyle: errorStyle,
                                  texto: "Tipo de Mantenimiento",
                                  icono: const Icon(Icons.handyman_outlined),
                                ),
                                const SizedBox(
                                  height: tFormHeight,
                                ),
                                FormularioSelect(
                                  opciones: const [
                                    "Mantenimiento general",
                                    "Cambio de aceite",
                                    "Reparación de motor"
                                  ],
                                  controller: authController
                                      .categoriaMantenimientoController,
                                  nombreError: categoriaError.isNotEmpty
                                      ? categoriaError
                                      : null,
                                  errorStyle: errorStyle,
                                  texto: "Categoria del Mantenimiento",
                                  icono:
                                      const Icon(Icons.type_specimen_outlined),
                                ),
                                const SizedBox(
                                  height: tFormHeight,
                                ),
                                Formulario(
                                  controller: authController
                                      .duracionMantenimientoController,
                                  nombreError: duracionManteError.isNotEmpty
                                      ? duracionManteError
                                      : null,
                                  errorStyle: errorStyle,
                                  texto: "Duracion del Mantenimiento",
                                  icono: const Icon(Icons.timelapse_sharp),
                                  permitirSoloNumeros: TextInputType.number,
                                  maxCaracteres: 4,
                                ),
                              ],
                            ),
                          )),
                        ),
                      )
                    ]))),
      ),
    );
  }
}
