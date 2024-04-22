// const url = 'http://{IPv4}:3000/';

const iPv4 = "192.168.1.13"; //IP de la máquina donde está corriendo la APP

const registrationUrl = "http://$iPv4:80/api/users/newUser";
const loginUrl = "http://$iPv4:80/api/users/user";
const registrarActivoUrl = "http://$iPv4:80/api/vehiculos/newVehiculo";
const getActivosUrl = "http://$iPv4:80/api/vehiculos/getAll";
const getActivoEspecificoUrl = "http://$iPv4:80/api/vehiculos/vehiculo/";
