import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class ActivosDetalles extends StatefulWidget {
  ActivosDetalles({Key? key}) : super(key: key);

  @override
  State<ActivosDetalles> createState() => _ActivosDetallesState();
}

class _ActivosDetallesState extends State<ActivosDetalles> {

  TextStyle textoListitle = const TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Color.fromARGB(209, 0, 0, 0));
  
  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    final size = MediaQuery.of(context).size;
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
                        selectedIndexProvider.updateSelectedIndex(1);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: tPrimaryColor, size: 28),
                    ),
                    const SizedBox(
                      width: 15.5,
                    ),
                      Text(
                  selectedIndexProvider.selectedActivo.id_vehiculo,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                )
                  ],
                ),
              ),
              
               Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                 child: const Text(
                  "Detalles",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                               ),
               ),
                  ListTile(
                leading: Icon(
                  Icons.home_rounded,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),

                title: Text('General', style: textoListitle,),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(1);

                },
              ),
                  ListTile(
                leading: Icon(
                  Icons.history,
                  color: tPrimaryColor,
                  size: 30,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color.fromARGB(162, 0, 0, 0),
                  size: 20,
                ),

                title: Text('Historiales', style: textoListitle,),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(1);

                },
              ),
            ]));
  }
}
