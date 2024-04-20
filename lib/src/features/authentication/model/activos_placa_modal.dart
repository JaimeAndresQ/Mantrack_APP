class ActivoPlaca {
  final String id_vehiculo;
  final String marca;
  final int modelo;
  final String linea;
  final String color;
  final String capacidad;
  final String clase;
  final int cilindraje;
  final String combustible;
  final String numeroMotor;
  final String numeroChasis;
  final String vin;
  final String ciudad_registro;
  final String fecha_matricula;


  ActivoPlaca({
    required this.id_vehiculo,
    required this.marca,
    required this.modelo,
    required this.linea,
    required this.color,
    required this.capacidad,
    required this.clase,
    required this.cilindraje,
    required this.combustible,
    required this.numeroMotor,
    required this.numeroChasis,
    required this.vin,
    required this.ciudad_registro,
    required this.fecha_matricula,
  });

  factory ActivoPlaca.fromJson(Map<String, dynamic> json) {
    return ActivoPlaca(
      id_vehiculo: json['id_vehiculo'] ?? "Sin id",
      marca: json['veh_marca'] ?? "Sin marca",
      modelo: json['veh_modelo'] ?? "Sin modelo",
      linea: json['veh_linea'] ?? "Sin linea",
      color: json['veh_color'] ?? "Sin color",
      capacidad: json['veh_capacidad'] ?? "Sin capacidad",
      clase: json['veh_clase_vehiculo'] ?? "Sin clase",
      cilindraje: json['veh_cilindraje'] ?? "Sin cilindraje",
      combustible: json['veh_tipo_combustible'] ?? "Sin combustible",
      numeroMotor: json['veh_numero_motor'] ?? "Sin numero de motor",
      numeroChasis: json['veh_numero_chasis'] ?? "Sin numero de chasis",
      vin: json['veh_vin'] ?? "Sin vin",
      ciudad_registro: json['veh_ciudad_registro'] ?? "Sin ciudad de registro",
      fecha_matricula: json['veh_fecha_matricula'] ?? "Sin fecha de matricula",

    );
  }
}
