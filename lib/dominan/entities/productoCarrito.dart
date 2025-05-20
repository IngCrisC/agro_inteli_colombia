import 'package:agro_inteli_colombia/dominan/entities/producto.dart';
import 'package:uuid/uuid.dart';

class ProductoCarrito {
  final String id;
  final Producto producto;
  int cantidad;

  ProductoCarrito({
    String? id,
    required this.producto,
    required this.cantidad,
  }) : this.id = id ?? const Uuid().v4();

  ProductoCarrito copyWith({
    int? cantidad,
  }) {
    return ProductoCarrito(
      id: this.id,
      producto: this.producto,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  double get subtotal => cantidad * producto.precioUnidad.toDouble();
}
