// lib/services/producto_service.dart
import '../dominan/entities/producto.dart';
import '../dominan/entities/usuario.dart'; // Asegúrate que esta ruta es correcta para tu clase Usuario
import 'usuario_service.dart'; // Asegúrate que esta ruta es correcta para tu UsuarioManagementService (o UsuariotService)
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart'; // Comentario: Importa el paquete collection para firstWhereOrNull (si no lo tienes, añade la dependencia)

class ProductoService {
  // Lista para almacenar los productos
  final List<Producto> _productos = [];

  // Dependencia del servicio de usuarios para validaciones
  final UsuariotService
      _usuarioService; // Asegúrate que UsuariotService es el nombre correcto

  // Constructor que recibe la instancia del servicio de usuarios
  ProductoService(this._usuarioService) {
    // Añadir algunos datos iniciales de ejemplo
    _addInitialData();
  }

  void _addInitialData() {
    // Busca un agricultor existente por su correo para añadir productos
    // Asegúrate de que los datos iniciales en UsuarioService ya crearon un agricultor con este correo
    final agricultor = _usuarioService.getUsuarioByCorreo(
        'juan.a@example.com'); // Comentario: Usamos getUsuarioByCorreo para encontrar el agricultor "quemado"

    if (agricultor != null && agricultor.rol == 'agricultor') {
      // Comentario: Los productos de ejemplo ahora usan los nuevos campos y nombres
      addProducto(
        agricultor.id, // agricultorId
        'Tomates Rojiros', // nombre
        'Kilogramo', // Comentario: unidadMedida (nuevo)
        5500, // Comentario: precioUnidad (nombre y tipo cambiados, valor de ejemplo en COP)
        100, // Comentario: cantidad (nombre cambiado)
        'Tomates frescos y orgánicos, cultivados localmente.', // descripcion (actualizada)
        'Vegetales', // Comentario: categoria (nuevo)
        'assets/icons/tomate.png', // Comentario: imagen (nombre cambiado)
        true, // Comentario: estado (nuevo, true por defecto)
      );
      addProducto(
        agricultor.id, // agricultorId
        'Papas Criollas', // nombre
        'Kilogramo', // Comentario: unidadMedida (nuevo)
        7800, // Comentario: precioUnidad (nombre y tipo cambiados, valor de ejemplo en COP)
        150, // Comentario: cantidad (nombre cambiado)
        'Papas criollas pequeñas y sabrosas, ideales para freír.', // descripcion (actualizada)
        'Tuberculos', // Comentario: categoria (nuevo)
        'assets/icons/Papa.jpg', // Comentario: imagen (nombre cambiado)
        true, // Comentario: estado (nuevo, true por defecto)
      );
      print('--- Productos iniciales agregados por ${agricultor.nombre} ---');
      print('Total productos: ${_productos.length}');
      // Comentario: Opcional: Imprimir detalles de los productos
      // _productos.forEach((p) => print(' - ${p.nombre} (${p.categoria}) - ${p.cantidad} ${p.unidadMedida} a \$${p.precioUnidad}'));
      print('---');
    } else {
      print(
          '--- No se pudo añadir datos iniciales de productos: Agricultor "juan.a@example.com" no encontrado o no es un agricultor válido ---');
    }
  }

  // --- Métodos para la gestión de Productos ---

  // Comentario: El método addProducto ahora recibe los nuevos parámetros
  Producto? addProducto(
      String agricultorId,
      String nombre,
      String unidadMedida, // Comentario: Nuevo parámetro
      int precioUnidad, // Comentario: Nombre y tipo cambiados
      int cantidad, // Comentario: Nombre cambiado
      String descripcion,
      String categoria, // Comentario: Nuevo parámetro
      String imagen, // Comentario: Nombre cambiado
      bool estado // Comentario: Nuevo parámetro
      ) {
    // Validar que el agricultorId pertenezca a un usuario con rol 'agricultor'
    final agricultor = _usuarioService.getUsuarioById(agricultorId);
    if (agricultor == null || agricultor.rol != 'agricultor') {
      print(
          '-> ProductoService: Error - Usuario con ID $agricultorId no encontrado o no es un agricultor válido para añadir producto.');
      return null; // No permite añadir el producto si el agricultor no es válido
    }

    // Crear la instancia del nuevo producto con todos los campos
    final nuevoProducto = Producto(
      agricultorId: agricultorId,
      nombre: nombre,
      unidadMedida: unidadMedida, // Comentario: Añadido
      precioUnidad: precioUnidad, // Comentario: Nombre y tipo cambiados
      cantidad: cantidad, // Comentario: Nombre cambiado
      descripcion: descripcion,
      categoria: categoria, // Comentario: Añadido
      imagen: imagen, // Comentario: Nombre cambiado
      estado: estado, // Comentario: Añadido
    );

    // Añadir el producto a la lista
    _productos.add(nuevoProducto);
    print(
        '-> ProductoService: Producto "${nuevoProducto.nombre}" añadido por Agricultor ID ${agricultorId}.');
    // Si usaras ChangeNotifier, notificarías aquí.
    return nuevoProducto; // Retorna el producto añadido
  }

  // Comentario: Obtiene una copia de la lista de todos los productos
  List<Producto> getAllProductos() {
    return List.from(
        _productos); // Retorna una copia para evitar modificaciones externas directas
  }

  // Comentario: Obtiene una lista de productos vendidos por un agricultor específico
  List<Producto> getProductosByAgricultor(String agricultorId) {
    return _productos
        .where((p) => p.agricultorId == agricultorId)
        .toList(); // Filtra por agricultorId
  }

  // Comentario: Busca un producto por su ID
  Producto? getProductoById(String id) {
    return _productos.firstWhereOrNull((p) =>
        p.id ==
        id); // Usa firstWhereOrNull para evitar excepciones si no se encuentra
    // El catch ya no es necesario si usas firstWhereOrNull
  }

  // Comentario: El método updateProducto ahora acepta parámetros para todos los campos modificables
  bool updateProducto(String id,
      {String? nombre,
      String? unidadMedida, // Comentario: Añadido
      int? precioUnidad, // Comentario: Nombre y tipo cambiados
      int? cantidad, // Comentario: Nombre cambiado
      String? descripcion,
      String? categoria, // Comentario: Añadido
      String? imagen, // Comentario: Nombre cambiado
      bool? estado // Comentario: Añadido
      }) {
    final index = _productos
        .indexWhere((p) => p.id == id); // Encuentra el índice del producto
    if (index != -1) {
      // Crea una copia modificada del producto y reemplaza el original en la lista
      _productos[index] = _productos[index].copyWith(
        nombre: nombre,
        unidadMedida: unidadMedida, // Comentario: Añadido
        precioUnidad: precioUnidad, // Comentario: Nombre y tipo cambiados
        cantidad: cantidad, // Comentario: Nombre cambiado
        descripcion: descripcion,
        categoria: categoria, // Comentario: Añadido
        imagen: imagen, // Comentario: Nombre cambiado
        estado: estado, // Comentario: Añadido
      );
      print('-> ProductoService: Producto con ID $id actualizado.');
      // Si usaras ChangeNotifier, notificarías aquí.
      return true; // Retorna true si se actualizó correctamente
    }
    print(
        '-> ProductoService: Error - Producto con ID $id no encontrado para actualizar.');
    return false; // Retorna false si el producto no se encontró
  }

  // Comentario: Elimina un producto por su ID (se mantiene igual)
  bool deleteProducto(String id) {
    final initialLength = _productos.length;
    _productos.removeWhere((p) => p.id == id); // Elimina el producto por ID
    if (_productos.length < initialLength) {
      print('-> ProductoService: Producto con ID $id eliminado.');
      // Si usaras ChangeNotifier, notificarías aquí.
      return true; // Retorna true si se eliminó
    }
    print(
        '-> ProductoService: Error - Producto con ID $id no encontrado para eliminar.');
    return false; // Retorna false si no se encontró
  }
}
