import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/planes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/widgets/planes_builder.dart';
import 'package:provider/provider.dart';

class TareasAsociadasBuilder extends StatefulWidget {
  final SelectedDashboardProvider dashboardProvider;
  final isPressed;
  const TareasAsociadasBuilder(
      {super.key, required this.dashboardProvider, this.isPressed});

  @override
  State<TareasAsociadasBuilder> createState() => _TareasAsociadasBuilderState();
}

class _TareasAsociadasBuilderState extends State<TareasAsociadasBuilder> {
  PlanesProvider planesBuilder = PlanesProvider();

  // Actualiza los datos de la api
  Future<void> _refreshData(int idPlan) async {
    // Call a method from another widget (PlanesBuilder) to fetch new data
    // This assumes PlanesBuilder has a method named 'fetchNewPlanData'
    var listaBuilder =
        await planesBuilder.updateMantenimeintosAsociados(idPlan);
    widget.dashboardProvider.updateSelectedPlanMantenimiento(listaBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedDashboardProvider>(
      builder: (context, selectedIndexProvider, child) => RefreshIndicator(
          onRefresh: () {
            return _refreshData(widget.dashboardProvider
                .selectedPlanMantenimiento.idPlanMantenimiento);
          },
          child: ListView.separated(
            itemCount: widget
                .dashboardProvider.selectedPlanMantenimiento.planTareas.length,
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              return TareasAsociadas(
                selectedIndexProvider: widget.dashboardProvider,
                tareasData: widget.dashboardProvider.selectedPlanMantenimiento
                    .planTareas[index],
                index: index,
                isPressed: widget.isPressed,
              );
            },
          )),
    );
  }
}

class TareasAsociadas extends StatefulWidget {
  final PlanMantenimientoTareas tareasData;
  final SelectedDashboardProvider selectedIndexProvider;
  final int index;
  final bool isPressed;
  final dynamic toggleCheck;

  const TareasAsociadas(
      {super.key,
      required this.selectedIndexProvider,
      required this.tareasData,
      required this.index,
      required this.isPressed,
      this.toggleCheck});

  @override
  State<TareasAsociadas> createState() => _TareasAsociadasState();
}

class _TareasAsociadasState extends State<TareasAsociadas> {
  String getCategoriaText(int categoriaValue) {
    switch (categoriaValue) {
      case 1:
        return 'Mantenimiento general';
      case 2:
        return 'Cambio de aceite';
      case 3:
        return 'Reparación de motor';
      default:
        return 'Sin categoría definida';
    }
  }

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);
    final selectedTokenProvider = Provider.of<TokenProvider>(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 0.2,
        ))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Builder con checkbox
                // widget.isPressed es una variable que determina si el builder está activo
                widget.isPressed
                    ? Column(
                        children: [
                          Checkbox(
                            activeColor: tPrimaryColor,
                            value: widget.tareasData.isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.tareasData.isChecked = value!;
                                if (widget.tareasData.isChecked == true) {
                                  // Se guarda los datos del mantenimiento actual
                                  selectedIndexProvider.setMantenimientoDelete(
                                      widget
                                          .selectedIndexProvider
                                          .selectedPlanMantenimiento
                                          .idPlanMantenimiento,
                                      widget.tareasData
                                          .mantenimiento["id_mantenimiento"]);
                                  // Se guarda el estado del check
                                  selectedIndexProvider
                                      .updateChecked(widget.tareasData.isChecked);
                                } else {
                                  // Se guarda el estado del check
                                  selectedIndexProvider
                                      .updateChecked(widget.tareasData.isChecked);
                                }
                              });
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Descripcion: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget
                              .tareasData.mantenimiento['man_descripcion'],
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Duracion estimada: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget
                              .tareasData.mantenimiento['man_duracion_estimada']
                              .toString(),
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Tipo de tarea: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.tareasData
                              .mantenimiento['man_tipo_mantenimiento'],
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Categoria: ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: tPrimaryColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: getCategoriaText(widget
                              .tareasData.mantenimiento['fk_id_categoria']),
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
