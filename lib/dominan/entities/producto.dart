import 'package:uuid/uuid.dart';

class Producto {
  final String id;
  final String agricultorId;
  String nombre;
  String unidadMedida;
  int precioUnidad;
  int cantidad;
  String descripcion;
  String categoria;
  String imagen;
  bool estado;

  Producto({
    String? id,
    required this.agricultorId,
    required this.nombre,
    required this.unidadMedida,
    required this.precioUnidad,
    required this.cantidad,
    this.descripcion = '',
    required this.categoria,
    required this.imagen,
    bool this.estado = true,
  }) : this.id = id ?? const Uuid().v4();

  Producto copyWith({
    String? id,
    String? agricultorId,
    String? nombre,
    String? unidadMedida,
    int? precioUnidad,
    int? cantidad,
    String? descripcion,
    String? categoria,
    String? imagen,
    bool? estado,
  }) {
    return Producto(
      id: id ?? this.id,
      agricultorId: agricultorId ?? this.agricultorId,
      nombre: nombre ?? this.nombre,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      precioUnidad: precioUnidad ?? this.precioUnidad,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      imagen: imagen ?? this.imagen,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agricultorId': agricultorId,
      'nombre': nombre,
      'unidadMedida': unidadMedida,
      'precioUnidad': precioUnidad,
      'cantidad': cantidad,
      'descripcion': descripcion,
      'categoria': categoria,
      'imagen': imagen,
      'estado': estado,
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      agricultorId: map['agricultorId'],
      nombre: map['nombre'],
      unidadMedida: map['unidadMedida'],
      precioUnidad: map['precioUnidad'],
      cantidad: map['cantidad'],
      descripcion: map['descripcion'],
      categoria: map['categoria'],
      imagen: map['imagen'],
      estado: map['estado'],
    );
  }
}
