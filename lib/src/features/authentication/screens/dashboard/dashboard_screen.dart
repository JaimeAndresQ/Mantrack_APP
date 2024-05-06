// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/dashboard_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/model/widgets/dialog_widget.dart';
import '../../model/widgets/ball_widget.dart';
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
  late Uint8List? imagen;
  late dynamic tokenw;
  late NetworkImage imagenCargada;

  bool isLoading = true;

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
      fetchData();
    }
  }

  void fetchData() async {
    try {
      var userImage = await authController.getImageU(email, widget.token!);
      if (userImage != null) {
        setState(() {
          imagen = userImage;
          isLoading = false;
        });
      } else {
        setState(() {
          imagen = null;
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching imagen usuario: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        Provider.of<SelectedDashboardProvider>(context);
    final selectedTokenProvider = Provider.of<TokenProvider>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  // selectedTokenProvider.eliminarTokenU();
                  selectedIndexProvider.updateSelectedIndex(7);
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
                          !isLoading
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFbdbdbd),
                                    shape: BoxShape.circle,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: imagen != null
                                      ? Image.memory(
                                          imagen!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image(
                                          image: NetworkImage(tNoImageFound),
                                          fit: BoxFit.cover,
                                        ))
                              : CircularProgressIndicator(),
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
                              // Update to home page
                              selectedIndexProvider.updateSelectedIndex(0);
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
                selected: selectedIndexProvider.selectedIndex == 1 ||
                    selectedIndexProvider.selectedIndex == 2 ||
                    selectedIndexProvider.selectedIndex == 3 ||
                    selectedIndexProvider.selectedIndex == 4,
                selectedTileColor: tPrimaryOpacity,
                onTap: () async {
                  String? hayToken = await selectedTokenProvider.verificarTokenU();

                  if (hayToken != null) {
                    // Update the state of the app
                    selectedIndexProvider.updateSelectedIndex(1);
                    // Then close the drawer
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                              title: '¡Error!',
                              error: true,
                              message:
                                  '¡El token se ha expirado, inicie de nuevo!',
                              onPressed: () {
                                // Cerrar el diálogo
                                Navigator.pop(context);
                                // Cerrar el modal
                                Navigator.pop(context);
                              },
                            ));
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit_calendar,
                  color: tPrimaryColor,
                ),
                title: const Text('Plan de Tareas'),
                selected: selectedIndexProvider.selectedIndex == 8 ||
                    selectedIndexProvider.selectedIndex == 9 ||
                    selectedIndexProvider.selectedIndex == 10 ||
                    selectedIndexProvider.selectedIndex == 11 ||
                    selectedIndexProvider.selectedIndex == 12,
                selectedTileColor: tPrimaryOpacity,
                onTap: () async {
                  String? hayToken = await selectedTokenProvider.verificarTokenU();

                  if (hayToken != null) {
                    // Update the state of the app
                    selectedIndexProvider.updateSelectedIndex(8);
                    // Then close the drawer
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                              title: '¡Error!',
                              error: true,
                              message:
                                  '¡El token se ha expirado, inicie de nuevo!',
                              onPressed: () {
                                // Cerrar el diálogo
                                Navigator.pop(context);
                                // Cerrar el modal
                                Navigator.pop(context);
                              },
                            ));
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.sticky_note_2_outlined,
                  color: tPrimaryColor,
                ),
                title: const Text('Ordenes de Trabajo'),
                selected: selectedIndexProvider.selectedIndex == 14 ||
                    selectedIndexProvider.selectedIndex == 15 ||
                    selectedIndexProvider.selectedIndex == 16 ||
                    selectedIndexProvider.selectedIndex == 17 ||
                    selectedIndexProvider.selectedIndex == 18,
                selectedTileColor: tPrimaryOpacity,
                onTap: () async {
                  String? hayToken = await selectedTokenProvider.verificarTokenU();

                  if (hayToken != null) {
                    // Update the state of the app
                    selectedIndexProvider.updateSelectedIndex(14);
                    // Then close the drawer
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                              title: '¡Error!',
                              error: true,
                              message:
                                  '¡El token se ha expirado, inicie de nuevo!',
                              onPressed: () {
                                // Cerrar el diálogo
                                Navigator.pop(context);
                                // Cerrar el modal
                                Navigator.pop(context);
                              },
                            ));
                  }
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
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(), child: widgetOptions);
  }
}
