import 'package:agro_inteli_colombia/screens/Home_consumer.dart';
import 'package:flutter/material.dart';
import 'package:agro_inteli_colombia/screens/splash_screen.dart';
import 'package:agro_inteli_colombia/screens/record_screen.dart';
import 'package:agro_inteli_colombia/screens/login_screen.dart';
import 'package:agro_inteli_colombia/screens/profile_screen.dart';
import 'package:agro_inteli_colombia/screens/map_screen.dart';
import 'package:agro_inteli_colombia/core/string.dart';
import 'package:agro_inteli_colombia/core/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:agro_inteli_colombia/services/usuario_service.dart';
import 'package:agro_inteli_colombia/services/producto_service.dart';

void main() {
  final UsuariotService usuarioService = UsuariotService();
  final ProductoService productoService = ProductoService(usuarioService);
  runApp(MainApp(
    usuarioService: usuarioService,
    productoService: productoService,
  ));
}

class MainApp extends StatelessWidget {
  final UsuariotService usuarioService;
  final ProductoService productoService;

  const MainApp(
      {super.key, required this.usuarioService, required this.productoService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.nameApp,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.register: (context) => const RegisterScreen(),
        Routes.login: (context) => LoginScreen(usuarioService: usuarioService),
        Routes.profile: (context) => const ProfileScreen(),
        Routes.HomeC: (context) =>
            HomeConsumer(productoService: productoService),
        Routes.geoMap: (context) => GeoMapScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/inicio') {
          final args = settings.arguments as GoogleSignInAccount?;
          return MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          });
        }
      },
    );
  }
}
