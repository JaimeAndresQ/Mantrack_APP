import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/avatar.dart';
import 'widgets/info_list.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late TokenProvider tokenProvider;
  late String? token;
  late Map<String, dynamic> tokenw;
  late String email;
  late String name;
  late String lastname;
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
        tokenw = JwtDecoder.decode(token!);
        email = tokenw['correo'];
        name = tokenw['nombres'];
        lastname = tokenw['apellidos'];
      }
    } catch (e) {
      // Manejar excepciones
      print('Error al obtener el token: $e');
    } finally {
      // Actualizar el estado para indicar que la carga ha finalizado
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
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
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10), 
              const CircularAvatar(size: 100, imageUrl: 'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png'),
              const SizedBox(height: 10), // Espacio entre el avatar y la lista
              ProfileInfoList(email: email, name: name, lastname: lastname),
            ],
          ),
        ),
      );
    }
  }
}
