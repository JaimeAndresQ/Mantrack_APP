// const url = 'http://{IPv4}:3000/';

const iPv4 = "192.168.1.15"; //IP de la máquina donde está corriendo la APP

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


// Urls de actualizar tareas
const putAsociarMantenimientosUrl = "http://$iPv4:80/api/planesMantenimientos/mantenimiento/updatePlan";
const putAsociarActivoUrl = "http://$iPv4:80/api/planesMantenimientos/vehiculo/updatePlan";


