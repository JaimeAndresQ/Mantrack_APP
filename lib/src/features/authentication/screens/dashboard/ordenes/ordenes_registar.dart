import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

class OrdenesRegistrar extends StatefulWidget {
  const OrdenesRegistrar({
    super.key,
  });

  @override
  State<OrdenesRegistrar> createState() => _OrdenesRegistrarState();
}

class _OrdenesRegistrarState extends State<OrdenesRegistrar> {
  AuthController authController = AuthController();

  String descripError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      descripError = authController.descTareaController.text.isEmpty
          ? 'Ingrese una descripcion del plan'
          : '';
    });
  }

  final controller = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final tokenProvider = Provider.of<TokenProvider>(context);

    authController.asociadasTareasController.text = "0";
    authController.activosVinculadosTareaController.text = "0";

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.white),
              child: HeaderSave(
                  size: size,
                  titulo: "Tarea no Programada",
                  flechaAtras: () {
                    selectedIndexProvider.updateSelectedIndex(14);
                    Navigator.pop(context);
                  },
                  botonGuardar: () async {
                    try {
                      validateAndSetErrors();

                      if (descripError.isEmpty) {
                        // Llamar a la funcion del provider
                        String? token = await tokenProvider.verificarTokenU();
                        if (token != null) {
                          int? statusCode =
                              await authController.registrarPlanTareasU(token);

                          if (statusCode == 200) {
                            showDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                      title: '¡Perfecto!',
                                      message:
                                          'Se registro exitosamente el plan',
                                      onPressed: () {
                                        selectedIndexProvider
                                            .updateSelectedIndex(8);

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
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: size.width * 0.26),
              
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tab(texto: 'Activo', number: '1', disabled: false,),
                  Text("_______________"),
                  Tab(texto: 'Tarea', number: '2', disabled: true,),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.575,
              width: size.width,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    // Actualiza la página actual
                    currentPage = index;
                  });
                },
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      
                      
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                clipBehavior: Clip.hardEdge,
                                child: Form(
                                    child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: tFormHeight - 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Formulario(
                                        controller:
                                            authController.descTareaController,
                                        nombreError: descripError.isNotEmpty
                                            ? descripError
                                            : null,
                                        errorStyle: errorStyle,
                                        texto: "Activo",
                                        icono: const Icon(
                                            Icons.description_outlined),
                                      ),
                                      const SizedBox(
                                        height: tFormHeight,
                                      ),
                                      Formulario(
                                        controller: authController
                                            .asociadasTareasController,
                                        nombreError: null,
                                        errorStyle: errorStyle,
                                        texto: "Duracion Estimada",
                                        icono: const Icon(Icons.list_alt_sharp),
                                        enabled: false,
                                      ),
                                      const SizedBox(
                                        height: tFormHeight,
                                      ),
                                      Formulario(
                                        controller: authController
                                            .activosVinculadosTareaController,
                                        nombreError: null,
                                        errorStyle: errorStyle,
                                        texto: "Activos Vinculados",
                                        icono: const Icon(
                                            Icons.library_add_check_rounded),
                                        permitirSoloNumeros:
                                            TextInputType.number,
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            )
                          ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab extends StatelessWidget {
  const Tab({
    super.key, required this.texto, required this.number, required this.disabled,
  });

  final String texto;
  final String number;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle, color: disabled ? Colors.grey : tPrimaryColor
          ),
          child: Text(number, style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: disabled ? const Color.fromARGB(158, 255, 255, 255)  : const Color.fromARGB(202, 255, 255, 255)),),
        ),
        Text(texto, style:  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: disabled ? const Color.fromARGB(76, 0, 0, 0) : const Color.fromARGB(164, 0, 0, 0)),
        )
      ],
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({
    super.key,
    required this.controller,
    required this.nombreError,
    required this.errorStyle,
    required this.texto,
    required this.icono,
    this.permitirSoloNumeros,
    this.maxCaracteres,
    this.enabled,
  });

  final String texto;
  final TextEditingController controller;
  final String? nombreError;
  final TextStyle errorStyle;
  final Icon icono;
  final TextInputType? permitirSoloNumeros;
  final int? maxCaracteres;
  final bool? enabled;

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.icono,
          labelText: widget.texto,
          hintText: widget.texto,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          errorText: widget.nombreError,
          errorStyle: widget.errorStyle,
          border: const OutlineInputBorder()),
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxCaracteres),
      ],
      keyboardType: widget.permitirSoloNumeros,
      enabled: widget.enabled,
    );
  }
}
