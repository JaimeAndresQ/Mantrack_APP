import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mantrack_app/src/features/authentication/controller/auth/auth_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WidgetMethod4 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod4({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod4> createState() => _WidgetMethod4State();
}

class _WidgetMethod4State extends State<WidgetMethod4> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(tiempoMedioPorVehiculo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Tiempo Medio Por Vehiculo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['matricula'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
          print(chartData.length);
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
        title: const ChartTitle(
            text: 'Tiempo medio de intervención por Vehiculo',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.green],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.matricula,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Tiempo medio: point.y',
        ),
      ),
    );
  }
}

class ChartData {
  final String matricula;
  final double valor;

  ChartData(this.matricula, this.valor);
}


class WidgetMethod4_2 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod4_2({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod4_2> createState() => _WidgetMethod4_2State();
}

class _WidgetMethod4_2State extends State<WidgetMethod4_2> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(tiempoMedioPorVehiculo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Tiempo Medio Por Vehiculo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['matricula'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
          print(chartData.length);
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
        title: const ChartTitle(
            text: 'Tiempo medio de intervención por Vehiculo',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.green],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.matricula,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Tiempo medio: point.y',
        ),
      ),
    );
  }

}

class WidgetMethod4_3 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod4_3({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod4_3> createState() => _WidgetMethod4_3State();
}

class _WidgetMethod4_3State extends State<WidgetMethod4_3> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(tiempoMedioPorVehiculo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Tiempo Medio Por Vehiculo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['matricula'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
          print(chartData.length);
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
        title: const ChartTitle(
            text: 'Tiempo medio de intervención por Vehiculo',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.green],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.matricula,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Tiempo medio: point.y',
        ),
      ),
    );
  }
}
class WidgetMethod4_4 extends StatefulWidget {
  final int ultimos_n_dias;
  const WidgetMethod4_4({super.key, required this.ultimos_n_dias});

  @override
  State<WidgetMethod4_4> createState() => _WidgetMethod4_4State();
}

class _WidgetMethod4_4State extends State<WidgetMethod4_4> {
  List<ChartData> chartData = [];

  void getData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(tiempoMedioPorVehiculo, data: {"ultimos_n_dias": widget.ultimos_n_dias});

      if (response.statusCode == 200) {
        print("Carga correcta de: Widget Method Tiempo Medio Por Vehiculo");
        List<dynamic> rawData = response.data;
        List<ChartData> data = rawData
            .map((item) => ChartData(item['matricula'], item['valor']))
            .toList();

        //Se actualiza el valor de chartData
        setState(() {
          chartData = data;
          print(chartData.length);
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
        title: const ChartTitle(
            text: 'Tiempo medio de intervención por Vehiculo',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: const CategoryAxis(),
        palette: const <Color>[Colors.green],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.matricula,
            yValueMapper: (ChartData data, _) => data.valor,
          )
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Tiempo medio: point.y',
        ),
      ),
    );
  }
}