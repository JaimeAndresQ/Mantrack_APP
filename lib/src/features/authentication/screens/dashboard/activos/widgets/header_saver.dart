import 'package:flutter/material.dart';
import 'package:mantrack_app/src/constants/colors.dart';

class HeaderSave extends StatelessWidget {
  const HeaderSave({
    super.key,
    required this.size,
    required this.titulo,
    required this.flechaAtras,
    this.botonGuardar,
  });

  final Size size;
  final String titulo;
  final void Function()? flechaAtras;
  final void Function()? botonGuardar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 5),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: flechaAtras,
                icon: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: tPrimaryColor, size: 28),
              ),
              const SizedBox(
                width: 15.5,
              ),
              Text(
                titulo,
                style: const TextStyle(
                  
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ],
          ),
          botonGuardar != null
          ? Container(
            padding: const EdgeInsets.all(0.4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: tPrimaryOpacity,
            ),
            child: IconButton(
                onPressed: botonGuardar,
                icon: const Icon(
                  Icons.save,
                  size: 26,
                  color: tPrimaryColor,
                )),
          )
          : const SizedBox()
        ],
      ),
    );
  }
}
