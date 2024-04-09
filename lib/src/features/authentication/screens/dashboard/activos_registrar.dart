import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivosRegistrar extends StatefulWidget {
  const ActivosRegistrar({
    super.key,
  });

  @override
  State<ActivosRegistrar> createState() => _ActivosRegistrarState();
}

class _ActivosRegistrarState extends State<ActivosRegistrar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final tokenProvider = Provider.of<TokenProvider>(context);

    AuthController authController = AuthController();

    String idvehicuError = "";
    String marcaVehiError = "";
    String modeloVehiError = "";
    String lineaVehiError = "";
    String colorVehiError = "";
    String capacidadVehiError = "";
    String claseVehiError = "";
    String cilindrajeVehiError = "";
    String tipoCombustibleVehiemailError = "";
    String numeroMotorError = "";
    String numeroChasisError = "";
    String vinVehiError = "";
    String ciudadRegristroVehiError = "";
    String fechaMatriculoVehiError = "";

    TextStyle errorStyle = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

    return Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.88,
        width: size.width * 0.95,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
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
                  width: 10,
                ),
                const Text(
                  "General",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                )
              ],
            ),
          ),
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
                      controller: authController.idvehicuController,
                      nombreError: idvehicuError,
                      errorStyle: errorStyle,
                      texto: "Placa Vehicular",
                      icono: const Icon(Icons.pin),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.marcaVehiController,
                      nombreError: marcaVehiError,
                      errorStyle: errorStyle,
                      texto: "Marca",
                      icono: const Icon(Icons.brightness_auto_rounded),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.modeloVehiController,
                      nombreError: modeloVehiError,
                      errorStyle: errorStyle,
                      texto: "Modelo",
                      icono: const Icon(Icons.time_to_leave_rounded),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.lineaVehiController,
                      nombreError: lineaVehiError,
                      errorStyle: errorStyle,
                      texto: "Linea",
                      icono: const Icon(Icons.line_style_sharp),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.colorVehiController,
                      nombreError: colorVehiError,
                      errorStyle: errorStyle,
                      texto: "Color",
                      icono: const Icon(Icons.color_lens_rounded),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.capacidadVehiController,
                      nombreError: capacidadVehiError,
                      errorStyle: errorStyle,
                      texto: "Capacidad",
                      icono: const Icon(Icons.reduce_capacity_rounded),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.claseVehiController,
                      nombreError: claseVehiError,
                      errorStyle: errorStyle,
                      texto: "Clase de Vehiculo",
                      icono: const Icon(Icons.filter_4),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.cilindrajeVehiController,
                      nombreError: cilindrajeVehiError,
                      errorStyle: errorStyle,
                      texto: "Cilindraje",
                      icono: const Icon(Icons.miscellaneous_services_sharp),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller:
                          authController.tipoCombustibleVehiemailController,
                      nombreError: tipoCombustibleVehiemailError,
                      errorStyle: errorStyle,
                      texto: "Tipo Combustible",
                      icono: const Icon(Icons.oil_barrel_outlined),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroMotorController,
                      nombreError: numeroMotorError,
                      errorStyle: errorStyle,
                      texto: "Numero de Motor",
                      icono: const Icon(Icons.numbers),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroChasisController,
                      nombreError: numeroChasisError,
                      errorStyle: errorStyle,
                      texto: "Numero de Chasis",
                      icono: const Icon(Icons.numbers),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.vinVehiController,
                      nombreError: vinVehiError,
                      errorStyle: errorStyle,
                      texto: "Vin",
                      icono: const Icon(Icons.library_books_outlined),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.ciudadRegristroVehiController,
                      nombreError: ciudadRegristroVehiError,
                      errorStyle: errorStyle,
                      texto: "Ciudad de Registro",
                      icono: const Icon(Icons.location_city_rounded),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodySmall,
                      controller: authController.fechaMatriculoVehiController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today),
                        labelText: "Fecha de Matricula",
                        hintText: "Fecha de Matricula",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        errorText: fechaMatriculoVehiError.isNotEmpty
                            ? fechaMatriculoVehiError
                            : null,
                        errorStyle: errorStyle,
                        border: const OutlineInputBorder(),
                      ),
                      // onTap: () async {
                      //   DateTime? pickedDate = await showDatePicker(
                      //     context: context,
                      //     initialDate: DateTime.now(),
                      //     firstDate: DateTime(1900),
                      //     lastDate: DateTime.now(),
                      //   );
                      //   if (pickedDate != null) {
                      //     setState(() {
                      //       authController.fechaMatriculoVehiController.text =
                      //           DateFormat('yyyy-MM-dd').format(pickedDate);
                      //     });
                      //   }
                      // },
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              // Llamar a la funcion del provider
                              String? token =
                                  await tokenProvider.verificarTokenU();
                              if (token != null) {
                                int? statusCode = await authController.registrarActivoU(token);

                                if (statusCode == 200) {
                                  showDialog<String>(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                              top: size.height / -13.2,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  color: tPrimaryColor,
                                                ),
                                                width: 332,
                                                height: 70,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 25),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: tDefaultSize,
                                                ),
                                                const Text(
                                                  '¡Perfecto!',
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: tDefaultSize - 5,
                                                ),
                                                const SizedBox(
                                                    width: 290,
                                                    child: Text(
                                                      'Se registro exitosamente el vehiculo',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black87),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                const SizedBox(
                                                    height: tDefaultSize - 5),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        selectedIndexProvider
                                                            .updateSelectedIndex(
                                                                1);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              tPrimaryColor,
                                                          side: const BorderSide(
                                                              color:
                                                                  tPrimaryColor),
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              vertical:
                                                                  tButtonHeight)),
                                                      child: const Text(
                                                        "OK",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: size.height / -19.4,
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: tPrimaryColor,
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.check_rounded,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              print("Error al registrar usuario: $e");
                              // Manejar otros posibles errores aquí
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: tPrimaryColor,
                              side: const BorderSide(color: tPrimaryColor),
                              padding: const EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: const Text("Registrar")),
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
  });

  final String texto;
  final TextEditingController controller;
  final String nombreError;
  final TextStyle errorStyle;
  final Icon icono;

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
          errorText: widget.nombreError.isNotEmpty ? widget.nombreError : null,
          errorStyle: widget.errorStyle,
          border: const OutlineInputBorder()),
    );
  }
}
