// lib/models/usuario.dart
import 'package:uuid/uuid.dart';

// Clase base para Consumidor y Agricultor
abstract class Usuario {
  final String id;
  String nombre;
  String
      telefono; // Mantenemos el teléfono como dato del usuario, pero NO para login/unicidad
  String correo; // <-- Nuevo campo usado para login y unicidad
  String departamento;
  String ciudad;
  String direccion;
  String contrasenia; // !!! MUY INSEGURO EN TEXTO PLANO !!!

  Usuario({
    String? id,
    required this.nombre,
    required this.telefono,
    required this.correo, // <-- Requerido en el constructor
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
    String? correo, // <-- Incluido en copyWith
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
  });
}
