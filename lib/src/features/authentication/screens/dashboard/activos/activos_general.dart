import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class ActivosGeneral extends StatefulWidget {
  const ActivosGeneral({
    super.key,
  });

  @override
  State<ActivosGeneral> createState() => _ActivosGeneralState();
}

class _ActivosGeneralState extends State<ActivosGeneral> {
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

    File? _imgFile;

    void takeSnapshot() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() {
        _imgFile =
            File(result.files.single.path!); // convert it to a Dart:io file
      });
    }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final selectedTokenProvider = Provider.of<TokenProvider>(context);

    // final tokenProvider = Provider.of<TokenProvider>(context);

    authController.idvehicuController.text =
        selectedIndexProvider.selectedActivoxPlaca.id_vehiculo;

    authController.marcaVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.marca;

    authController.modeloVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.modelo.toString();

    authController.lineaVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.linea;

    authController.colorVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.color;

    authController.capacidadVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.capacidad;

    authController.claseVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.clase;

    authController.cilindrajeVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.cilindraje.toString();

    authController.tipoCombustibleVehiemailController.text =
        selectedIndexProvider.selectedActivoxPlaca.combustible;

    authController.numeroMotorController.text =
        selectedIndexProvider.selectedActivoxPlaca.numeroMotor;

    authController.numeroChasisController.text =
        selectedIndexProvider.selectedActivoxPlaca.numeroChasis;

    authController.vinVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.vin;

    authController.ciudadRegristroVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.ciudad_registro;

    authController.fechaMatriculoVehiController.text =
        selectedIndexProvider.selectedActivoxPlaca.fecha_matricula;


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
            titulo: "General",
            flechaAtras: () {
              selectedIndexProvider.updateSelectedIndex(2);
            },
            botonGuardar: () async {
              // Llamar a la funcion del provider
              String? token = await selectedTokenProvider.verificarTokenU();
              if (token != null) {
                int? statusCode =
                    await authController.actualizarActivoU(token, _imgFile);

                if (statusCode == 200) {
                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                            title: '¡Perfecto!',
                            message: 'Se actualizo exitosamente el vehiculo',
                            onPressed: () {
                              selectedIndexProvider.updateSelectedIndex(2);

                              Navigator.pop(context);
                            },
                          ));
                }
              }
            },
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _imgFile == null
                              ? const Text('No hay imagen seleccionado.')
                              : Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    image: _imgFile != null
                                        ? DecorationImage(
                                            image: FileImage(_imgFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: _imgFile == null
                                      ? const Icon(
                                          Icons.person_outline_outlined,
                                          size: 50)
                                      : null, // Icono predeterminado si no hay imagen seleccionada
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              takeSnapshot();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: tPrimaryColor, width: 1.5)),
                                child: const Icon(
                                  Icons.image_search_sharp,
                                  size: 25,
                                  color: tPrimaryColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: tFormHeight - 10,
                    ),
                    Formulario(
                      controller: authController.idvehicuController,
                      nombreError:
                          idvehicuError.isNotEmpty ? idvehicuError : null,
                      errorStyle: errorStyle,
                      texto: "Placa Vehicular",
                      icono: const Icon(Icons.pin),
                      maxCaracteres: 6,
                      enabled: false,
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
                  ],
                ),
              )),
            ),
          )
        ]));
  }
}
