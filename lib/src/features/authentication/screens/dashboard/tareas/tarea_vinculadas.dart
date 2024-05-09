import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/planes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/widgets/activosAsociados_builder.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/widgets/vehiculos_builder.dart';
import 'package:provider/provider.dart';

class TareaVinculados extends StatefulWidget {
  TareaVinculados({Key? key}) : super(key: key);

  @override
  State<TareaVinculados> createState() => _TareaVinculadoState();
}

class _TareaVinculadoState extends State<TareaVinculados> {
  bool isPressed = false;

  PlanesProvider planesBuilder = PlanesProvider();
  AuthController authController = AuthController();
  
  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);
    final tokenProvider =
        Provider.of<TokenProvider>(context);

    final size = MediaQuery.of(context).size;

      refreshMantenimientos(int idPlan) async {
      var listaBuilder =
          await planesBuilder.updateMantenimeintosAsociados(idPlan);
      selectedIndexProvider.updateSelectedPlanMantenimiento(listaBuilder);
    }

    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            height: size.height * 0.88,
            width: size.width * 0.95,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.2))),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            selectedIndexProvider.updateSelectedIndex(9);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined,
                              color: tPrimaryColor, size: 28),
                        ),
                        const SizedBox(
                          width: 15.5,
                        ),
                        const Expanded(
                          child: Text(
                            "Activos Vinculados",
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                },
                                child: Icon(Icons.edit, color: isPressed ? tPrimaryColor : Colors.black,)),
                          ),
                        ),
                        selectedIndexProvider
                                .selectedChecked // Mostrar el icono de guardar solo si el checkbox está marcado
                            ? IconButton(
                                icon: const Icon(Icons.save),
                                onPressed: () async {
                                  // Lógica para guardar los datos usando el provider
                                  String idVehiculo = selectedIndexProvider
                                      .selectedDeleteVehiculo
                                      .idVehiculo;
                                  int idPlan = selectedIndexProvider
                                      .selectedDeleteVehiculo.idPlanMantenimiento;
                                  // Llama al método deleteMantenimientoAsociadoU
                                  String? tokenActual =
                                      await tokenProvider.verificarTokenU();
                                  if (tokenActual != null) {
                                    int? statusCode = await authController
                                        .deleteActivoAsociadoU(
                                            tokenActual,
                                            idPlan,
                                            idVehiculo);
                                    if (statusCode == 200) {
                                      showDialog(
                                          // ignore: use_build_context_synchronously
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                                title: '¡Perfecto!',
                                                message:
                                                    '¡Se creó elimino el activo asociado!',
                                                onPressed: () async {
                                                  selectedIndexProvider.updateChecked(false);
                                                  refreshMantenimientos(
                                                      idPlan);
                                                  // Cerrar el diálogo
                                                  Navigator.pop(context);
                                                },
                                              ));
                                    } else {
                                      showDialog(
                                          // ignore: use_build_context_synchronously
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                                title: '¡Error!',
                                                error: true,
                                                message:
                                                    '¡No se pudo eliminar el activo asociado!',
                                                onPressed: () {
                                                  // Cerrar el diálogo
                                                  Navigator.pop(context);
                                                },
                                              ));
                                    }
                                  }
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: size.height * 0.76,
                      width: size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ActivosAsociadasBuilder(
                          isPressed: isPressed,
                          dashboardProvider: selectedIndexProvider,
                        ),
                      ))
                ])),
        Positioned(
          right: tDefaultSize - 5,
          bottom: tDefaultSize - 5,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                builder: (BuildContext context) {
                  return const DrawerActivosNoAsociadas(

                  );
                },
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}


class DrawerActivosNoAsociadas extends StatefulWidget {
  const DrawerActivosNoAsociadas({
    super.key,
  });

  @override
  State<DrawerActivosNoAsociadas> createState() => _DrawerActivosNoAsociadasState();
}

class _DrawerActivosNoAsociadasState extends State<DrawerActivosNoAsociadas> {
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedDashboardProvider = Provider.of<SelectedDashboardProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: size.height * 0.45,
        child: Drawer(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.88,
                width: size.width * 0.95,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderSave(
                        size: size,
                        titulo: "Activos no Asociados",
                        flechaAtras: () {
                          Navigator.pop(context);
                        },

  
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                        height: size.height * 0.33,
                        width: size.width * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivosNoAsociadosBuilder(
                            idplan: selectedDashboardProvider.selectedPlanMantenimiento.idPlanMantenimiento,
                          ),
                        )),
                      )
                      
                    ]))),
      ),
    );
  }
}