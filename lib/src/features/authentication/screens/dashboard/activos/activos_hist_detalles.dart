import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/activos_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class HistorialesDetalles extends StatefulWidget {
  const HistorialesDetalles({
    super.key,
  });

  @override
  State<HistorialesDetalles> createState() => _HistorialesDetallesState();
}

class _HistorialesDetallesState extends State<HistorialesDetalles> {
  AuthController authController = AuthController();

  ActivosProvider activosProvider = ActivosProvider();

  final controller = PageController();

  int currentPage = 0;

  bool statePage = false;

  bool validateBoton = true;

  stateChanged() {
    setState(() {
      statePage = !statePage;
    });
  }

  stateChecked() {
    setState(() {
      validateBoton = !validateBoton;
    });
  }

  late TokenProvider tokenProvider;
  late List<String> opciones;
  late String? token;
  late Map<String, dynamic> tokenw;
  late String email;
  late String name;
  late String lastname;
  late Uint8List? imagen;
  late NetworkImage imagenCargada;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Inicializar las opciones obtenidas de fetchActivos

  }


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

      TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

          authController.idOTsController.text =
        selectedIndexProvider.selectedOTs.id_ordenTrabajo.toString();

          authController.descOTsController.text =
        selectedIndexProvider.selectedOTs.descripcion;

    String tipoMantenimiento = selectedIndexProvider.selectedOTs.tipoMantenimiento.toLowerCase();
    String tipoMantenimientoCapitalizado =
        tipoMantenimiento.substring(0, 1).toUpperCase() +
            tipoMantenimiento.substring(1);

          authController.tipoOTsController.text = tipoMantenimientoCapitalizado;

          // Convertir la cadena de fecha a DateTime
    DateTime fecha = DateTime.parse(selectedIndexProvider.selectedOTs.fechaRealizacion);

    // Formatear la fecha y el tiempo por separado
    String fechaFormateada = DateFormat('yyyy-MM-dd').format(fecha);

                    authController.fechaRealizacionOTsController.text =
        fechaFormateada;

        

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: 
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white),
                child: HeaderSave(
                    size: size,
                    titulo: "Historial del Activo",
                    disabled: validateBoton,
                    flechaAtras: () {
                      selectedIndexProvider.updateSelectedIndex(19);
                      Navigator.pop(context);
                    },),
              ),

              SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Formulario(
                        controller:
                            authController.idOTsController,
                        nombreError:
                            null,
                        errorStyle: errorStyle,
                        texto: "Orden de Trabajo",
                        enabled: false,
                        icono: const Icon(Icons.numbers_rounded),
                        
                      ),
                      const SizedBox(
                        height: tFormHeight,
                      ),
                      Formulario(
                        controller:
                            authController.descOTsController,
                        nombreError:
                            null,
                        errorStyle: errorStyle,
                        texto: "Descripcion",
                        enabled: false,
                        icono: const Icon(Icons.token_outlined),
                        
                      ),
                      const SizedBox(
                        height: tFormHeight,
                      ),
                      Formulario(
                        controller: authController.tipoOTsController,
                        nombreError: null,
                        errorStyle: errorStyle,
                        texto: "Tiempo de tarea",
                        enabled: false,
                        icono: const Icon(Icons.handyman_outlined),
                      ),
                      const SizedBox(
                        height: tFormHeight,
                      ),
                      Formulario(
                        controller: authController.fechaRealizacionOTsController,
                        nombreError: null,
                        errorStyle: errorStyle,
                        texto: "Fecha de Realizacion",
                        icono: const Icon(Icons.date_range_outlined),
                        enabled: false,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
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
