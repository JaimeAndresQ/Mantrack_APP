import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class ActivosRegistrar extends StatefulWidget {
  const ActivosRegistrar({
    super.key,
  });

  @override
  State<ActivosRegistrar> createState() => _ActivosRegistrarState();
}

class _ActivosRegistrarState extends State<ActivosRegistrar> {
  AuthController authController = AuthController();

  String idvehicuError = '';
  String marcaVehiError = '';
  String modeloVehiError = '';
  String lineaVehiError = '';
  String colorVehiError = '';
  String capacidadVehiError = '';
  String claseVehiError = '';
  String cilindrajeVehiError = '';
  String tipoCombustibleVehiemailError = '';
  String numeroMotorError = '';
  String numeroChasisError = '';
  String vinVehiError = '';
  String ciudadRegristroVehiError = '';
  String fechaMatriculoVehiError = '';

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrors() {
    setState(() {
      idvehicuError = authController.idvehicuController.text.isEmpty
          ? 'Ingrese una placa de vehiculo'
          : '';
      marcaVehiError = authController.marcaVehiController.text.isEmpty
          ? 'Ingrese una marca de vehiculo'
          : '';
      modeloVehiError = authController.modeloVehiController.text.isEmpty
          ? 'Ingrese un modelo de vehiculo'
          : '';
      lineaVehiError = authController.lineaVehiController.text.isEmpty
          ? 'Ingrese una linea de vehiculo'
          : '';
      colorVehiError = authController.colorVehiController.text.isEmpty
          ? 'Ingrese un color del vehiculo'
          : '';
      capacidadVehiError = authController.capacidadVehiController.text.isEmpty
          ? 'Ingrese la capacidad de pasajeros'
          : '';
      claseVehiError = authController.claseVehiController.text.isEmpty
          ? 'Ingrese la clase del vehiculo'
          : '';
      cilindrajeVehiError = authController.cilindrajeVehiController.text.isEmpty
          ? 'Ingrese un cilindraje del vehiculo'
          : '';
      tipoCombustibleVehiemailError =
          authController.tipoCombustibleVehiemailController.text.isEmpty
              ? 'Ingrese un tipo de combustible'
              : '';
      numeroMotorError = authController.numeroMotorController.text.isEmpty
          ? 'Ingrese el numero del motor'
          : '';
      numeroChasisError = authController.numeroChasisController.text.isEmpty
          ? 'Ingrese el numero del chasis'
          : '';
      vinVehiError = authController.vinVehiController.text.isEmpty
          ? 'Ingrese el vin del vehiculo'
          : '';
      ciudadRegristroVehiError =
          authController.ciudadRegristroVehiController.text.isEmpty
              ? 'Ingrese la ciudad de registro del vehiculo'
              : '';
      fechaMatriculoVehiError =
          authController.fechaMatriculoVehiController.text.isEmpty
              ? 'Ingrese la fecha de matricula'
              : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final tokenProvider = Provider.of<TokenProvider>(context);

    return Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.88,
        width: size.width * 0.95,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
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
                  width: 15.5,
                ),
                const Text(
                  "General",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
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
                      nombreError:
                          idvehicuError.isNotEmpty ? idvehicuError : null,
                      errorStyle: errorStyle,
                      texto: "Placa Vehicular",
                      icono: const Icon(Icons.pin),
                      maxCaracteres: 6,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.marcaVehiController,
                      nombreError:
                          marcaVehiError.isNotEmpty ? marcaVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Marca",
                      icono: const Icon(Icons.brightness_auto_rounded),
                      maxCaracteres: 10,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.modeloVehiController,
                      nombreError:
                          modeloVehiError.isNotEmpty ? modeloVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Modelo",
                      icono: const Icon(Icons.time_to_leave_rounded),
                      permitirSoloNumeros: TextInputType.number,
                      maxCaracteres: 4,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.lineaVehiController,
                      nombreError:
                          lineaVehiError.isNotEmpty ? lineaVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Linea",
                      icono: const Icon(Icons.line_style_sharp),
                      maxCaracteres: 20,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.colorVehiController,
                      nombreError:
                          colorVehiError.isNotEmpty ? colorVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Color",
                      icono: const Icon(Icons.color_lens_rounded),
                      maxCaracteres: 45,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.capacidadVehiController,
                      nombreError: capacidadVehiError.isNotEmpty
                          ? capacidadVehiError
                          : null,
                      errorStyle: errorStyle,
                      texto: "Capacidad",
                      icono: const Icon(Icons.reduce_capacity_rounded),
                      maxCaracteres: 45,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.claseVehiController,
                      nombreError:
                          claseVehiError.isNotEmpty ? claseVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Clase de Vehiculo",
                      icono: const Icon(Icons.filter_4),
                      maxCaracteres: 60,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.cilindrajeVehiController,
                      nombreError: cilindrajeVehiError.isNotEmpty
                          ? cilindrajeVehiError
                          : null,
                      errorStyle: errorStyle,
                      texto: "Cilindraje",
                      icono: const Icon(Icons.miscellaneous_services_sharp),
                      permitirSoloNumeros: TextInputType.number,
                      maxCaracteres: 5,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller:
                          authController.tipoCombustibleVehiemailController,
                      nombreError: tipoCombustibleVehiemailError.isNotEmpty
                          ? tipoCombustibleVehiemailError
                          : null,
                      errorStyle: errorStyle,
                      texto: "Tipo Combustible",
                      icono: const Icon(Icons.oil_barrel_outlined),
                      maxCaracteres: 20,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroMotorController,
                      nombreError:
                          numeroMotorError.isNotEmpty ? numeroMotorError : null,
                      errorStyle: errorStyle,
                      texto: "Numero de Motor",
                      icono: const Icon(Icons.numbers),
                      maxCaracteres: 20,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroChasisController,
                      nombreError: numeroChasisError.isNotEmpty
                          ? numeroChasisError
                          : null,
                      errorStyle: errorStyle,
                      texto: "Numero de Chasis",
                      icono: const Icon(Icons.numbers),
                      maxCaracteres: 30,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.vinVehiController,
                      nombreError:
                          vinVehiError.isNotEmpty ? vinVehiError : null,
                      errorStyle: errorStyle,
                      texto: "Vin",
                      icono: const Icon(Icons.library_books_outlined),
                      maxCaracteres: 30,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.ciudadRegristroVehiController,
                      nombreError: ciudadRegristroVehiError.isNotEmpty
                          ? ciudadRegristroVehiError
                          : null,
                      errorStyle: errorStyle,
                      texto: "Ciudad de Registro",
                      icono: const Icon(Icons.location_city_rounded),
                      maxCaracteres: 30,
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
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            authController.fechaMatriculoVehiController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              validateAndSetErrors();

                              if (idvehicuError.isEmpty &&
                                  marcaVehiError.isEmpty &&
                                  modeloVehiError.isEmpty &&
                                  lineaVehiError.isEmpty &&
                                  colorVehiError.isEmpty &&
                                  capacidadVehiError.isEmpty &&
                                  claseVehiError.isEmpty &&
                                  cilindrajeVehiError.isEmpty &&
                                  tipoCombustibleVehiemailError.isEmpty &&
                                  numeroMotorError.isEmpty &&
                                  numeroChasisError.isEmpty &&
                                  vinVehiError.isEmpty &&
                                  ciudadRegristroVehiError.isEmpty &&
                                  fechaMatriculoVehiError.isEmpty) {
                                // Llamar a la funcion del provider
                                String? token =
                                    await tokenProvider.verificarTokenU();
                                if (token != null) {
                                  int? statusCode = await authController
                                      .registrarActivoU(token);

                                  if (statusCode == 200) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomDialog(
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




