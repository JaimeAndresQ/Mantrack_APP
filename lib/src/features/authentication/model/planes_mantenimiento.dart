class PlanMantenimiento {
  final int idPlanMantenimiento;
  final String nombre;

  PlanMantenimiento({
    required this.idPlanMantenimiento,
    required this.nombre,
  });

  factory PlanMantenimiento.fromJson(Map<String, dynamic> json) {
    return PlanMantenimiento(
      idPlanMantenimiento: json['id_plan_mantenimiento'] ?? 0,
      nombre: json['pl_nombre'] ?? "Sin nombre",
    );
  }
}
