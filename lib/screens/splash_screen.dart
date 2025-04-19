import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // se establece que espere 5 segundos y luego pase a la vista home
      Navigator.of(context).pushReplacementNamed(Routes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // color de fondo
      body: Stack(
        children: [
          Center(
            // centrar elementos
            child: Column(
              // elemento hijo tipo columna
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/agro-inteli-colombia.png',
                  width: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
