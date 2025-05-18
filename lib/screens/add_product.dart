import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../core/routes.dart';
import '../core/colors.dart';
import '../core/string.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // controlador para imagen
  File? _imageFile;

  //  TextEditingController() me permite obtener o asignar datos en un campo de texto
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameProductController = TextEditingController();
  final TextEditingController _unitOfMeasurementController =
      TextEditingController();
  final TextEditingController _pricePerUnitController = TextEditingController();
  final TextEditingController _quantityAvailableController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _uploadProduct() async {
    if (_formKey.currentState!.validate()) {
      // text.trim se usa para eliminar espacios al comienzo y al final de texto.
      final nameProduct = _nameProductController.text.trim();
      final unit = _unitOfMeasurementController.text.trim();
      final price = _pricePerUnitController.text.trim();
      final quantityAvailable = _quantityAvailableController.text.trim();
      final description = _descriptionController.text.trim();
      final imagePath = _imageFile?.path ?? '';
      // .text se usa para obtener la entrada del texto
      final newProduct = {
        'name': nameProduct,
        'unit': unit,
        'price': price,
        'quantity': quantityAvailable,
        'description': description,
        'imagePath': imagePath,
      };
      final prefs = await SharedPreferences.getInstance();

      // Obtener la lista actual de productos
      final productListString = prefs.getString('productList');
      List<dynamic> productList = [];

      if (productListString != null) {
        productList = jsonDecode(productListString);
      }

      // Añadir el nuevo producto
      productList.add(newProduct);

      // Guardar de nuevo la lista actualizada
      await prefs.setString('productList', jsonEncode(productList));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto guardado localmente')),
      );

      // Opcional: limpiar los campos
      _nameProductController.clear();
      _unitOfMeasurementController.clear();
      _pricePerUnitController.clear();
      _quantityAvailableController.clear();
      _descriptionController.clear();
      setState(() {
        _imageFile = null;
      });
    }
  }

  Future<void> _uploadAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No se seleccionó ninguna imagen');
      return;
    }

    final tempImage = File(pickedFile.path);

    // Obtener el directorio local de almacenamiento
    final directory = await getApplicationDocumentsDirectory();
    final imageName = path.basename(pickedFile.path);
    final savedImagePath = path.join(directory.path, imageName);

    final savedImage = await tempImage.copy(savedImagePath);

    setState(() {
      _imageFile = savedImage;
    });

    print("Imagen guardada localmente en: $savedImagePath");
  }

  // Este dispose se usa para liberar la memoria que usaron los controladores, la memoria se libera cuando la vista se cierra
  @override
  void dispose() {
    _nameProductController.dispose();
    _unitOfMeasurementController.dispose();
    _pricePerUnitController.dispose();
    _quantityAvailableController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold es el que organiza elementos en una estructura
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/Home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),

        // Form es un contenedor que fluter reconoce como formulario, al envolver los elementos dentro de este contenedor se podran usar metodos especiales para un formulario.
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                AppStrings.addProduct,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                AppStrings.nameByProduct,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _nameProductController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Naranja tangelo',
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
                    value!.isEmpty ? 'Ingrese el nombre del producto' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.unitOfMeasurement,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para nombre
                controller: _unitOfMeasurementController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'kg',
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
                    // Si el campo no es valido retorna ingrese unidad de medida si no entonces retorna null
                    value!.isEmpty ? 'Ingrese unidad de medida' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.pricePerUnit,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para precio
                controller: _pricePerUnitController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: "120.000",
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
                    // Si el campo es valido retorna ingrese el precio de su producto si no retorna null
                    value!.isEmpty ? 'Ingrese el precio de su producto' : null,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.quantityAvailable,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                // Campo para descripcion
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: '400 kg',
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
                    // Si el campo no es valido retorna Ingrese la cantidad de su producto si no entonces retorna null
                    value!.isEmpty
                        ? 'Ingrese la cantidad de su producto'
                        : null,
              ),
              const SizedBox(height: 12),
              // Campo para descripción
              Text(
                AppStrings.description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.ignoreColor,
                      fontWeight: FontWeight.w400),
                  hintText: 'Naranja cosechada en Paime',
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
                    // Si el campo no es valido retorna Ingrese la descripcion de su producto si no entonces retorna null
                    value!.isEmpty
                        ? 'Ingrese la descripcion de su producto'
                        : null,
              ),
              const SizedBox(height: 12),
              // Texto imagen
              Text(
                AppStrings.image,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload, color: Colors.black),
                      onPressed: _uploadAndSaveImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ignoreColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: Text(
                        AppStrings.uploadImageByDevice,
                        style: TextStyle(
                          color: Colors.black,
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
                      onPressed: _uploadProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppStrings.addProduct,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
