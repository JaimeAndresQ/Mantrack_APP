import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod3 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod3({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod3> createState() => _WidgetMethod3State();
}

class _WidgetMethod3State extends State<WidgetMethod3> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response = await dio
          .get(ordenesPorEstado, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Ordenes por Estado");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['estado'], item['valor']))
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
        title: const ChartTitle(text: 'Cantidad de ordenes de trabajo por estado', textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.blue],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.estado,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Ordenes point.x : point.y',
        ),
      ),
    );
  }
}

class ChartData {
  final String estado;
  final int valor;

  ChartData(this.estado, this.valor);
}

class WidgetMethod3_2 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod3_2({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod3_2> createState() => _WidgetMethod3_2State();
}

class _WidgetMethod3_2State extends State<WidgetMethod3_2> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response = await dio
          .get(ordenesPorEstado, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Ordenes por Estado");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['estado'], item['valor']))
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
        title: const ChartTitle(text: 'Cantidad de ordenes de trabajo por estado', textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.blue],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.estado,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Ordenes point.x : point.y',
        ),
      ),
    );
  }
}

class WidgetMethod3_3 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod3_3({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod3_3> createState() => _WidgetMethod3_3State();
}

class _WidgetMethod3_3State extends State<WidgetMethod3_3> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response = await dio
          .get(ordenesPorEstado, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Ordenes por Estado");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['estado'], item['valor']))
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
        title: const ChartTitle(text: 'Cantidad de ordenes de trabajo por estado', textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.blue],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.estado,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Ordenes point.x : point.y',
        ),
      ),
    );
  }
}

class WidgetMethod3_4 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod3_4({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod3_4> createState() => _WidgetMethod3_4State();
}

class _WidgetMethod3_4State extends State<WidgetMethod3_4> {

List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response = await dio
          .get(ordenesPorEstado, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Ordenes por Estado");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['estado'], item['valor']))
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
        title: const ChartTitle(text: 'Cantidad de ordenes de trabajo por estado', textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.blue],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.estado,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Ordenes point.x : point.y',
        ),
      ),
    );
  }
}