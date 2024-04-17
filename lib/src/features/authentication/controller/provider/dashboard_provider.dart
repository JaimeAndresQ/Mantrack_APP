import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_detalles.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
import '../../screens/dashboard/activos/activos_widget.dart';

class SelectedDashboardProvider extends ChangeNotifier {

  int _selectedIndex = 0;

  late Activos _selectedActivo;

  Activos get selectedActivo => _selectedActivo;

  void updateSelectedActivo(Activos activo){
    _selectedActivo = activo;
    notifyListeners();
  }

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
      default:
        return Container(); // Puedes devolver un widget vacío o manejar el caso por defecto según tu lógica.
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
      default:
        return '';
    }
  }

  void eliminarToken() {
    // Lógica para eliminar el token, si es necesario
  }
}
