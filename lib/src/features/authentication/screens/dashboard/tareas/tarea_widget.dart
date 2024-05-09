import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/tareas/widgets/planes_builder.dart';
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
                  
                  
                  
                  SizedBox(
                      height: size.height * 0.76,
                      width: size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PlanesBuilder(
                          isPressed: isPressed,
                        )
                      ))
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


