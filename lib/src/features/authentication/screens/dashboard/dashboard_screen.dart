// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/dashboard/activos_registrar.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';

import 'ball_widget.dart';

import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  final String? token;
  const DashboardScreen({super.key, this.token});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthController authController = AuthController();

  static const TextStyle optionMenuStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  late String email;
  late String name;
  late String lastname;
  late dynamic tokenw;

  @override
  void initState() {
    super.initState();
    // Si se proporciona un token, se extrae la información del usuario del token decodificado y se obtienen los datos de los artículos favoritos.
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
      tokenw = jwtDecodedToken;
      email = jwtDecodedToken['correo'];
      name = jwtDecodedToken['nombres'];
      lastname = jwtDecodedToken['apellidos'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          title: Text(
            selectedIndexProvider.getTitle(selectedIndexProvider.selectedIndex),
            style: optionMenuStyle,
          ),
          backgroundColor: tPrimaryColor,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  tokenProvider.eliminarTokenU();
                  Get.to(() => WelcomeScreen());
                },
                icon: const Image(
                  image: AssetImage(tPersonIcon),
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any adding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 300,
                child: DrawerHeader(
                  padding: EdgeInsets.all(tDefaultSize - 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tPrimaryOpacity,
                            ),
                            child: Image(
                              image:
                                  AssetImage("assets/logo/logo_mantrack.png"),
                              height: tDefaultSize - 8,
                              color: tPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Mantrack",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: tDefaultSize - 5,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFFbdbdbd),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Positioned(top: 0, left: -10, child: PulsatingBall()),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$name $lastname",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF262626)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$email",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF262626)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Empresa Trackman S.A.S",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF262626)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: tPrimaryOpacity,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.dashboard,
                              size: 30,
                              color: tPrimaryColor,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.layers,
                  color: tPrimaryColor,
                ),
                title: const Text('Activos'),
                selected: selectedIndexProvider.selectedIndex == 1,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(1);
                  // Then close the drawer

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_4_sharp,
                  color: tPrimaryColor,
                ),
                title: const Text('Recursos Humanos'),
                selected: selectedIndexProvider.selectedIndex == 2,
                selectedTileColor: tPrimaryOpacity,
                onTap: () {
                  // Update the state of the app
                  selectedIndexProvider.updateSelectedIndex(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: DashboardPage(
          widgetOptions: selectedIndexProvider.getSelectedWidget(),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final Widget widgetOptions;

  const DashboardPage({
    super.key,
    required this.widgetOptions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: widgetOptions);
  }
}
