import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class WidgetMethod2 extends StatefulWidget {
  final int ultimos_n_dias;

  const WidgetMethod2({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod2> createState() => _WidgetMethod2State();
}

class _WidgetMethod2State extends State<WidgetMethod2> {
  List<ChartData> chartData = [];
  List<Color> colores = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('http://192.168.1.6:5000/api/ordenesPorVehiculo', data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Ordenes por Vehiculo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['matricula'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
        });

        //Se generan colores aleatorios para cada vehiculo
        generarColores();
      } else {
        print("Ha ocurrido un error con la peticion");
      }
    } catch (e) {
      Error;
      print("No fue posible la peticion al servidor $e");
    }
  }

  //Funcion para generar colores aleatorios para n vehiculos
  void generarColores() {
    List<Color> coloresAleatorios = [];

    for (int i = 0; i < chartData.length; i++) {
      Color colorAleatorio = Color.fromRGBO(
        Random().nextInt(256), // Componente rojo aleatorio
        Random().nextInt(256), // Componente verde aleatorio
        Random().nextInt(256), // Componente azul aleatorio
        1, // Opacidad (1 para opaco)
      );
      coloresAleatorios.add(colorAleatorio);
    }
    setState(() {
      colores = coloresAleatorios;
    });
  }

  @override
  void initState() {
    getData();
    generarColores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10.0),
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Cantidad de ordenes de trabajo por vehículo'),
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.matricula,
            yValueMapper: (ChartData data, _) => data.valor,
            pointColorMapper: (ChartData data, _) {
              return colores[chartData.indexOf(data)];
            },
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Ordenes de point.x: point.y',
        ),
      ),
    );
  }
}

class ChartData {
  final String matricula;
  final int valor;

  ChartData(this.matricula, this.valor);
}
