import 'package:agro_inteli_colombia/screens/Home_consumer.dart';
import 'package:flutter/material.dart';
import 'package:agro_inteli_colombia/screens/splash_screen.dart';
import 'package:agro_inteli_colombia/screens/record_screen.dart';
import 'package:agro_inteli_colombia/screens/login_screen.dart';
import 'package:agro_inteli_colombia/screens/profile_screen.dart';
import 'package:agro_inteli_colombia/core/string.dart';
import 'package:agro_inteli_colombia/core/routes.dart';
import 'package:agro_inteli_colombia/screens/add_product.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // se usa para inicilizar canales nativos
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.nameApp,
      initialRoute: Routes.addProduct,
      routes: {
        // Routes.splash: (context) => const SplashScreen(),
        // Routes.register: (context) => const RegisterScreen(),
        // Routes.login: (context) => const LoginScreen(),
        // Routes.profile: (context) => const ProfileScreen(),
        // Routes.HomeC: (context) => HomeConsumer(),
        Routes.addProduct: (context) => AddProductScreen()
      },
    );
  }
}
