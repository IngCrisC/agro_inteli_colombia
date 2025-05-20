import 'package:agro_inteli_colombia/screens/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../../core/string.dart';
import '../services/usuario_service.dart';
import '../dominan/entities/usuario.dart';

class LoginScreen extends StatefulWidget {
  final UsuariotService usuarioService;
  const LoginScreen({Key? key, required this.usuarioService}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  bool _isLoading = false;

  Future<void> handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            ));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al iniciar sesión'),
      ));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  final _formLogin = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _loginMessage = '';
  Usuario? _loggedInUser;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() {
    if (_formLogin.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = widget.usuarioService.iniciarSesion(
        correo: email,
        contrasenia: password,
      );

      setState(() {
        _loggedInUser = user;
        if (user != null) {
          _loginMessage =
              '¡Inicio de sesión exitoso! Bienvenido, ${user.nombre}';
          if (user.rol == 'consumidor') {
            Navigator.of(context).pushReplacementNamed(Routes.HomeC);
          } else if (user.rol == 'agricultor') {
            print('Login de agricultor exitoso. Navegar a HomeA');
            Navigator.of(context).pushReplacementNamed(Routes.HomeC);
          } else {
            _loginMessage = 'Login exitoso, pero rol desconocido: ${user.rol}';
            Navigator.of(context).pushReplacementNamed(Routes.HomeC);
          }
        } else {
          _loginMessage = 'Correo o contraseña incorrectos.';
        }
      });
    } else {
      setState(() {
        _loginMessage = 'Por favor, ingresa todos los datos.';
        _loggedInUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioService = widget.usuarioService;
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/icons/agro-inteli-colombia.png',
                  height: 190,
                  width: 190,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.welcome,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formLogin,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.email,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        // Campo para nombre
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: AppColors.ignoreColor,
                              fontWeight: FontWeight.w400),
                          hintText: 'ejemplo@ejemplo.com',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AppColors.thirdColor,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AppColors.thirdColor,
                            width: 2,
                          )),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Ingrese su correo';
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value))
                            return 'Correo inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.password,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: AppColors.ignoreColor,
                              fontWeight: FontWeight.w400),
                          hintText: '*************',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AppColors.thirdColor,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.thirdColor,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible),
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) => value != null && value.length < 6
                            ? 'Mínimo 6 caracteres'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _performLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                AppStrings.login,
                                style: TextStyle(
                                  color: AppColors.background,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _loginMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _loggedInUser != null
                        ? Colors.green
                        : Colors.red, // Color según el resultado
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.HomeC);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          AppStrings.restore,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('O'),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: handleGoogleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 20),
                            Text(
                              AppStrings.google,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              Routes.register); //cambair al home
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                              color: AppColors.secondaryColor, width: 3),
                        ),
                        child: Text(
                          AppStrings.register,
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ])),
        ));
  }
}
