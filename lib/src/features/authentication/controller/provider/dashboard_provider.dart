import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_general.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/perfil/perfil_widget.dart';
import '../../screens/dashboard/activos/activos_widget.dart';

class SelectedDashboardProvider extends ChangeNotifier {

  late Activos _selectedActivo;

  Activos get selectedActivo => _selectedActivo;

  void updateSelectedActivo(Activos activo){
    _selectedActivo = activo;
    notifyListeners();
  }

  late ActivoPlaca _selectedActivoxPlaca;

  ActivoPlaca get selectedActivoxPlaca => _selectedActivoxPlaca;

  void updateSelectedActivoxPlaca(ActivoPlaca activo){
    _selectedActivoxPlaca = activo;
    notifyListeners();
  }

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
      default:
        return '';
    }
  }

}
