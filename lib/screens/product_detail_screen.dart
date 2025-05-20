import 'package:agro_inteli_colombia/dominan/entities/producto.dart';
import 'package:agro_inteli_colombia/services/usuario_service.dart';
import 'package:flutter/material.dart';
import '../dominan/entities/usuario.dart';
import '../core/colors.dart';
import '../core/string.dart';
import 'package:provider/provider.dart';
import 'package:agro_inteli_colombia/services/carritoService.dart';

class ProductDetailScreen extends StatefulWidget {
  final Producto product;
  final UsuariotService usuarioService;
  final CarritoService carritoService;

  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.usuarioService,
    required this.carritoService,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedQuantity = 1;
  Usuario? _agricultor;

  @override
  void initState() {
    super.initState();
    _agricultor =
        widget.usuarioService.getUsuarioById(widget.product.agricultorId);
  }

  void _incrementQuantity() {
    if (_selectedQuantity < widget.product.cantidad) {
      setState(() {
        _selectedQuantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_selectedQuantity > 1) {
      setState(() {
        _selectedQuantity--;
      });
    }
  }

  // calcular el precio total
  double _calculateTotal() {
    return _selectedQuantity * widget.product.precioUnidad.toDouble();
  }

  //  agregar al carrito
  void _addToCart() {
    final carritoService = Provider.of<CarritoService>(context, listen: false);
    print(
        'Producto "${widget.product.nombre}" agregado al carrito: $_selectedQuantity unidades.');
    carritoService.addItem(widget.product, _selectedQuantity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '"${widget.product.nombre}" x$_selectedQuantity agregado al carrito!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_agricultor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalles del Producto')),
        body: const Center(
            child: Text('Error: Información del agricultor no disponible.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.nombre),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              widget.product.imagen,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported,
                      size: 80, color: Colors.grey[600]),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            '${widget.product.cantidad} ${widget.product.unidadMedida}s Disponibles',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '\$${widget.product.precioUnidad.toString()} / ${widget.product.unidadMedida}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Descripción',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.product.descripcion,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Información del agricultor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Agricultor: ${_agricultor!.nombre}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Ubicación: ${_agricultor!.direccion}, ${_agricultor!.ciudad}, ${_agricultor!.departamento}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Teléfono: ${_agricultor!.telefono}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Agregar al carrito de compras',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrementQuantity,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      _selectedQuantity.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _incrementQuantity,
                  ),
                ],
              ),
              Text(
                'Total: \$${_calculateTotal().toStringAsFixed(_calculateTotal() % 1 == 0 ? 0 : 2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Agregar al carrito',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
