import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod5 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod5({super.key, required this.ultimos_n_dias});


  @override
  State<WidgetMethod5> createState() => _WidgetMethod5State();
}

class _WidgetMethod5State extends State<WidgetMethod5> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ordenesPorTipo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

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

class WidgetMethod5_2 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod5_2({super.key, required this.ultimos_n_dias});


  @override
  State<WidgetMethod5_2> createState() => _WidgetMethod5_2State();
}

class _WidgetMethod5_2State extends State<WidgetMethod5_2> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ordenesPorTipo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

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

class WidgetMethod5_3 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod5_3({super.key, required this.ultimos_n_dias});


  @override
  State<WidgetMethod5_3> createState() => _WidgetMethod5_3State();
}

class _WidgetMethod5_3State extends State<WidgetMethod5_3> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ordenesPorTipo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

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

class WidgetMethod5_4 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod5_4({super.key, required this.ultimos_n_dias});


  @override
  State<WidgetMethod5_4> createState() => _WidgetMethod5_4State();
}

class _WidgetMethod5_4State extends State<WidgetMethod5_4> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ordenesPorTipo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

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