import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/planes_mantenimiento.dart';
import 'package:mantrack_app/src/features/authentication/model/tareas_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_general.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
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


  // Index para manejo de vistas en el dashboard

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return Text('Index 0: Home');
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
      default:
        return '';
    }
  }

}
