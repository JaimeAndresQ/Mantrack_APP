import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod1.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod2.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod3.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod4.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod5.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod6.dart';
import 'package:provider/provider.dart';

class MantrackHome extends StatefulWidget {
  const MantrackHome({Key? key}) : super(key: key);

  @override
  _MantrackHomeState createState() => _MantrackHomeState();
}

class _MantrackHomeState extends State<MantrackHome> {
  int selectedIndex = 0; // Por defecto seleccionado 'Todos'

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedDashboardProvider = Provider.of<SelectedDashboardProvider>(context);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.height * 0.88,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: selectedDashboardProvider.getSelectedIndicador()
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildOption("Todos", 0, selectedDashboardProvider),
                      const SizedBox(
                        width: 10,
                      ),
                      buildOption("Ultima Semana", 1, selectedDashboardProvider),
                      const SizedBox(
                        width: 10,
                      ),
                      buildOption("Ultimo Mes", 2, selectedDashboardProvider),
                      const SizedBox(
                        width: 10,
                      ),
                      buildOption("Ultimo Trimestre", 3, selectedDashboardProvider),
                      const SizedBox(
                        width: 10,
                      ),
                      // Agrega más opciones según sea necesario
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOption(String text, int index, SelectedDashboardProvider provider) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.updateSelectedIndexIndicador(index);
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? tPrimaryColor : tPrimaryOpacity,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color.fromARGB(178, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
