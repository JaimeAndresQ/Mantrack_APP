class OrdenTrabajo {
  final int id_ordenTrabajo;
  final String id_vehiculo;
  final String descripcion;
  final String estado;
  final String observaciones;
  final String fechaRealizacion;
  final int tiempoEstimado;
  final dynamic tiempoEjecucion;
  final String tipoMantenimiento;
  final String correoUsuario;
  final int categoriaFk;
  final OrdenesUsuario  usuario;


  OrdenTrabajo({
    required this.id_ordenTrabajo,
    required this.id_vehiculo,
    required this.descripcion,
    required this.estado,
    required this.observaciones,
    required this.fechaRealizacion,
    required this.tiempoEjecucion,
    required this.tiempoEstimado,
    required this.tipoMantenimiento,
    required this.correoUsuario,
    required this.categoriaFk,
    required this.usuario,
  });

  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) {
      

    return OrdenTrabajo(
      id_ordenTrabajo: json['id_orden_trabajo'] ?? "Sin id orden trabajo",
      id_vehiculo: json['fk_id_vehiculo'] ?? "Sin id vehiculo",
      descripcion: json['ord_descripcion'] ?? "Sin descripcion",
      estado: json['ord_estado'] ?? "Sin estado",
      observaciones: json['ord_observaciones'] ?? "Sin observaciones",
      fechaRealizacion: json['ord_fecha_realizacion'] ?? "Sin fecha realizacion",
      tiempoEstimado: json['ord_tiempo_estimado'] ?? "Sin tiempo estimado",
      tiempoEjecucion: json['ord_tiempo_ejecucion'] ?? "Sin tiempo ejecucion",
      tipoMantenimiento: json['ord_tipo_mantenimiento'] ?? "Sin tipo de mantenimiento",
      correoUsuario: json['fk_id_usuario_correo'] ?? "Sin correo de usuario",
      categoriaFk: json['fk_id_categoria'] ?? "Sin categoria de mantenimiento",
      usuario: OrdenesUsuario.fromJson(json['Usuario']),
    );
  }
}

class OrdenesUsuario {
  final String correo;
  final Persona persona;

  OrdenesUsuario({
    required this.correo,
    required this.persona,
  });

  factory OrdenesUsuario.fromJson(Map<String, dynamic> json) {
    return OrdenesUsuario(
      correo: json['id_usuario_correo'] ?? "Sin correo",
      persona: Persona.fromJson(json['Persona']),
    );
  }
}

class Persona {
  final String nombres;
  final String apellidos;

  Persona({
    required this.nombres,
    required this.apellidos,

  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      nombres: json['pe_nombres'] ?? "Sin nombre",
      apellidos: json['pe_apellidos'] ?? "Sin apellido",
    );
  }
}