import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod6 extends StatefulWidget {
  const WidgetMethod6({super.key});

  @override
  State<WidgetMethod6> createState() => _WidgetMethod6State();
}

class _WidgetMethod6State extends State<WidgetMethod6> {

  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      String ip = iPv4;
      final response = await dio
          .get("http://$ip:5000/api/eficienciaOperarios");

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Eficiencia Operarios");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['usuario'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
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
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Eficiencia de operarios', textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.purple],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.usario,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Eficiencia: point.y%',
        ),
      ),
    );
  }
}

class ChartData {
  final String usario;
  final double valor;

  ChartData(this.usario, this.valor);
}