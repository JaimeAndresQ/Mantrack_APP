import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/ordenes_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_registar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/widgets/ordenes_builder.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/widgets/planes_builder.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrdenesWidget extends StatefulWidget {
  const OrdenesWidget({
    super.key,
  });

  @override
  State<OrdenesWidget> createState() => _OrdenesWidgetState();
}

class _OrdenesWidgetState extends State<OrdenesWidget> {
  final controller = PageController();

  int currentPage = 0;

  bool isPressed = false;

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWidget();
  }

  void _initWidget() async {
    await Provider.of<OrdenesProvider>(context, listen: false).fetchOrdenesProceso();
    await Provider.of<OrdenesProvider>(context, listen: false).fetchOrdenesRevision();
    await Provider.of<OrdenesProvider>(context, listen: false).fetchOrdenesFinalizadas();
    _isLoading = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ordenProvider = Provider.of<OrdenesProvider>(context);
    if (_isLoading == true) {
      // Muestra un indicador de carga mientras se obtiene la informacion
      return const Center(
          child: CircularProgressIndicator(
        color: tPrimaryColor,
      ));
    } else {
      return Stack(
        children: [
          SizedBox(
            height: size.height * 0.90,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PageOTS(
                      size: size,
                      color: const Color(0xFFFE5F43),
                      texto: 'Mantenimientos Pendientes (0)',
                      icono: Icons.av_timer_rounded,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PageOTS(
                      size: size,
                      color: const Color(0xFFFEC343),
                      texto:
                          'OTs en Proceso (${ordenProvider.ordenesProceso})',
                      icono: Icons.timeline_rounded,
                    ),
                    SizedBox(
                        height: size.height * 0.80,
                        width: size.width,
                        child: const OrdenTrabajoBuilder(
                          estado: "P",
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PageOTS(
                      size: size,
                      color: tPrimaryColor,
                      texto: 'OTs en Revisión (${ordenProvider.ordenesRevision})',
                      icono: Icons.assignment_outlined,
                    ),
                    SizedBox(
                        height: size.height * 0.80,
                        width: size.width,
                        child: const OrdenTrabajoBuilder(
                          estado: "R",
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PageOTS(
                      size: size,
                      color: const Color.fromARGB(255, 67, 254, 98),
                      texto: 'OTs Finalizadas (${ordenProvider.ordenesFinalizadas})',
                      icono: Icons.check_circle_outlined,
                    ),
                    SizedBox(
                        height: size.height * 0.80,
                        width: size.width,
                        child: const OrdenTrabajoBuilder(
                          estado: "F",
                        )),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: size.width / 2.325,
              child: AnimatedSmoothIndicator(
                activeIndex: currentPage,
                count: 4,
                effect: const WormEffect(
                  activeDotColor: tPrimaryColor,
                  dotHeight: 9,
                  dotWidth: 9,
                ),
              )),
          Positioned(
            right: tDefaultSize - 5,
            bottom: tDefaultSize - 5,
            child: FloatingActionButton(
              onPressed: () {
                // selectedIndexProvider.updateSelectedIndex(15);
                Get.to(() => const OrdenesRegistrar());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      );
    }
  }

  void onPageChangedCallBack(int activePageIndex) {
    setState(() {
      // Actualiza la página actual
      currentPage = activePageIndex;
    });
  }
}

class PageOTS extends StatelessWidget {
  const PageOTS({
    super.key,
    required this.size,
    required this.color,
    required this.texto,
    required this.icono,
  });

  final Size size;
  final Color color;
  final String texto;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: tDefaultSize - 15,
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.122),
                ),
                child: Icon(
                  icono,
                  size: tDefaultSize - 4,
                  color: color,
                ),
              ),
              const SizedBox(
                width: tDefaultSize - 18,
              ),
              Text(
                texto,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(164, 0, 0, 0)),
              ),
            ],
          )),
    );
  }
}

