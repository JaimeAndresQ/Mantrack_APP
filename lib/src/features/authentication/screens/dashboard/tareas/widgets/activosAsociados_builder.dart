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

class ActivosAsociadasBuilder extends StatefulWidget {
  final SelectedDashboardProvider dashboardProvider;
  final isPressed;
  const ActivosAsociadasBuilder(
      {super.key, required this.dashboardProvider, this.isPressed});

  @override
  State<ActivosAsociadasBuilder> createState() =>
      _ActivosAsociadasBuilderState();
}

class _ActivosAsociadasBuilderState extends State<ActivosAsociadasBuilder> {
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
            itemCount: widget.dashboardProvider.selectedPlanMantenimiento
                .planVehiculos.length,
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              return MyActivosAsociados(
                selectedIndexProvider: widget.dashboardProvider,
                activoData: widget.dashboardProvider.selectedPlanMantenimiento
                    .planVehiculos[index],
                index: index,
                isPressed: widget.isPressed,
              );
            },
          )),
    );
  }
}

class MyActivosAsociados extends StatefulWidget {
  final PlanMantenimientoVehiculos activoData;
  final SelectedDashboardProvider selectedIndexProvider;
  final int index;
  final bool isPressed;

  const MyActivosAsociados({
    super.key,
    required this.selectedIndexProvider,
    required this.activoData,
    required this.index,
    required this.isPressed,
  });

  @override
  State<MyActivosAsociados> createState() => _MyActivosAsociadosState();
}

class _MyActivosAsociadosState extends State<MyActivosAsociados> {
  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

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
            Column(
              children: [
                widget.isPressed
                    ? Column(
                        children: [
                          Checkbox(
                              activeColor: tPrimaryColor,
                              value: widget.activoData.isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.activoData.isChecked = value!;
                                  if (widget.activoData.isChecked == true) {
                                    // Se guarda los datos del mantenimiento actual
                                    selectedIndexProvider.setVehiculoDelete(
                                        widget
                                            .selectedIndexProvider
                                            .selectedPlanMantenimiento
                                            .idPlanMantenimiento,
                                        widget.activoData.id_vehiculo);
                                    // Se guarda el estado del check
                                    selectedIndexProvider
                                        .updateChecked(widget.activoData.isChecked);
                                  } else {
                                    // Se guarda el estado del check
                                    selectedIndexProvider
                                        .updateChecked(widget.activoData.isChecked);
                                  }
                                });
                              })
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.activoData.id_vehiculo,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                Text(
                  "// ${widget.activoData.vehiculo['veh_marca']} ${widget.activoData.vehiculo['veh_linea']} ${widget.activoData.vehiculo['veh_modelo']}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
