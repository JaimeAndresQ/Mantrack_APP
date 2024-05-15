// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/ordenes_trabajo_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_general.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_hist_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_historiales.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/home_screen.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod1.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod2.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod3.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod4.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod5.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod6.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_detalles_vehi.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_registar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_vehi_general.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/ordenes/ordenes_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/perfil/perfil_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_general.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_vinculadas.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/tarea_widget.dart';
import '../../screens/dashboard/activos/activos_widget.dart';

class SelectedDashboardProvider extends ChangeNotifier {

  // Modelo para Activos
  late Activos _selectedActivo;

  Activos get selectedActivo => _selectedActivo;

  void updateSelectedActivo(Activos activo){
    _selectedActivo = activo;
    notifyListeners();
  }

  // Modelo para Activos Especificos con Placa

  late ActivoPlaca _selectedActivoxPlaca;

  ActivoPlaca get selectedActivoxPlaca => _selectedActivoxPlaca;

  void updateSelectedActivoxPlaca(ActivoPlaca activo){
    _selectedActivoxPlaca = activo;
    notifyListeners();
  }

  // Modelo para los Planes de Mantenimiento

  late PlanMantenimiento _selectedPlanManteniento;

  PlanMantenimiento get selectedPlanMantenimiento => _selectedPlanManteniento;

  void updateSelectedPlanMantenimiento(PlanMantenimiento activo){
    _selectedPlanManteniento = activo;
    print("Actualizado ${activo.planTareas.length}");
    notifyListeners();
  }

  // Modelo para los Mantenimientos


  late TareasMantenimiento _selectedMantenimientos;

  TareasMantenimiento get selectedTareaMantenimiento => _selectedMantenimientos;

  void updateSelectedTareasMantenimiento(TareasMantenimiento activo){
    _selectedMantenimientos = activo;
    notifyListeners();
  }




  late DeleteVehiculo _selectedDeleteVehiculo;

  DeleteVehiculo get selectedDeleteVehiculo => _selectedDeleteVehiculo;

  void setVehiculoDelete(int idPlanMantenimiento, String idVehiculo) {
    // Lógica para obtener el plan de mantenimiento según los parámetros
    // Aquí asumimos que tienes una forma de obtener el plan de mantenimiento desde tu backend
    DeleteVehiculo deleteVehiculo = DeleteVehiculo(idPlanMantenimiento: idPlanMantenimiento, idVehiculo: idVehiculo); // Suponiendo que PlanMantenimiento tiene un constructor con estos parámetros
  
    _selectedDeleteVehiculo = deleteVehiculo;
    notifyListeners();
  }

  late DeleteMantenimiento _selectedDeleteMantenimiento;

  DeleteMantenimiento get selectedDeleteMantenimiento => _selectedDeleteMantenimiento;

  void setMantenimientoDelete(int idPlanMantenimiento, int idMantenimiento) {
    // Lógica para obtener el plan de mantenimiento según los parámetros
    // Aquí asumimos que tienes una forma de obtener el plan de mantenimiento desde tu backend
    DeleteMantenimiento planMantenimiento = DeleteMantenimiento(idPlanMantenimiento: idPlanMantenimiento, nombrePlan: idMantenimiento); // Suponiendo que PlanMantenimiento tiene un constructor con estos parámetros
    
    _selectedDeleteMantenimiento = planMantenimiento;
    notifyListeners();
  }

  // Modelo para checkear los mantenimientos

  late bool _isChecked = false;

  bool get selectedChecked => _isChecked;

  void updateChecked(bool check){
    _isChecked = check;
    notifyListeners();
  }

  // Modelo para las Ordenes de Trabajo

  late OrdenTrabajo _selectedOTs;

  OrdenTrabajo get selectedOTs => _selectedOTs;

  void updateSelectedOrdenTrabajo(OrdenTrabajo activo){
    _selectedOTs = activo;
    notifyListeners();
  }

  // Index para manejo de vistas en el dashboard

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Index para manejo de graficas en el dashboard home

  int _selectedIndexIndicador = 0;

  int get selectedIndexIndicador => _selectedIndexIndicador;

  void updateSelectedIndexIndicador(int index) {
    _selectedIndexIndicador = index;
    notifyListeners();
  }

    Widget getSelectedIndicador() {
    switch (_selectedIndexIndicador) {
      case 0:
        return const Column(
                      children: [
                          WidgetMethod1(ultimos_n_dias: 0,),
                          WidgetMethod2(ultimos_n_dias: 0,),
                          WidgetMethod3(ultimos_n_dias: 0,),
                          WidgetMethod4(ultimos_n_dias: 0,),                   
                          WidgetMethod5(ultimos_n_dias: 0,),
                          WidgetMethod6(ultimos_n_dias: 0,),
                        // Agrega más condiciones según sea necesario para otros índices
                      ],
                    );
      case 1:
        return const Column(
                      children: [
                          WidgetMethod1_2(ultimos_n_dias: 7,),
                          WidgetMethod2_2(ultimos_n_dias: 7,),
                          WidgetMethod3_2(ultimos_n_dias: 7,),
                          WidgetMethod4_2(ultimos_n_dias: 7,),                   
                          WidgetMethod5_2(ultimos_n_dias: 7,),
                          WidgetMethod6_2(ultimos_n_dias: 7,),
                        // Agrega más condiciones según sea necesario para otros índices
                      ],
                    );
      case 2:
        return const Column(
                      children: [
                          WidgetMethod1_3(ultimos_n_dias: 30,),
                          WidgetMethod2_3(ultimos_n_dias: 30,),
                          WidgetMethod3_3(ultimos_n_dias: 30,),
                          WidgetMethod4_3(ultimos_n_dias: 30,),                   
                          WidgetMethod5_3(ultimos_n_dias: 30,),
                          WidgetMethod6_3(ultimos_n_dias: 30,),
                        // Agrega más condiciones según sea necesario para otros índices
                      ],
                    );
      case 3:
        return const Column(
                      children: [
                          WidgetMethod1_3(ultimos_n_dias: 90,),
                          WidgetMethod2_3(ultimos_n_dias: 90,),
                          WidgetMethod3_3(ultimos_n_dias: 90,),
                          WidgetMethod4_3(ultimos_n_dias: 90,),                   
                          WidgetMethod5_3(ultimos_n_dias: 90,),
                          WidgetMethod6_3(ultimos_n_dias: 90,),
                        // Agrega más condiciones según sea necesario para otros índices
                      ],
                    );
      
      // case 18:
      //   return OrdenesTrabajoDetallesVehiculo();
      default:
        return Container(); // Puedes devolver un widget vacío o manejar el caso por defecto
    }
  }


  Widget getSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return MantrackHome();
      case 1:
        return ActivosHome();
      case 2:
        return ActivosDetalles();
      case 3:
        return ActivosRegistrar();
      case 4:
        return ActivosGeneral();
      case 7:
        return PerfilScreen();
      case 8:
        return TareaWidget();
      case 9:
        return TareaScreen();
      case 10:
        return TareaRegistrar();
      case 11:
        return TareaMantenimiento();
      case 12:
        return TareaVinculados();
      case 13:
        return TareaGeneral();
      case 14:
        return OrdenesWidget();
      case 15:
        return OrdenesRegistrar();
      case 16:
        return OrdenesDetalles();
      case 17:
        return OrdenesTrabajoDetalles();
      case 18:
        return OrdenesVehiGeneral();
      case 19:
        return ActivosHistorial();
      case 20:
        return HistorialesDetalles();
      // case 18:
      //   return OrdenesTrabajoDetallesVehiculo();
      default:
        return Container(); // Puedes devolver un widget vacío o manejar el caso por defecto
    }
  }


  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Activos';
      case 2:
        return 'Detalles del Activo';
      case 3:
        return 'Registro Activos';
      case 4:
        return 'Activos General';
      case 7:
        return 'Perfil';
      case 8:
        return 'Plan de Tareas';
      case 9:
        return 'Detalles del Plan';
      case 10:
        return 'Registrar un Plan';
      case 11:
        return 'Tareas';
      case 12:
        return 'Vehiculos Asociados';
      case 13:
        return 'Tareas General';
      case 14:
        return 'OTs Kanban';
      case 15:
        return 'OTs Registrar';
      case 16:
        return 'OTs Detalles';
      case 17:
        return 'OTs Activo';
      case 18:
        return 'OTs Activo General';
      case 19:
        return 'Historial del Activo';
      default:
        return '';
    }
  }

}


  class DeleteMantenimiento {
    final int idPlanMantenimiento;
    final int nombrePlan;

    DeleteMantenimiento({
      required this.idPlanMantenimiento,
      required this.nombrePlan,
    });

  // Otros métodos de la clase si es necesario
}
  class DeleteVehiculo {
    final int idPlanMantenimiento;
    final String idVehiculo;

    DeleteVehiculo({
      required this.idPlanMantenimiento,
      required this.idVehiculo,
    });

  // Otros métodos de la clase si es necesario
}