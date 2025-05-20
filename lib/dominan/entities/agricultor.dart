import 'usuario.dart';

class Agricultor extends Usuario {
  String nombreFinca;

  Agricultor({
    String? id,
    required String nombre,
    required String telefono,
    required String correo,
    required String departamento,
    required String ciudad,
    required String direccion,
    required String contrasenia,
    required this.nombreFinca,
  }) : super(
          id: id,
          nombre: nombre,
          telefono: telefono,
          correo: correo,
          departamento: departamento,
          ciudad: ciudad,
          direccion: direccion,
          contrasenia: contrasenia,
        );

  @override
  String get rol => 'agricultor';

  @override
  Agricultor copyWith({
    String? id,
    String? nombre,
    String? telefono,
    String? correo,
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
    String? nombreFinca,
  }) {
    return Agricultor(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      departamento: departamento ?? this.departamento,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      contrasenia: contrasenia ?? this.contrasenia,
      nombreFinca: nombreFinca ?? this.nombreFinca,
    );
  }
}
