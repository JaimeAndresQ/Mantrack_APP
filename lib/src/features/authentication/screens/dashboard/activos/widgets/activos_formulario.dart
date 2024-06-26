import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Formulario extends StatefulWidget {
  const Formulario({
    super.key,
    required this.controller,
    required this.nombreError,
    required this.errorStyle,
    required this.texto,
    required this.icono,
    this.permitirSoloNumeros,
    this.maxCaracteres,
    this.enabled,
  });

  final String texto;
  final TextEditingController controller;
  final String? nombreError;
  final TextStyle errorStyle;
  final Icon icono;
  final TextInputType? permitirSoloNumeros;
  final int? maxCaracteres;
  final bool? enabled;

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.icono,
          labelText: widget.texto,
          hintText: widget.texto,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          errorText: widget.nombreError,
          errorStyle: widget.errorStyle,
          border: const OutlineInputBorder()),
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxCaracteres),
      ],
      keyboardType: widget.permitirSoloNumeros,
      enabled: widget.enabled,
    );
  }
}

class FormularioSelect extends StatefulWidget {
  const FormularioSelect({
    super.key,
    required this.controller,
    required this.nombreError,
    required this.errorStyle,
    required this.texto,
    required this.icono,
    required this.opciones,
    this.permitirSoloNumeros,
    this.maxCaracteres,
    this.enabled,
  });

  final String texto;
  final TextEditingController controller;
  final String? nombreError;
  final TextStyle errorStyle;
  final Icon icono;
  final TextInputType? permitirSoloNumeros;
  final int? maxCaracteres;
  final bool? enabled;
  final List<String> opciones;

  @override
  State<FormularioSelect> createState() => _FormularioSelectState();
}

class _FormularioSelectState extends State<FormularioSelect> {
  String? _selectedValue; // Nuevo campo para almacenar el valor seleccionado

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,// Valor seleccionado actualmente
      onChanged: (String? newValue) {
        if (newValue != null) {
          _selectedValue = newValue;
          widget.controller.text = newValue ??
              ''; // Actualiza el valor del controller al seleccionar una opción
        }
      },
      items: widget.opciones.map((option) {
        return DropdownMenuItem<String>(
          alignment: Alignment.centerLeft,
          value: option,
          child: Text(
            option,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        prefixIcon: widget.icono,
        labelText: widget.texto,
        hintText: widget.texto,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        errorText: widget.nombreError,
        errorStyle: widget.errorStyle,
        border: const OutlineInputBorder(),
        
      ),
    );
  }
}


class FormularioRich extends StatefulWidget {
  const FormularioRich({
    Key? key,
    required this.controller,
    required this.nombreError,
    required this.errorStyle,
    required this.texto,
    required this.icono,
    this.permitirSoloNumeros,
    this.maxCaracteres,
    this.enabled,
  });

  final String texto;
  final TextEditingController controller;
  final String? nombreError;
  final TextStyle errorStyle;
  final Icon icono;
  final TextInputType? permitirSoloNumeros;
  final int? maxCaracteres;
  final bool? enabled;

  @override
  State<FormularioRich> createState() => _FormularioRichState();
}

class _FormularioRichState extends State<FormularioRich> {
  late TextEditingController _richTextController;
  late TextEditingValue _richTextValue;

  @override
  void initState() {
    super.initState();
    _richTextController = TextEditingController();
    _richTextValue = TextEditingValue(text: widget.controller.text);
    _richTextController.value = _richTextValue;
    _richTextController.addListener(_handleRichTextChange);
  }

  @override
  void dispose() {
    _richTextController.dispose();
    super.dispose();
  }

  void _handleRichTextChange() {
    setState(() {
      _richTextValue = _richTextController.value;
      widget.controller.text = _richTextValue.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodySmall,
      controller: _richTextController,
      
      decoration: InputDecoration(
          suffix: widget.icono,
          labelText: widget.texto,
          hintText: widget.texto,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          errorText: widget.nombreError,
          errorStyle: widget.errorStyle,
          alignLabelWithHint: true,
          
          
          border: const OutlineInputBorder()),
          
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxCaracteres),
      ],
      keyboardType: widget.permitirSoloNumeros,
      enabled: widget.enabled,
      maxLines: 4, // Permite múltiples líneas
    );
  }
}

