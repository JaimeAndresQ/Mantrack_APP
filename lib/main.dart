import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/activos_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/ordenes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/planes_provider.dart';
import 'package:mantrack_app/src/features/authentication/controller/provider/token_provider.dart';
import 'package:mantrack_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:mantrack_app/src/utils/theme.dart';
import 'src/features/authentication/controller/provider/dashboard_provider.dart';
import 'src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  
  // Garantiza que los widgets estén inicializados antes de ejecutar la aplicación.
  WidgetsFlutterBinding.ensureInitialized();

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Llamar al método verificarTokenU() y esperar su resultado
  String? token = await tokenProvider.getTokenU();


  runApp(App(
    token: token,
  ));
}

class App extends StatelessWidget {
  final String? token;

  const App({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedDashboardProvider>(
          create: (_) => SelectedDashboardProvider(),
        ),
        ChangeNotifierProvider<TokenProvider>(
          create: (_) => TokenProvider(), 
        ),
        ChangeNotifierProvider<ActivosProvider>(
          create: (_) => ActivosProvider(),
        ),
        ChangeNotifierProvider<PlanesProvider>(
          create: (_) => PlanesProvider(), 
        ),
        ChangeNotifierProvider<OrdenesProvider>(
          create: (_) => OrdenesProvider(), 
        ),
      ],
      child: GetMaterialApp(
        scrollBehavior: MyBehavior(), // Quita el effecto azulejo al hacer un overscroll
        initialRoute: (token != null) ? 'dashboard' : '/',
        routes: {
          '/': (context) => const OnBoardingScreen(),
          'welcome': (context) => const WelcomeScreen(),
          'dashboard': (context) => DashboardScreen(
                token: token,
              ),
        },
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
}