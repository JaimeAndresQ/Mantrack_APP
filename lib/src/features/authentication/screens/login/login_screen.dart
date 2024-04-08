import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  tSingImage1,
                  height: size.height * 0.4,
                ),
                const SizedBox(height: tFormHeight),
                Text(
                  "Iniciar Sesion",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Ingresa tus credenciales para iniciar",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                LoginForm(prefs: prefs,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
