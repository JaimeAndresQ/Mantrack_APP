import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/activos_placa_modal.dart';
import 'package:provider/provider.dart';

class TareaScreen extends StatefulWidget {
  TareaScreen({Key? key}) : super(key: key);

  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  TextStyle textoListitle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(209, 0, 0, 0));


  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider = Provider.of<SelectedDashboardProvider>(context);

    final size = MediaQuery.of(context).size;


    return Detalles(size: size, selectedIndexProvider: selectedIndexProvider, 
          textoListitle: textoListitle, );

  }
}

class Detalles extends StatelessWidget {
  const Detalles({
    super.key,
    required this.size,
    required this.selectedIndexProvider,
    required this.textoListitle,
    this.activoplaca,
  });

  final Size size;
  final SelectedDashboardProvider selectedIndexProvider;
  final TextStyle textoListitle;
  final ActivoPlaca? activoplaca;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        selectedIndexProvider.updateSelectedIndex(8);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: tPrimaryColor, size: 28),
                    ),
                    const SizedBox(
                      width: 15.5,
                    ),
                    
                       Expanded(
                        child: Text(
                          selectedIndexProvider.selectedPlanMantenimiento.nombre,
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      )

                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  "Detalles",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.house_siding_rounded,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'General',
                  style: textoListitle,
                ),
                
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  
                  selectedIndexProvider.updateSelectedIndex(13);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.checklist_rtl_outlined,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'Tareas',
                  style: textoListitle,
                ),
                
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(11);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.layers_outlined,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),
                title: Text(
                  'Activos Vinculados',
                  style: textoListitle,
                ),
                
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(12);
                },
              ),
            ]));
  }
}
