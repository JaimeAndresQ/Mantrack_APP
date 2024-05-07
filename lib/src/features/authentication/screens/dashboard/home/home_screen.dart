import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_builder.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod1.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod2.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod3.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod4.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod5.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/home/widgets/widgetmethod6.dart';
import 'package:provider/provider.dart';

class MantrackHome extends StatelessWidget {
  const MantrackHome({
    super.key,
  });

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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
    
              child: Column(
                children: [
                  // WidgetMethod1(),
                  // WidgetMethod2(ultimos_n_dias: 30,),

                  
                ],
              )),
          ),
        ),

      ],
    );
  }
}

