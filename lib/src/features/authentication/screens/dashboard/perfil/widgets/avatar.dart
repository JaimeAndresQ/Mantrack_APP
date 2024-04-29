import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/image_strings.dart';

class CircularAvatar extends StatelessWidget {
  final double size;
  final Uint8List? imageUrl;
  final bool isLoading;

  const CircularAvatar(
      {super.key, required this.size, required this.isLoading, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        !isLoading
            ? Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFbdbdbd),
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.hardEdge,
                
                child: imageUrl != null
                    ? Image.memory(
                        imageUrl!,
                        fit: BoxFit.cover,
                        
                      )
                    : const Image(
                        image: NetworkImage(tNoImageFound),
                        fit: BoxFit.cover,
                      ))
            : const CircularProgressIndicator(),
      ],
    );
  }
}
