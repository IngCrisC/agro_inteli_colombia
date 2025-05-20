// lib/services/usuario_management_service.dart
import '../dominan/entities/usuario.dart';
import '../dominan/entities/consumidor.dart';
import '../dominan/entities/agricultor.dart';

extension ListExtensions<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class UsuariotService {
  final List<Consumidor> _consumidores = [];
  final List<Agricultor> _agricultores = [];
  Usuario? _currentUser;

  UsuariotService() {
    _addInitialData();
  }

  void _addInitialData() {
    registrarConsumidor(
      nombre: 'Maria Consumidora',
      telefono: '1112223333',
      correo: 'maria.c@example.com',
      departamento: 'Antioquia',
      ciudad: 'Medellin',
      direccion: 'Apto 101',
      contrasenia: 'consumidor',
    );
    registrarAgricultor(
      nombre: 'Juan Agricultor',
      telefono: '4445556666',
      correo: 'juan.a@example.com',
      departamento: 'Cundinamarca',
      ciudad: 'Fusagasuga',
      direccion: 'Finca El Campo',
      contrasenia: 'agricultor',
      nombreFinca: 'La Huerta Feliz',
    );
  }

  // --- Métodos de usuario ---

  bool _correoExiste(String correo) {
    return _consumidores
            .any((c) => c.correo.toLowerCase() == correo.toLowerCase()) ||
        _agricultores
            .any((a) => a.correo.toLowerCase() == correo.toLowerCase());
  }

  // Registro de consumidor
  Consumidor? registrarConsumidor({
    required String nombre,
    required String telefono,
    required String correo,
    required String departamento,
    required String ciudad,
    required String direccion,
    required String contrasenia,
  }) {
    if (_correoExiste(correo)) {
      print('-> UsuarioService: Error - Correo $correo ya registrado.');
      return null;
    }

    final nuevoConsumidor = Consumidor(
      nombre: nombre,
      telefono: telefono,
      correo: correo,
      departamento: departamento,
      ciudad: ciudad,
      direccion: direccion,
      contrasenia: contrasenia,
    );
    _consumidores.add(nuevoConsumidor);
    print(
        '-> UsuarioService: Consumidor "${nuevoConsumidor.nombre}" registrado con correo ${nuevoConsumidor.correo}.');
    return nuevoConsumidor;
  }

  // Registro de agricultor
  Agricultor? registrarAgricultor({
    required String nombre,
    required String telefono,
    required String correo,
    required String departamento,
    required String ciudad,
    required String direccion,
    required String contrasenia,
    required String nombreFinca,
  }) {
    if (_correoExiste(correo)) {
      print('-> UsuarioService: Error - Correo $correo ya registrado.');
      return null;
    }

    final nuevoAgricultor = Agricultor(
      nombre: nombre,
      telefono: telefono,
      correo: correo,
      departamento: departamento,
      ciudad: ciudad,
      direccion: direccion,
      contrasenia: contrasenia,
      nombreFinca: nombreFinca,
    );
    _agricultores.add(nuevoAgricultor);
    print(
        '-> UsuarioService: Agricultor "${nuevoAgricultor.nombre}" registrado con correo ${nuevoAgricultor.correo}.');
    return nuevoAgricultor;
  }

  // Login
  Usuario? iniciarSesion({
    required String correo,
    required String contrasenia,
  }) {
    final consumidor = _consumidores.firstWhereOrNull(
        (c) => c.correo.toLowerCase() == correo.toLowerCase());
    if (consumidor != null) {
      if (consumidor.contrasenia == contrasenia) {
        _currentUser = consumidor;
        print(
            '-> UsuarioService: Inicio de sesión exitoso para Consumidor ${consumidor.nombre}.');
        return consumidor;
      } else {
        print(
            '-> UsuarioService: Error - Contraseña incorrecta para correo $correo.');
        return null;
      }
    }
    final agricultor = _agricultores.firstWhereOrNull(
        (a) => a.correo.toLowerCase() == correo.toLowerCase());
    if (agricultor != null) {
      if (agricultor.contrasenia == contrasenia) {
        _currentUser = agricultor;
        print(
            '-> UsuarioService: Inicio de sesión exitoso para Agricultor ${agricultor.nombre}.');
        return agricultor;
      } else {
        print(
            '-> UsuarioService: Error - Contraseña incorrecta para correo $correo.');
        return null;
      }
    }
    print('-> UsuarioService: Error - Correo $correo no encontrado.');
    return null;
  }

  // Modificacion del consumidor
  bool editarConsumidor(
    String id, {
    String? nombre,
    String? telefono,
    String? correo,
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
  }) {
    final index = _consumidores.indexWhere((c) => c.id == id);
    if (index != -1) {
      if (correo != null &&
          correo.toLowerCase() != _consumidores[index].correo.toLowerCase() &&
          _correoExiste(correo)) {
        print(
            '-> UsuarioService: Error al editar Consumidor - El correo $correo ya está en uso.');
        return false;
      }

      _consumidores[index] = _consumidores[index].copyWith(
        nombre: nombre,
        telefono: telefono,
        correo: correo,
        departamento: departamento,
        ciudad: ciudad,
        direccion: direccion,
        contrasenia: contrasenia,
      );
      print('-> UsuarioService: Consumidor con ID $id editado.');
      return true;
    }
    print(
        '-> UsuarioService: Error - Consumidor con ID $id no encontrado para editar.');
    return false;
  }

  // Edicion del agricultor
  bool editarAgricultor(
    String id, {
    String? nombre,
    String? telefono,
    String? correo,
    String? departamento,
    String? ciudad,
    String? direccion,
    String? contrasenia,
    String? nombreFinca,
  }) {
    final index = _agricultores.indexWhere((a) => a.id == id);
    if (index != -1) {
      if (correo != null &&
          correo.toLowerCase() != _agricultores[index].correo.toLowerCase() &&
          _correoExiste(correo)) {
        print(
            '-> UsuarioService: Error al editar Agricultor - El correo $correo ya está en uso.');
        return false;
      }

      _agricultores[index] = _agricultores[index].copyWith(
        nombre: nombre,
        telefono: telefono,
        correo: correo,
        departamento: departamento,
        ciudad: ciudad,
        direccion: direccion,
        contrasenia: contrasenia,
        nombreFinca: nombreFinca,
      );
      print('-> UsuarioService: Agricultor con ID $id editado.');
      return true;
    }
    print(
        '-> UsuarioService: Error - Agricultor con ID $id no encontrado para editar.');
    return false;
  }

  // buscar usuario
  Usuario? getUsuarioById(String id) {
    final consumidor = _consumidores.firstWhereOrNull((c) => c.id == id);
    if (consumidor != null) return consumidor;

    final agricultor = _agricultores.firstWhereOrNull((a) => a.id == id);
    return agricultor;
  }

  // busca usuario por correo
  Usuario? getUsuarioByCorreo(String correo) {
    final consumidor = _consumidores.firstWhereOrNull(
        (c) => c.correo.toLowerCase() == correo.toLowerCase());
    if (consumidor != null) return consumidor;

    final agricultor = _agricultores.firstWhereOrNull(
        (a) => a.correo.toLowerCase() == correo.toLowerCase());
    return agricultor;
  }

  List<Usuario> getAllUsuarios() {
    return [..._consumidores, ..._agricultores];
  }

// obtiener todos los consumidores
  List<Consumidor> getAllConsumidores() => List.from(_consumidores);

// obtiener todos los agricultores
  List<Agricultor> getAllAgricultores() => List.from(_agricultores);

// elimina a un usuario  por el id
  bool eliminarUsuario(String id) {
    final initialConsumidorLength = _consumidores.length;
    _consumidores.removeWhere((c) => c.id == id);
    if (_consumidores.length < initialConsumidorLength) {
      print('-> UsuarioService: Consumidor con ID $id eliminado.');
      return true;
    }

    final initialAgricultorLength = _agricultores.length;
    _agricultores.removeWhere((a) => a.id == id);
    if (_agricultores.length < initialAgricultorLength) {
      print('-> UsuarioService: Agricultor con ID $id eliminado.');
      return true;
    }

    print('-> UsuarioService: Usuario con ID $id no encontrado para eliminar.');
    return false;
  }

  Usuario? get currentUser => _currentUser;
}
