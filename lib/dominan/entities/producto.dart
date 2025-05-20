import 'package:uuid/uuid.dart';

class Producto {
  final String id;
  final String agricultorId;
  String nombre;
  String unidadMedida;
  String precioUnidad;
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
    String? unidadMedida, // Comentario: Añadido
    String? precioUnidad, // Comentario: Nombre y tipo cambiados
    int? cantidad, // Comentario: Nombre cambiado
    String? descripcion,
    String? categoria, // Comentario: Añadido
    String? imagen, // Comentario: Nombre cambiado
    bool? estado, // Comentario: Añadido
  }) {
    return Producto(
      id: id ?? this.id,
      agricultorId: agricultorId ?? this.agricultorId,
      nombre: nombre ?? this.nombre,
      unidadMedida: unidadMedida ?? this.unidadMedida, // Comentario: Añadido
      precioUnidad: precioUnidad ??
          this.precioUnidad, // Comentario: Nombre y tipo cambiados
      cantidad: cantidad ?? this.cantidad, // Comentario: Nombre cambiado
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria, // Comentario: Añadido
      imagen: imagen ?? this.imagen, // Comentario: Nombre cambiado
      estado: estado ?? this.estado, // Comentario: Añadido
    );
  }

  // Comentario: Método toMap actualizado para incluir todos los campos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agricultorId': agricultorId,
      'nombre': nombre,
      'unidadMedida': unidadMedida, // Comentario: Añadido
      'precioUnidad': precioUnidad, // Comentario: Nombre cambiado
      'cantidad': cantidad, // Comentario: Nombre cambiado
      'descripcion': descripcion,
      'categoria': categoria, // Comentario: Añadido
      'imagen': imagen, // Comentario: Nombre cambiado
      'estado': estado, // Comentario: Añadido
    };
  }

  // Comentario: Método fromMap actualizado para incluir todos los campos
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      agricultorId: map['agricultorId'],
      nombre: map['nombre'],
      unidadMedida: map['unidadMedida'], // Comentario: Añadido
      precioUnidad: map['precioUnidad'], // Comentario: Nombre cambiado
      cantidad: map['cantidad'], // Comentario: Nombre cambiado
      descripcion: map['descripcion'],
      categoria: map['categoria'], // Comentario: Añadido
      imagen: map['imagen'], // Comentario: Nombre cambiado
      estado: map['estado'], // Comentario: Añadido
    );
  }
}
