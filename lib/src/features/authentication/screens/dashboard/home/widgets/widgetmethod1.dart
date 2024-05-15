import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod1 extends StatefulWidget {
  final int ultimos_n_dias;
  
  const WidgetMethod1({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod1> createState() => _WidgetMethod1State();
}

class _WidgetMethod1State extends State<WidgetMethod1> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      
      final response = await dio
          .get(fallasMasFrecuentes, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print(
            "Carga correcta de: Widget Method Fallas Mas Frecuentes Correctivas");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['categoria'], item['valor']))
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
    return SfCartesianChart(
      title: const ChartTitle(text: 'Ordenes de trabajo correctivas más frecuentes', textStyle: TextStyle(fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      palette: const <Color>[Colors.orange],
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.categoria,
          yValueMapper: (ChartData data, _) => data.valor,
        )
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Cantidad de ordenes: point.y',
      ),
    );
  }
}

class ChartData {
  final String categoria;
  final int valor;

  ChartData(this.categoria, this.valor);
}


class WidgetMethod1_2 extends StatefulWidget {
  final int ultimos_n_dias;
  
  const WidgetMethod1_2({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod1_2> createState() => _WidgetMethod1_2State();
}

class _WidgetMethod1_2State extends State<WidgetMethod1_2> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      
      final response = await dio
          .get(fallasMasFrecuentes, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print(
            "Carga correcta de: Widget Method Fallas Mas Frecuentes Correctivas");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['categoria'], item['valor']))
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
    return SfCartesianChart(
      title: const ChartTitle(text: 'Ordenes de trabajo correctivas más frecuentes', textStyle: TextStyle(fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      palette: const <Color>[Colors.orange],
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.categoria,
          yValueMapper: (ChartData data, _) => data.valor,
        )
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Cantidad de ordenes: point.y',
      ),
    );
  }
}

class WidgetMethod1_3 extends StatefulWidget {
  final int ultimos_n_dias;
  
  const WidgetMethod1_3({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod1_3> createState() => _WidgetMethod1_3State();
}

class _WidgetMethod1_3State extends State<WidgetMethod1_3> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      
      final response = await dio
          .get(fallasMasFrecuentes, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print(
            "Carga correcta de: Widget Method Fallas Mas Frecuentes Correctivas");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['categoria'], item['valor']))
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
    return SfCartesianChart(
      title: const ChartTitle(text: 'Ordenes de trabajo correctivas más frecuentes', textStyle: TextStyle(fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      palette: const <Color>[Colors.orange],
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.categoria,
          yValueMapper: (ChartData data, _) => data.valor,
        )
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Cantidad de ordenes: point.y',
      ),
    );
  }
}

class WidgetMethod1_4 extends StatefulWidget {
  final int ultimos_n_dias;
  
  const WidgetMethod1_4({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod1_4> createState() => _WidgetMethod1_4State();
}

class _WidgetMethod1_4State extends State<WidgetMethod1_4> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      
      final response = await dio
          .get(fallasMasFrecuentes, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print(
            "Carga correcta de: Widget Method Fallas Mas Frecuentes Correctivas");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['categoria'], item['valor']))
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
    return SfCartesianChart(
      title: const ChartTitle(text: 'Ordenes de trabajo correctivas más frecuentes', textStyle: TextStyle(fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      palette: const <Color>[Colors.orange],
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.categoria,
          yValueMapper: (ChartData data, _) => data.valor,
        )
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Cantidad de ordenes: point.y',
      ),
    );
  }
}

