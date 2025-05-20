import 'package:agro_inteli_colombia/dominan/entities/producto.dart';
import 'package:agro_inteli_colombia/dominan/entities/productoCarrito.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CarritoService extends ChangeNotifier {
  //  Lista para almacenar los productos
  final List<ProductoCarrito> _items = [];

  List<ProductoCarrito> get items => List.unmodifiable(_items);

  void addItem(Producto producto, int cantidad) {
    final existingItem = _items.firstWhereOrNull(
      (item) => item.producto.id == producto.id,
    );

    if (existingItem != null) {
      existingItem.cantidad += cantidad;
      print(
          '-> CarritoService: Cantidad actualizada para "${producto.nombre}". Nueva cantidad: ${existingItem.cantidad}');
    } else {
      final newItem = ProductoCarrito(producto: producto, cantidad: cantidad);
      _items.add(newItem);
      print(
          '-> CarritoService: Producto "${producto.nombre}" añadido al carrito.');
    }
    notifyListeners();
  }

  // Elimina un producto
  void removeItem(String productId) {
    final initialLength = _items.length;
    _items.removeWhere((item) => item.producto.id == productId);
    if (_items.length < initialLength) {
      print(
          '-> CarritoService: Producto con ID $productId eliminado del carrito.');
      notifyListeners();
    } else {
      print(
          '-> CarritoService: Producto con ID $productId no encontrado en el carrito.');
    }
  }

  // Actualiza la cantidad del produto
  void updateItemQuantity(String productId, int newQuantity) {
    final itemIndex =
        _items.indexWhere((item) => item.producto.id == productId);
    if (itemIndex != -1) {
      if (newQuantity <= 0) {
        removeItem(productId);
      } else {
        _items[itemIndex].cantidad = newQuantity;
        print(
            '-> CarritoService: Cantidad de "${_items[itemIndex].producto.nombre}" actualizada a $newQuantity.');
        notifyListeners();
      }
    } else {
      print(
          '-> CarritoService: Producto con ID $productId no encontrado en el carrito para actualizar cantidad.');
    }
  }

  // Calcula el subtotal de los productos
  double getSubtotal() {
    return _items.fold(
        0.0, (total, currentItem) => total + currentItem.subtotal);
  }

  // Calcula el total de productos en el carrito
  int getTotalItems() {
    return _items.length;
  }

  // Calcula la cantidad total de productos
  int getTotalQuantity() {
    return _items.fold(0, (total, currentItem) => total + currentItem.cantidad);
  }

  // Simula costos de entrega e impuestos
  double get deliveryCost => 25000.0;
  double get taxRate => 0.19;

  // Calcula el impuesto basado en el subtotal
  double getTax() {
    return getSubtotal() * taxRate;
  }

  // Calcula el precio tota
  double getTotal() {
    return getSubtotal() + deliveryCost + getTax();
  }

  // Limpiar carrito
  void clearCart() {
    _items.clear();
    print('-> CarritoService: Carrito limpiado.');
    notifyListeners();
  }

  void processOrder() {
    if (_items.isEmpty) {
      print(
          '-> CarritoService: El carrito está vacío. No se puede procesar el pedido.');
      return;
    }
    print('-> CarritoService: Procesando pedido con ${_items.length} ítems...');
  }
}
