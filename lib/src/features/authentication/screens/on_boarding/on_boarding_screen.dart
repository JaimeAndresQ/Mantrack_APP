

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:mantrack_app/src/constants/colors.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';
import 'package:mantrack_app/src/constants/text_strings.dart';
import 'package:mantrack_app/src/features/authentication/model/on_boarding_modal.dart';
import 'package:mantrack_app/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
   const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final pages = [
      OnBoardingPagesWidget(
          model: OnBoardingModel(
              image: tOnBoardingImage1,
              title: tOnBoardingtitle1,
              subtitle: tOnBoardingsubtitle2,
              countertext: tOnBoardingcountertext1,
              bgcolor: tOnBoardingPage1Colors,
              height: size.height)),
      OnBoardingPagesWidget(
          model: OnBoardingModel(
              image: tOnBoardingImage2,
              title: tOnBoardingtitle2,
              subtitle: tOnBoardingsubtitle2,
              countertext: tOnBoardingcountertext2,
              bgcolor: tOnBoardingPage2Colors,
              height: size.height)),
      OnBoardingPagesWidget(
          model: OnBoardingModel(
              image: tOnBoardingImage3,
              title: tOnBoardingtitle3,
              subtitle: tOnBoardingsubtitle3,
              countertext: tOnBoardingcountertext3,
              bgcolor: tOnBoardingPage3Colors,
              height: size.height)),
      OnBoardingPagesWidget(
          model: OnBoardingModel(
              image: tOnBoardingImage4,
              title: tOnBoardingtitle4,
              subtitle: tOnBoardingsubtitle4,
              countertext: tOnBoardingcountertext4,
              bgcolor: tOnBoardingPage4Colors,
              height: size.height)),
      const WelcomeScreen()
    ];

    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
          pages: pages,
          liquidController: controller,
          onPageChangeCallback: onPageChangedCallBack,
          slideIconWidget: const Icon(Icons.arrow_back_ios),
          enableSideReveal: true,
        ),
        Positioned( 
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () {
                int nextPage = controller.currentPage + 1;
                controller.animateToPage(page: nextPage); 
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
              ),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios)),
            )),
        Positioned(
            top: 35,
            right: 20,
            child: TextButton(
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => controller.jumpToPage(page: 3)
              ,
            )),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
          activeIndex: controller.currentPage, 
          count: 4,
          effect: const WormEffect(
            activeDotColor: tPrimaryColor,
            dotHeight: 6.0
          ),
          )
          )
      ]),
    );
  }

void onPageChangedCallBack(int activePageIndex) {
  setState(() {
    if (activePageIndex == 4) {
      // Si está en la última página, navega a la pantalla AppHome
      Navigator.pushReplacementNamed(context, 'welcome');
    } else {
      // De lo contrario, actualiza la página actual
      currentPage = activePageIndex;
    }
  });
}
}
