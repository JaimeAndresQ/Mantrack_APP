import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class TareaGeneral extends StatefulWidget {
  const TareaGeneral({
    super.key,
  });

  @override
  State<TareaGeneral> createState() => _TareaGeneralState();
}

class _TareaGeneralState extends State<TareaGeneral> {
  AuthController authController = AuthController();

  String descripError = '';


  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      descripError = authController.idvehicuController.text.isEmpty
          ? 'Ingrese una descripcion del plan'
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final tokenProvider = Provider.of<TokenProvider>(context);

    authController.asociadasTareasController.text = "0";
    authController.activosVinculadosTareaController.text = "0";

    return Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.88,
        width: size.width * 0.95,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          HeaderSave(
              size: size,
              titulo: "General Registro",
              flechaAtras: () {
                selectedIndexProvider.updateSelectedIndex(8);
              },
              botonGuardar: () async {
                try {
                  validateAndSetErrors();

                  if (descripError.isEmpty) {
                    // Llamar a la funcion del provider
                    String? token = await tokenProvider.verificarTokenU();
                    if (token != null) {
                      int? statusCode =
                          await authController.registrarActivoU(token);

                      if (statusCode == 200) {
                        showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) => CustomDialog(
                                  title: '¡Perfecto!',
                                  message:
                                      'Se registro exitosamente el vehiculo',
                                  onPressed: () {
                                    selectedIndexProvider
                                        .updateSelectedIndex(1);

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
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Form(
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Formulario(
                      controller: authController.descTareaController,
                      nombreError:
                          descripError.isNotEmpty ? descripError : null,
                      errorStyle: errorStyle,
                      texto: "Descripcion",
                      icono: const Icon(Icons.description_outlined),
                      maxCaracteres: 6,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.asociadasTareasController,
                      nombreError:
                          null,
                      errorStyle: errorStyle,
                      texto: "Tareas asociadas",
                      icono: const Icon(Icons.list_alt_sharp),
                      maxCaracteres: 10,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.activosVinculadosTareaController,
                      nombreError:
                          null,
                      errorStyle: errorStyle,
                      texto: "Activos Vinculados",
                      icono: const Icon(Icons.library_add_check_rounded),
                      permitirSoloNumeros: TextInputType.number,
                      maxCaracteres: 4,
                      
                    ),
                    
                    
                    
                  ],
                ),
              )),
            ),
          )
        ]));
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
  });

  final String texto;
  final TextEditingController controller;
  final String? nombreError;
  final TextStyle errorStyle;
  final Icon icono;
  final TextInputType? permitirSoloNumeros;
  final int? maxCaracteres;

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
    );
  }
}
