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
import 'package:agro_inteli_colombia/screens/add_product.dart';
import 'package:agro_inteli_colombia/screens/home_farmer.dart';
import 'package:provider/provider.dart';
import 'package:agro_inteli_colombia/screens/order.dart';
import 'package:agro_inteli_colombia/screens/cart_product.dart';
import 'package:agro_inteli_colombia/dominan/entities/producto.dart';
import 'package:agro_inteli_colombia/screens/product_detail_screen.dart';
import 'package:agro_inteli_colombia/services/carritoService.dart';

void main() {
  final UsuariotService usuarioService = UsuariotService();
  final ProductoService productoService = ProductoService(usuarioService);
  final CarritoService carritoService = CarritoService();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => carritoService,
      child: MainApp(
        usuarioService: usuarioService,
        productoService: productoService,
        carritoService: carritoService,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final UsuariotService usuarioService;
  final ProductoService productoService;
  final CarritoService carritoService;

  const MainApp(
      {super.key,
      required this.usuarioService,
      required this.productoService,
      required this.carritoService});

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
        Routes.profile: (context) =>
            ProfileScreen(usuarioService: usuarioService),
        Routes.HomeC: (context) => HomeConsumer(
              productoService: productoService,
              usuarioService: usuarioService,
            ),
        Routes.geoMap: (context) => GeoMapScreen(),
        Routes.addProduct: (context) => AddProductScreen(),
        Routes.homeFarmer: (context) => HomeFarmer(),
        Routes.order: (context) => OrderScreen(),
        Routes.cartDetail: (context) => CartScreen()
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.productDetail) {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args != null &&
              args['product'] is Producto &&
              args['usuarioService'] is UsuariotService) {
            final Producto product = args['product'];
            final UsuariotService userSvc = args['usuarioService'];
            return MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(
                  product: product,
                  usuarioService: userSvc,
                  carritoService: carritoService,
                );
              },
            );
          }
          return MaterialPageRoute(
              builder: (context) => HomeConsumer(
                    productoService: productoService,
                    usuarioService: usuarioService,
                  ));
        }

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
