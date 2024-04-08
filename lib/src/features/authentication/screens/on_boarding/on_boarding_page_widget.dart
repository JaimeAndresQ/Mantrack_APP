import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/on_boarding_modal.dart';

class OnBoardingPagesWidget extends StatelessWidget {
  const OnBoardingPagesWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(8),
    color: model.bgcolor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    
      children: [
        
        SvgPicture.asset(model.image, height: model.height*0.45,),
        Column(
          children: [
            Text(model.title, style: Theme.of(context).textTheme.titleMedium),
            Text(model.subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Text(model.countertext, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 50.0,)
      ],
    )
    
    
    ,);
  }
}