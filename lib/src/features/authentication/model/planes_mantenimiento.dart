class PlanMantenimiento {
  final int idPlanMantenimiento;
  final String nombre;
  final String fecha;
  final List<PlanMantenimientoVehiculos> planVehiculos;
  final List<PlanMantenimientoTareas> planTareas;

  PlanMantenimiento({
    required this.idPlanMantenimiento,
    required this.nombre,
    required this.planVehiculos,
    required this.planTareas,
    required this.fecha,
  });

  factory PlanMantenimiento.fromJson(Map<String, dynamic> json) {
    List<PlanMantenimientoVehiculos> parsedPlanManteVehiculos = [];
    if (json['plan_mantenimiento_tiene_vehiculos'] != null) {
      var listU = json['plan_mantenimiento_tiene_vehiculos'] as List;
      parsedPlanManteVehiculos =
          listU.map((planVehi) => PlanMantenimientoVehiculos.fromJson(planVehi)).toList();
    }
    List<PlanMantenimientoTareas> parsedPlanManteTareas = [];
    if (json['plan_mantenimiento_tiene_mantenimientos'] != null) {
      var listU = json['plan_mantenimiento_tiene_mantenimientos'] as List;
      parsedPlanManteTareas =
          listU.map((planTareas) => PlanMantenimientoTareas.fromJson(planTareas)).toList();
    }
    return PlanMantenimiento(
      idPlanMantenimiento: json['id_plan_mantenimiento'] ?? 0,
      nombre: json['pl_nombre'] ?? "Sin nombre",
      fecha: json['pl_fecha_realizacion_estimada'] ?? "Sin fecha de realizacion estimada",
      planVehiculos: parsedPlanManteVehiculos,
      planTareas: parsedPlanManteTareas
    );
  }
}

class PlanMantenimientoVehiculos {
  final String id_vehiculo;
  final int id_plan_mantenimiento;
  final Map<String, dynamic> vehiculo;
  bool isChecked = false;

  PlanMantenimientoVehiculos({
    required this.id_vehiculo,
    required this.id_plan_mantenimiento,
    required this.vehiculo,
  });

  factory PlanMantenimientoVehiculos.fromJson(Map<String, dynamic> json) {
    return PlanMantenimientoVehiculos(
      id_vehiculo: json['fk_id_vehiculo'] ?? "Sin id vehiculo",
      id_plan_mantenimiento: json['fk_id_plan_mantenimiento'] ?? "Sin id plan de mantenimiento",
      vehiculo: json['Vehiculo'] ?? "Sin vehiculos",
    );
  }
}

class PlanMantenimientoTareas {
  final int id_mantenimiento;
  final int id_plan_mantenimiento;
  final Map<String, dynamic> mantenimiento;
  bool isChecked = false;

  PlanMantenimientoTareas({
    required this.id_mantenimiento,
    required this.id_plan_mantenimiento,
    required this.mantenimiento,
    
  });

  factory PlanMantenimientoTareas.fromJson(Map<String, dynamic> json) {
    return PlanMantenimientoTareas(
      id_mantenimiento: json['fk_id_mantenimiento'] ?? "Sin id mantenimiento",
      id_plan_mantenimiento: json['fk_id_plan_mantenimiento'] ?? "Sin id plan de mantenimiento",
      mantenimiento: json['Mantenimiento'] ?? "Sin mantenimientos",
    );
  }
}
