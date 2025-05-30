import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../../core/string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLogin = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // alineacion vertical
          crossAxisAlignment:
              CrossAxisAlignment.center, // alineacion horizontal
          children: [
            const Spacer(),
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
            const Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: [
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
                          //controller: _passwordController,
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
                              onPressed: () => setState(() =>
                                  _isPasswordVisible = !_isPasswordVisible),
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Mínimo 6 caracteres'
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.profile); //cambair al home
                                },
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.login);
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
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.login);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
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
            const Spacer(),
          ],
        ));
  }
}
