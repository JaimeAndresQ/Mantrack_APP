import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos_registrar.dart';
import '../../screens/dashboard/activos_widget.dart';

class SelectedDashboardProvider extends ChangeNotifier {

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
        return Text('Index 2: Recursos Humanos');
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
        return 'Recursos Humanos';
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
