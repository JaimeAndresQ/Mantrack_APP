import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class TareaRegistrar extends StatefulWidget {
  const TareaRegistrar({
    super.key,
  });

  @override
  State<TareaRegistrar> createState() => _TareaRegistrarState();
}

class _TareaRegistrarState extends State<TareaRegistrar> {
  AuthController authController = AuthController();

  String descripError = '';
  String fechaError = '';


  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      descripError = authController.descTareaController.text.isEmpty
          ? 'Ingrese una descripcion del plan'
          : '';
      fechaError = authController.fechaTareaController.text.isEmpty
          ? 'Ingrese una fecha de realizacion'
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
              titulo: "Registrar un Plan",
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
                      int? statusCode = await authController.registrarPlanTareasU(token);

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
                      
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodySmall,
                      controller: authController.fechaTareaController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today),
                        labelText: "Fecha de Realizacion",
                        hintText: "Fecha de Realizacion",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        errorText: fechaError.isNotEmpty
                            ? fechaError
                            : null,
                        errorStyle: errorStyle,
                        border: const OutlineInputBorder(),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            authController.fechaTareaController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
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
                      
                      enabled: false,
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
                      
                      enabled: false,
                      
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
