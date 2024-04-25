import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class TareaWidget extends StatefulWidget {
  const TareaWidget({
    super.key,
  });

  @override
  State<TareaWidget> createState() => _TareaWidgetState();
}

class _TareaWidgetState extends State<TareaWidget> {

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);


    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.height * 0.88,
          width: size.width * 0.95,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isPressed = !isPressed;
                          });
                          
                        },
                        child: const Icon(Icons.edit)
                        ),
                    ),
                  ),
                  const Divider(thickness: 1, color: Colors.black26),
                  MyActivos(
                    selectedIndexProvider: selectedIndexProvider,
                    isPressed: isPressed,

                  ),
                ],
              )),
        ),
        Positioned(
          right: tDefaultSize - 5,
          bottom: tDefaultSize - 5,
          child: FloatingActionButton(
            onPressed: () {
              selectedIndexProvider.updateSelectedIndex(10);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class MyActivos extends StatefulWidget {
  final SelectedDashboardProvider selectedIndexProvider;
  final bool isPressed;

  const MyActivos({
    super.key,
    required this.selectedIndexProvider,
    required this.isPressed
  });

  @override
  State<MyActivos> createState() => _MyActivosState();
}

class _MyActivosState extends State<MyActivos> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.selectedIndexProvider.updateSelectedIndex(9);
      },
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
            widget.isPressed
            ?
            Column(
              children: [
                const Icon(
                  Icons.precision_manufacturing_outlined,
                  color: tPrimaryColor,
                ),
                Checkbox(
                    activeColor: tPrimaryColor,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    })
              ],
            )
            :
            const SizedBox(),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Descripcion",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(164, 0, 0, 0)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Tareas asociadas: 0",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: tPrimaryColor),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Activos vinculados: 0",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: tPrimaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
