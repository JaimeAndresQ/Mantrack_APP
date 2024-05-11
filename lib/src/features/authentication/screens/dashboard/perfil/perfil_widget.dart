import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_api.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/avatar.dart';
import 'widgets/info_list.dart';
import 'widgets/logout.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  AuthController authController = AuthController();
  late TokenProvider tokenProvider;
  late String? token;
  late Map<String, dynamic> tokenw;
  late String email;
  late String name;
  late String lastname;
  late int telefono;
  late Uint8List? imagen;
  late String? rol;
  bool _isLoading = true; // Estado de carga inicial

  @override
  void initState() {
    super.initState();
    _initWidget(); // Llamada a la función de inicialización diferida
  }

  void _initWidget() async {
    tokenProvider = TokenProvider();
    try {
      token = await tokenProvider.verificarTokenU();
      if (token != null) {
        rol = await tokenProvider.verificarTokenU(rol: true);
        tokenw = JwtDecoder.decode(token!);
        email = tokenw['correo'];
        name = tokenw['nombres'];
        lastname = tokenw['apellidos'];
        telefono = tokenw['telefono'];
        fetchData();
      }
    } catch (e) {
      // Manejar excepciones
      print('Error al obtener el token: $e');
    }
  }

    void fetchData() async {
    try {
      var userImage = await authController.getImageU(email, token!);
      if (userImage != null) {
        setState(() {
          imagen = userImage;
          _isLoading = false;
        });
      } else {
        setState(() {
          imagen = null;
          _isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching imagen usuario: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    Provider.of<TokenProvider>(context);
    final size = MediaQuery.of(context).size;

    if (_isLoading) {
      // Muestra un indicador de carga mientras se obtiene el token
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
          margin: const EdgeInsets.all(10),
          height: size.height * 0.88,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CircularAvatar(
                    size: 100,
                    imageUrl: imagen, isLoading: _isLoading,
                  ),
                  const SizedBox(height: 10),
                  ProfileInfoList(email: email, name: name, lastname: lastname, telefono: telefono, rol: rol,),
                  LogoutButton(onPressed: (){
                    tokenProvider.eliminarTokenU();
                  },)
                ],
              ),
            ),
          ),
        );
      
    }
  }
}
