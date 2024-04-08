// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/sizes.dart';
import 'package:mantrack_app/src/constants/text_strings.dart';
import 'package:mantrack_app/src/features/authentication/screens/login/login_screen.dart';


import '../registrarse/registrarse_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              tOnWelcomeImage1,
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  tWelcomeTitle1,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  tWelcomeSubtitle1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        side: BorderSide(color: tPrimaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
                      ),
                      child: Text(
                        "INICIAR SESION",
                        style: TextStyle(color: tPrimaryColor),

                      )),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: ElevatedButton(              
                    onPressed: () {
                      Get.to(() => const RegistrarseScreen());
                    },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(),
                        backgroundColor: tPrimaryColor,
                        side: BorderSide(color: tPrimaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
                      ),

                    child: Text("REGISTRARSE"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
