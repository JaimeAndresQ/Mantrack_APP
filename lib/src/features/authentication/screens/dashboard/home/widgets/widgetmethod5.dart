import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod5 extends StatefulWidget {
  const WidgetMethod5({super.key});

  @override
  State<WidgetMethod5> createState() => _WidgetMethod5State();
}

class _WidgetMethod5State extends State<WidgetMethod5> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ordenesPorTipo);

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Porcentajes de ordenes de trabajo por tipo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['tipo'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
          print(chartData);
        });
      } else {
        print("Ha ocurrido un error con la peticion");
      }
    } catch (e) {
      Error;
      print("No fue posible la peticion al servidor $e");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10.0),
      child: SfCircularChart(
        title: const ChartTitle(
            text: 'Porcentajes de ordenes de trabajo por tipo',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.tipo,
            yValueMapper: (ChartData data, _) => data.valor,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),// Mostrar etiquetas de datos
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y%',
        ),
      ),
    );
  }
}

class ChartData {
  final String tipo;
  final double valor;

  ChartData(this.tipo, this.valor);
}
