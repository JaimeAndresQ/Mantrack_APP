// const url = 'http://{IPv4}:3000/';

const iPv4 = "192.168.1.3"; //IP de la máquina donde está corriendo la APP

const loginUrl = "http://$iPv4:80/api/users/user";
const registrationUrl = "http://$iPv4:80/api/users/newUser";

const registrationImagenUrl = "http://$iPv4:80/api/imagenes/uploadUsuario";
const getImagenUrl = "http://$iPv4:80/api/imagenes/usuario/";

const registrationVehiculoImagenUrl = "http://$iPv4:80/api/imagenes/uploadVehiculos";
const getVehiculoImagenUrl = "http://$iPv4:80/api/imagenes/vehiculo/";


const registrarActivoUrl = "http://$iPv4:80/api/vehiculos/newVehiculo";
const actualizarActivoUrl = "http://$iPv4:80/api/vehiculos/updateVehiculo/";

const getActivosUrl = "http://$iPv4:80/api/vehiculos/getAll";
const getActivoEspecificoUrl = "http://$iPv4:80/api/vehiculos/vehiculo/";
