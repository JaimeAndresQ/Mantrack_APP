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
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_formulario.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class OrdenesVehiGeneral extends StatefulWidget {
  const OrdenesVehiGeneral({
    super.key,
  });

  @override
  State<OrdenesVehiGeneral> createState() => _OrdenesVehiGeneralState();
}

class _OrdenesVehiGeneralState extends State<OrdenesVehiGeneral> {
  AuthController authController = AuthController();


  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final selectedTokenProvider = Provider.of<TokenProvider>(context);

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
              selectedIndexProvider.updateSelectedIndex(17);
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

                    Formulario(
                      controller: authController.idvehicuController,
                      nombreError:
                           null,
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
                          null,
                      errorStyle: errorStyle,
                      texto: "Marca",
                      icono: const Icon(Icons.brightness_auto_rounded),
                      maxCaracteres: 10,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.modeloVehiController,
                      nombreError:
                          null,
                      errorStyle: errorStyle,
                      texto: "Modelo",
                      icono: const Icon(Icons.time_to_leave_rounded),
                      permitirSoloNumeros: TextInputType.number,
                      maxCaracteres: 4,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.lineaVehiController,
                      nombreError:
                          null,
                      errorStyle: errorStyle,
                      texto: "Linea",
                      icono: const Icon(Icons.line_style_sharp),
                      maxCaracteres: 20,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.colorVehiController,
                      nombreError:
                           null,
                      errorStyle: errorStyle,
                      texto: "Color",
                      icono: const Icon(Icons.color_lens_rounded),
                      maxCaracteres: 45,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.capacidadVehiController,
                      nombreError: null,
                      errorStyle: errorStyle,
                      texto: "Capacidad",
                      icono: const Icon(Icons.reduce_capacity_rounded),
                      maxCaracteres: 45,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.claseVehiController,
                      nombreError:
                           null,
                      errorStyle: errorStyle,
                      texto: "Clase de Vehiculo",
                      icono: const Icon(Icons.filter_4),
                      maxCaracteres: 60,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.cilindrajeVehiController,
                      nombreError:  null,
                      errorStyle: errorStyle,
                      texto: "Cilindraje",
                      icono: const Icon(Icons.miscellaneous_services_sharp),
                      permitirSoloNumeros: TextInputType.number,
                      maxCaracteres: 5,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller:
                          authController.tipoCombustibleVehiemailController,
                      nombreError:  null,
                      errorStyle: errorStyle,
                      texto: "Tipo Combustible",
                      icono: const Icon(Icons.oil_barrel_outlined),
                      maxCaracteres: 20,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroMotorController,
                      nombreError:
                           null,
                      errorStyle: errorStyle,
                      texto: "Numero de Motor",
                      icono: const Icon(Icons.numbers),
                      maxCaracteres: 20,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.numeroChasisController,
                      nombreError:  null,
                      errorStyle: errorStyle,
                      texto: "Numero de Chasis",
                      icono: const Icon(Icons.numbers),
                      maxCaracteres: 30,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.vinVehiController,
                      nombreError:
                           null,
                      errorStyle: errorStyle,
                      texto: "Vin",
                      icono: const Icon(Icons.library_books_outlined),
                      maxCaracteres: 30,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.ciudadRegristroVehiController,
                      nombreError: null,
                      errorStyle: errorStyle,
                      texto: "Ciudad de Registro",
                      icono: const Icon(Icons.location_city_rounded),
                      maxCaracteres: 30,
                      enabled: false,
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
                        errorText: null,
                        errorStyle: errorStyle,
                        border: const OutlineInputBorder(),
                      ),
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
