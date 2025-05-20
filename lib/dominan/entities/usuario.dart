import 'package:uuid/uuid.dart';

abstract class Usuario {
  final String id;
  String nombre;
  String telefono;
  String correo;
  String departamento;
  String ciudad;
  String direccion;
  String contrasenia;

  Usuario({
    String? id,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.departamento,
    required this.ciudad,
    required this.direccion,
    required this.contrasenia,
  }) : this.id = id ?? const Uuid().v4();

  String get rol;

  Usuario copyWith({
    String? id,
    String? nombre,
    String? telefono,
    String? correo,
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
  });
}
