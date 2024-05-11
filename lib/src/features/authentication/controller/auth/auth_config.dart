// const url = 'http://{IPv4}:3000/';

const iPv4 = "192.168.1.7"; //IP de la máquina donde está corriendo la APP

// Urls de login y registro
const loginUrl = "http://$iPv4:80/api/users/user";
const registrationUrl = "http://$iPv4:80/api/users/newUser";

// Urls de manejo de imagenes de usuario
const registrationImagenUrl = "http://$iPv4:80/api/imagenes/uploadUsuario";
const getImagenUrl = "http://$iPv4:80/api/imagenes/usuario/";

// Urls de manejo de imagenes de activos
const registrationVehiculoImagenUrl = "http://$iPv4:80/api/imagenes/uploadVehiculos";
const getVehiculoImagenUrl = "http://$iPv4:80/api/imagenes/vehiculo/";

// Urls de post y update de activo
const registrarActivoUrl = "http://$iPv4:80/api/vehiculos/newVehiculo";
const actualizarActivoUrl = "http://$iPv4:80/api/vehiculos/updateVehiculo/";

// Urls de get de activo
const getActivosUrl = "http://$iPv4:80/api/vehiculos/getAll";
const getActivoEspecificoUrl = "http://$iPv4:80/api/vehiculos/vehiculo/";

// Urls de post de tareas
const registrarMantenimientoUrl = "http://$iPv4:80/api/planesMantenimientos/newMantenimiento";
const registrarPlandeMantenimientoUrl = "http://$iPv4:80/api/planesMantenimientos/newPlan";

// Urls de get de tareas
const getAllPlanesMantenimientoUrl = "http://$iPv4:80/api/planesMantenimientos/getAll";
const getMantenimientoTareaUrl = "http://$iPv4:80/api/planesMantenimientos/mantenientosNoAsociados/";
const getActivosNoAsociadosUrl = "http://$iPv4:80/api/planesMantenimientos/vehiculosNoAsociados/";

// Urls de delete de tareas
const deleteMantenimientoUrl = "http://$iPv4:80/api/planesMantenimientos/eliminarMantenimiento";
const deleteVehiculoUrl = "http://$iPv4:80/api/planesMantenimientos/eliminarVehiculo";


// Urls de actualizar tareas
const putAsociarMantenimientosUrl = "http://$iPv4:80/api/planesMantenimientos/mantenimiento/updatePlan";
const putAsociarActivoUrl = "http://$iPv4:80/api/planesMantenimientos/vehiculo/updatePlan";

// Urls de ordenes de trabajo
const registrarOTsUrl = "http://$iPv4:80/api/ordenesTrabajo/newOrden";
const getAllOrdenesTrabajo = "http://$iPv4:80/api/ordenesTrabajo/getAll/";

// Urls de aprobar estados de OTs
const finalizarOTsUrl = "http://$iPv4:80/api/ordenesTrabajo/finalizarOrden/";
const aprobarOTsUrl = "http://$iPv4:80/api/ordenesTrabajo/aprobarOrden/";


// Urls de graficas de la API
const fallasMasFrecuentes = "http://$iPv4:5000/api/obtenerFallaMasFrecuenteCorrectiva";
const ordenesPorVehiculo = "http://$iPv4:5000/api/ordenesPorVehiculo";
const ordenesPorEstado = "http://$iPv4:5000/api/ordenesPorEstado";
const tiempoMedioPorVehiculo = "http://$iPv4:5000/api/tiempoMedioPorVehiculo";
const ordenesPorTipo = "http://$iPv4:5000/api/ordenesPorTipo";
const eficaciaOperarios = "http://$iPv4:5000/api/eficienciaOperarios";