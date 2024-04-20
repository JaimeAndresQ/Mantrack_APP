class Activos {
  final String id_vehiculo;
  final String marca;
  final int modelo;
  final String linea;


  Activos({
    required this.id_vehiculo,
    required this.marca,
    required this.modelo,
    required this.linea,
  });

  factory Activos.fromJson(Map<String, dynamic> json) {
    return Activos(
      id_vehiculo: json['id_vehiculo'] ?? "Sin id",
      marca: json['veh_marca'] ?? "Sin marca",
      modelo: json['veh_modelo'] ?? "Sin modelo",
      linea: json['veh_linea'] ?? "Sin linea",

    );
  }
}
