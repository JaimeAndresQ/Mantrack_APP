import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/features/authentication/screens/registrarse/registarse_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RegistrarseScreen extends StatefulWidget {
  const RegistrarseScreen({super.key});

  @override
  State<RegistrarseScreen> createState() => _RegistrarseScreenState();
}

class _RegistrarseScreenState extends State<RegistrarseScreen> {

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
                  tRegistrarImage1,
                  height: size.height * 0.2,
                ),
                const SizedBox(height: tFormHeight),

                Text(
                  "Registrarse",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Crea un nuevo usuario para Mantrack",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RegistrarseForm(prefs: prefs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


