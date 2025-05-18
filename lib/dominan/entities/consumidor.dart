// lib/models/consumidor.dart
import 'usuario.dart'; // Importa la clase base

class Consumidor extends Usuario {
  Consumidor({
    String? id,
    required String nombre,
    required String telefono,
    required String correo, // <-- Recibe correo
    required String departamento,
    required String ciudad,
    required String direccion,
    required String contrasenia,
  }) : super(
          id: id,
          nombre: nombre,
          telefono: telefono,
          correo: correo, // <-- Pasa correo al constructor base
          departamento: departamento,
          ciudad: ciudad,
          direccion: direccion,
          contrasenia: contrasenia,
        );

  @override
  String get rol => 'consumidor';

  @override
  Consumidor copyWith({
    String? id,
    String? nombre,
    String? telefono,
    String? correo, // <-- Incluido en copyWith
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
  }) {
    return Consumidor(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo, // <-- Copia correo
      departamento: departamento ?? this.departamento,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      contrasenia: contrasenia ?? this.contrasenia,
    );
  }
}
