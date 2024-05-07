import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/activos_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_formulario.dart';
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

  String activoOTsError = '';
  String tiempoEstimadoOTsError = '';
  String descripOTsError = '';
  String categoriaOTsError = '';
  String tipoMantenimientoOTsError = '';
  

  TextStyle errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  void validateAndSetErrorsActivos() {
    setState(() {
      activoOTsError = authController.activoOTsController.text.isEmpty
          ? 'Elija un activo'
          : '';
      tiempoEstimadoOTsError =
          authController.tiempoEstimadoOTsController.text.isEmpty
              ? 'Ingrese un tiempo de duracion estimado'
              : '';
    });
  }

  void validateAndSetErrorsTareas() {
    setState(() {
      descripOTsError =
          authController.descOTsController.text.isEmpty
              ? 'Ingrese una descripcion de la OTs'
              : '';
      categoriaOTsError =
          authController.categoriaOTsController.text.isEmpty
              ? 'Ingrese un categoria de mantenimiento'
              : '';
      tipoMantenimientoOTsError =
          authController.tipoOTsController.text.isEmpty
              ? 'Ingrese un tipo de mantenimiento'
              : '';
    });
  }

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
    _initWidget();

  }

  void _initWidget() async {
    await activosProvider.fetchActivos().then((_) {
      setState(() {
        opciones = activosProvider.opcionesActivos;
        _isLoading = false;
      });
    });
    tokenProvider = TokenProvider();
    try {
      token = await tokenProvider.verificarTokenU();
      if (token != null) {
        tokenw = JwtDecoder.decode(token!);
        email = tokenw['correo'];
        name = tokenw['nombres'];
        lastname = tokenw['apellidos'];
      }
    } catch (e) {
      // Manejar excepciones
      Exception('Error al obtener el token: $e');
    }
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


    if (_isLoading == true) {
      // Muestra un indicador de carga mientras se obtiene el token
      return const SafeArea(
        child: Scaffold(
          body: Center(child: CircularProgressIndicator(color: tPrimaryColor,)),
        ),
      );
    } else {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
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
                    titulo: "Tarea no Programada",
                    disabled: validateBoton,
                    flechaAtras: () {
                      selectedIndexProvider.updateSelectedIndex(14);
                      Navigator.pop(context);
                    },
                    botonGuardar: () async {
                      
                      validateAndSetErrorsTareas();
                      try {
                        if (activoOTsError.isEmpty && tiempoEstimadoOTsError.isEmpty && descripOTsError.isEmpty
                        && categoriaOTsError.isEmpty && tipoMantenimientoOTsError.isEmpty) {
                          // Llamar a la funcion del provider
                          String? token = await tokenProvider.verificarTokenU();
                          

                          if (token != null) {
                            int? statusCode = await authController.registrarOrdenTrabajoU(token, email);

                            if (statusCode == 200) {
                              showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                        title: '¡Perfecto!',
                                        message:
                                            'Se registro exitosamente la OTs',
                                        onPressed: () {
                                          selectedIndexProvider
                                              .updateSelectedIndex(14);
                                          
                                          // Salir del Modal
                                          Navigator.pop(context);
                                          // Salir de la creacion
                                          Navigator.pop(context);
                                        },
                                      ));
                            } else if (statusCode == 404){
                              showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                        title: '¡Error!',
                                        error: true,
                                        message:
                                            'Vehiculo/Usuario que se asocia la orden no existe',
                                        onPressed: () {
                                          
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
                margin: EdgeInsets.symmetric(
                    vertical: 8, horizontal: size.width * 0.26),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tab(
                      texto: 'Activo',
                      number: '1',
                      disabled: statePage,
                    ),
                    const Text("_______________"),
                    Tab(
                      texto: 'Tarea',
                      number: '2',
                      disabled: !statePage,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.8,
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
                    PageActivo(
                      authController: authController,
                      activoOTsError: activoOTsError,
                      tiempoEstimadoOTsError: tiempoEstimadoOTsError,
                      errorStyle: errorStyle,
                      size: size,
                      pageController: controller,
                      ordenesRegistrarState: this,
                    ),
                    PageTarea(
                      authController: authController,
                      descripError: descripOTsError,
                      categoriaError: categoriaOTsError,
                      tipoManError: tipoMantenimientoOTsError,
                      errorStyle: errorStyle,
                      size: size,
                      pageController: controller,
                      ordenesRegistrarState: this,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
    }
  }
}

class PageTarea extends StatelessWidget {
  const PageTarea({
    super.key,
    required this.authController,
    required this.descripError,
    required this.categoriaError,
    required this.tipoManError,
    required this.errorStyle,
    required this.size,
    required this.pageController,
    required this.ordenesRegistrarState,
  });

  final AuthController authController;
  final String descripError;
  final String categoriaError;
  final String tipoManError;
  final TextStyle errorStyle;
  final Size size;
  final PageController pageController;
  final _OrdenesRegistrarState ordenesRegistrarState;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      controller: authController.descOTsController,
                      nombreError:
                          descripError.isNotEmpty ? descripError : null,
                      errorStyle: errorStyle,
                      texto: "Descripcion",
                      icono: const Icon(Icons.token_outlined),
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
                      controller:
                          authController.categoriaOTsController,
                      nombreError:
                          categoriaError.isNotEmpty ? categoriaError : null,
                      errorStyle: errorStyle,
                      texto: "Categoria del Mantenimiento",
                      icono: const Icon(Icons.type_specimen_outlined),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    FormularioSelect(
                      opciones: const ["Preventivo", "Correctivo"],
                      controller: authController.tipoOTsController,
                      nombreError:
                           tipoManError.isNotEmpty ? tipoManError : null,
                      errorStyle: errorStyle,
                      texto: "Tipo de Mantenimiento",
                      icono: const Icon(Icons.handyman_outlined),
                    ),
                    if (ordenesRegistrarState.descripOTsError.isEmpty && ordenesRegistrarState.categoriaOTsError.isEmpty 
                    && ordenesRegistrarState.tipoMantenimientoOTsError.isEmpty)
                      SizedBox(
                        height: size.height * 0.39,
                      )
                    else 
                      SizedBox(
                        height: size.height * 0.305,
                      ),
                    SizedBox(
                      width: size.width * 0.225,
                      child: OutlinedButton(
                          onPressed: () {
                            ordenesRegistrarState.stateChanged();
                            ordenesRegistrarState.stateChecked();
                            pageController.animateToPage(0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          },
                          style: OutlinedButton.styleFrom(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              side: const BorderSide(
                                color: tPrimaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 13,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "ATRAS",
                                style: TextStyle(color: tPrimaryColor),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              )),
            ),
          )
        ]));
  }
}

class PageActivo extends StatelessWidget {
  const PageActivo({
    super.key,
    required this.authController,
    required this.activoOTsError,
    required this.tiempoEstimadoOTsError,
    required this.errorStyle,
    required this.size,
    required this.pageController,
    required this.ordenesRegistrarState,
  });

  final AuthController authController;
  final String activoOTsError;
  final String tiempoEstimadoOTsError;
  final TextStyle errorStyle;
  final Size size;
  final PageController pageController;
  final _OrdenesRegistrarState ordenesRegistrarState;

  @override
  Widget build(BuildContext context) {
    
    authController.encargadoOTsController.text = "${ordenesRegistrarState.name} ${ordenesRegistrarState.lastname}";

    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Form(
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    FormularioSelect(
                      opciones: ordenesRegistrarState.opciones,
                      controller:
                          authController.activoOTsController,
                      nombreError:
                          activoOTsError.isNotEmpty ? activoOTsError : null,
                      errorStyle: errorStyle,
                      texto: "Activo",
                      icono: const Icon(Icons.type_specimen_outlined),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller: authController.tiempoEstimadoOTsController,
                      nombreError: tiempoEstimadoOTsError.isNotEmpty ? tiempoEstimadoOTsError : null,
                      errorStyle: errorStyle,
                      texto: "Tiempo Estimado",
                      permitirSoloNumeros: TextInputType.number,
                      icono: const Icon(Icons.access_time_outlined),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    Formulario(
                      controller:
                          authController.encargadoOTsController,
                      nombreError: null,
                      errorStyle: errorStyle,
                      texto: "Solicitado Por",
                      icono: const Icon(Icons.person_add_alt_1_outlined),
                      permitirSoloNumeros: TextInputType.number,
                      enabled: false,
                    ),
                    if (ordenesRegistrarState.activoOTsError.isEmpty && ordenesRegistrarState.tiempoEstimadoOTsError.isEmpty)
                      SizedBox(
                        height: size.height * 0.39,
                      )
                    else 
                      SizedBox(
                        height: size.height * 0.335,
                      ),
                    
                    SizedBox(
                      width: size.width * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            ordenesRegistrarState.validateAndSetErrorsActivos();
                            if (ordenesRegistrarState.activoOTsError.isEmpty &&
                                ordenesRegistrarState
                                    .tiempoEstimadoOTsError.isEmpty) {
                              ordenesRegistrarState.stateChanged();
                              ordenesRegistrarState.stateChecked();
                              pageController.animateToPage(1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              backgroundColor: tPrimaryColor,
                              side: const BorderSide(
                                color: tPrimaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("SIGUIENTE"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 13,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              )),
            ),
          )
        ]));
  }
}

class Tab extends StatelessWidget {
  const Tab({
    super.key,
    required this.texto,
    required this.number,
    required this.disabled,
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
              shape: BoxShape.circle,
              color: disabled ? Colors.grey : tPrimaryColor),
          child: Text(
            number,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: disabled
                    ? const Color.fromARGB(158, 255, 255, 255)
                    : const Color.fromARGB(202, 255, 255, 255)),
          ),
        ),
        Text(
          texto,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: disabled
                  ? const Color.fromARGB(76, 0, 0, 0)
                  : const Color.fromARGB(164, 0, 0, 0)),
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
