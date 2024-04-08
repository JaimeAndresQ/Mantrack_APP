import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:mantrack_app/src/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'src/features/authentication/screens/on_boarding/on_boarding_screen.dart';

void main() async {

  // Garantiza que los widgets estén inicializados antes de ejecutar la aplicación.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la instancia de SharedPreferences para acceder a los datos almacenados en la aplicación.
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Obtiene el token almacenado en SharedPreferences.
  String? tokenActual = prefs.getString('token');
  print(prefs.getString('token'));

  // Verificar si el token está presente y está expirado
  if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
    // Borrar el token si está expirado
    await prefs.remove('token');
    print('Token expirado. Se ha eliminado.');
  }

  runApp(App(token: tokenActual,));
}

class App extends StatelessWidget {

  final String? token;
  
  const App({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: (token != null) ? 'dashboard' : '/',
      routes: {
        '/': (context) => const OnBoardingScreen(),
        'welcome': (context) => const WelcomeScreen(),
        'dashboard': (context) => DashboardScreen(token: token,),
      },
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
