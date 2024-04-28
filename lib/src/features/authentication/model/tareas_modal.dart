class TareasMantenimiento {
  final String descripcion;
  final String tipo;
  final int id;
  final int duracion;
  final int fkcategoria;


  TareasMantenimiento({
    required this.descripcion,
    required this.tipo,
    required this.duracion,
    required this.fkcategoria,
    required this.id,
  });

  factory TareasMantenimiento.fromJson(Map<String, dynamic> json) {
    return TareasMantenimiento(
      descripcion: json['man_descripcion'] ?? "Sin descripcion",
      tipo: json['man_tipo_mantenimiento'] ?? "Sin tipo de mantenimiento",
      id: json['id_mantenimiento'] ?? "Sin id de mantenimiento",
      fkcategoria: json['fk_id_categoria'] ?? "Sin categoria",
      duracion: json['man_duracion_estimada'] ?? "Sin duracion estimada",

    );
  }
}
