import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../core/routes.dart';
import '../core/colors.dart';
import '../core/string.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //  TextEditingController() me permite obtener o asignar datos en un campo de texto
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameLastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;

  void _register() {
    if (_formKey.currentState!.validate()) {
      // text.trim se usa para eliminar espacios al comienzo y al final de texto.
      final name = _nameLastNameController.text.trim();
      final phone = _phoneController.text.trim();
      final department = _departmentController.text.trim();
      final city = _cityController.text.trim();
      final address = _cityController.text.trim();
      final email = _emailController.text.trim();
      // .text se usa para obtener la entrada del texto
      final password = _passwordController.text;

      // Validacion que los datos se estan obteniendo.
      print('Registrando: $name, $email, $password');
    }
  }

  // Este dispose se usa para liberar la memoria que usaron los controladores, la memoria se libera cuando la vista se cierra
  @override
  void dispose() {
    _nameLastNameController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold es el que organiza elementos en una estructura
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),

        // Form es un contenedor que fluter reconoce como formulario, al envolver los elementos dentro de este contenedor se podran usar metodos especiales para un formulario.
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/icons/agro-inteli-colombia.png',
                height: 190,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppStrings.register,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.nameLastName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _nameLastNameController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Cristian David Chavez Cortes',
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

                validator: (value) =>
                    // Si el campo es valido retorna ingrese su nombre si no entonces retorna null
                    value!.isEmpty ? 'Ingrese su nombre completo' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.phone,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: '3110000000',
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

                validator: (value) =>
                    // Si el campo es valido retorna ingrese su nombre si no entonces retorna null
                    value!.isEmpty ? 'Ingrese su numero de telefono' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.department,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _departmentController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Boyacá',
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
                validator: (value) =>
                    // Si el campo es valido retorna ingrese su nombre si no entonces retorna null
                    value!.isEmpty
                        ? 'Ingrese el departamento donde vive'
                        : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.city,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _cityController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Duitama',
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
                validator: (value) =>
                    // Si el campo es valido retorna ingrese su nombre si no entonces retorna null
                    value!.isEmpty ? 'Ingrese la ciudad donde vive' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.address,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _addressController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Calle 170f #11-23',
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
                validator: (value) =>
                    // Si el campo es valido retorna ingrese su nombre si no entonces retorna null
                    value!.isEmpty ? 'Ingrese la dirección donde vive' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.email,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'email@agrointelicolombia.com',
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
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese su correo';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.password,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
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
              const SizedBox(height: 12),
              Text(
                AppStrings.confirmPassword,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
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
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text)
                    return 'Las contraseñas no coinciden';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.howRegister,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.secondaryColor, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppStrings.consumer,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los botones
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.secondaryColor, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppStrings.farmer,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppStrings.register,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Se usa RichText en este caso ya que permite combinar estilos e incluir enlaces sin romper el flujo del texto.
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  children: [
                    const TextSpan(text: AppStrings.toContinue),
                    TextSpan(
                      text: AppStrings.terms,
                      style: const TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                    ),
                    const TextSpan(text: ' y '),
                    TextSpan(
                      text: AppStrings.policy,
                      style: const TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
