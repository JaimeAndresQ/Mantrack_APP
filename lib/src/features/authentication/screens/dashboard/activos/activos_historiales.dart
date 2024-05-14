import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/activos_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_builder_historial.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/activos_formulario.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos/widgets/header_saver.dart';
import 'package:provider/provider.dart';

class ActivosHistorial extends StatefulWidget {
  const ActivosHistorial({
    super.key,
  });

  @override
  State<ActivosHistorial> createState() => _ActivosHistorialState();
}

class _ActivosHistorialState extends State<ActivosHistorial> {
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);

    return Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.88,
        width: size.width * 0.95,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          HeaderSave(
            size: size,
            titulo: "Historiales",
            flechaAtras: () {
              selectedIndexProvider.updateSelectedIndex(2);
            },
          ),
          SizedBox(
              height: size.height * 0.79,
              width: size.width * 0.95,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActivosHistorialesBuilder(
                    vehiculoId:
                        selectedIndexProvider.selectedActivo.id_vehiculo,
                  ))),
        ]));
  }
}
