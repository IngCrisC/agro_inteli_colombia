// lib/screens/cart_screen.dart
import 'package:agro_inteli_colombia/dominan/entities/productoCarrito.dart';
import 'package:agro_inteli_colombia/services/carritoService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, Routes.HomeC);
          } else if (index == 1) {
            Navigator.pushNamed(context, Routes.cartDetail);
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
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.black,
      ),
      body: Consumer<CarritoService>(
        builder: (context, carritoService, child) {
          if (carritoService.items.isEmpty) {
            return const Center(
              child: Text(
                'El carrito está vacío.',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            );
          }
          return ListView(
            children: [
              _buildCartInfoSection(context),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Productos (${carritoService.getTotalItems()})',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: carritoService.items.length,
                itemBuilder: (context, index) {
                  final item = carritoService.items[index];
                  return _buildCartItem(context, item, carritoService);
                },
              ),
              const Divider(),
              _buildOrderSummary(context, carritoService),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    carritoService.processOrder();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Hacer Pedido',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Envio', 'calle 122 f No 13-24'),
          _buildInfoRow(
              'Entrega', '\$${CarritoService().deliveryCost.toString()}'),
          _buildInfoRow('Pago', 'Contraentrega'),
          _buildInfoRow('Empresa', 'Restaurante La buena mesa'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Icon(Icons.chevron_right, size: 20, color: Colors.black54),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, ProductoCarrito item,
      CarritoService carritoService) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                item.producto.imagen,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported,
                        size: 30, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.producto.nombre,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${item.cantidad} ${item.producto.unidadMedida}s',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              carritoService.updateItemQuantity(
                                  item.producto.id, item.cantidad - 1);
                            },
                            child: Icon(Icons.remove_circle_outline,
                                size: 22, color: AppColors.secondaryColor),
                          ),
                          SizedBox(width: 8),
                          Text(item.cantidad.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              if (item.cantidad < item.producto.cantidad) {
                                carritoService.updateItemQuantity(
                                    item.producto.id, item.cantidad + 1);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'No hay más stock disponible de ${item.producto.nombre}')),
                                );
                              }
                            },
                            child: Icon(Icons.add_circle_outline,
                                size: 22, color: AppColors.secondaryColor),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          carritoService.removeItem(item.producto.id);
                        },
                        child: Icon(Icons.delete_outline,
                            size: 22, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '\$${item.subtotal.toStringAsFixed(item.subtotal % 1 == 0 ? 0 : 2)}', // Muestra el subtotal del ítem formateado
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(
      BuildContext context, CarritoService carritoService) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Subtotal (${carritoService.getTotalItems()})',
              carritoService.getSubtotal()),
          _buildSummaryRow('Entrega total', carritoService.deliveryCost),
          _buildSummaryRow('Impuestos', carritoService.getTax()),
          const SizedBox(height: 8.0),
          _buildSummaryRow('Total', carritoService.getTotal(), isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black87,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(value % 1 == 0 ? 0 : 2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.secondaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
