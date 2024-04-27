// const url = 'http://{IPv4}:3000/';

const iPv4 = "10.152.164.157"; //IP de la máquina donde está corriendo la APP

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
