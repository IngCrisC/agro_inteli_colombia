import '../dominan/entities/producto.dart';
import 'usuario_service.dart';

class ProductoService {
  // Lista para almacenar los productos
  final List<Producto> _productos = [];

  final UsuariotService _usuarioService;

  ProductoService(this._usuarioService) {
    _addInitialData();
  }
  void _addInitialData() {
    final agricultor = _usuarioService.getUsuarioByCorreo('juan.a@example.com');

    if (agricultor != null && agricultor.rol == 'agricultor') {
      addProducto(
        agricultor.id,
        'Tomates Rojiros',
        'Kilogramo',
        5500,
        100,
        'Tomates frescos y orgánicos, cultivados localmente.',
        'Vegetales',
        'assets/icons/tomate.png',
        true,
      );
      addProducto(
        agricultor.id,
        'Papas Criollas',
        'Kilogramo',
        7800,
        150,
        'Papas criollas pequeñas y sabrosas, ideales para freír.',
        'Tuberculos',
        'assets/icons/Papa.jpg',
        true,
      );
      addProducto(
        agricultor.id,
        'Cebolla roja',
        'Kilogramo',
        3000,
        400,
        'Cebolla roja fresca, con sabor intenso y perfecta para realzar tus platos',
        'verduras',
        'assets/icons/Cebollaroja.jpg',
        true,
      );
      addProducto(
        agricultor.id,
        'Yuca',
        'Kilogramo',
        2500,
        250,
        'Yuca de excelente calidad, ideal para cocer, freír o preparar sopas tradicionales',
        'Tuberculos',
        'assets/icons/Yuca.jpg',
        true,
      );
      addProducto(
        agricultor.id,
        'Remolacha',
        'Kilogramo',
        8800,
        300,
        'Remolacha fresca y jugosa, rica en nutrientes y perfecta para ensaladas o jugos.',
        'Tuberculos',
        'assets/icons/Remolacha.jpg',
        true,
      );
      addProducto(
        agricultor.id,
        'Zanahoria',
        'Kilogramo',
        6200,
        520,
        'Zanahorias crujientes y dulces, ideales para cocinar o disfrutar como snack saludable.',
        'Verduras',
        'assets/icons/Zanahoria.jpg',
        true,
      );
    } else {
      print(
          '--- No se pudo añadir datos iniciales de productos: Agricultor "juan.a@example.com" no encontrado o no es un agricultor válido ---');
    }
  }

  // --- Métodos para los Productos ---

  Producto? addProducto(
      String agricultorId,
      String nombre,
      String unidadMedida,
      int precioUnidad,
      int cantidad,
      String descripcion,
      String categoria,
      String imagen,
      bool estado) {
    final agricultor = _usuarioService.getUsuarioById(agricultorId);
    if (agricultor == null || agricultor.rol != 'agricultor') {
      print(
          '-> ProductoService: Error - Usuario con ID $agricultorId no encontrado o no es un agricultor válido para añadir producto.');
      return null;
    }

    // Crear producto
    final nuevoProducto = Producto(
      agricultorId: agricultorId,
      nombre: nombre,
      unidadMedida: unidadMedida,
      precioUnidad: precioUnidad,
      cantidad: cantidad,
      descripcion: descripcion,
      categoria: categoria,
      imagen: imagen,
      estado: estado,
    );

    _productos.add(nuevoProducto);
    print(
        '-> ProductoService: Producto "${nuevoProducto.nombre}" añadido por Agricultor ID ${agricultorId}.');
    return nuevoProducto;
  }

  // Obtener todos los productos
  List<Producto> getAllProductos() {
    return List.from(_productos);
  }

  // Obtener productos por agricultor
  List<Producto> getProductosByAgricultor(String agricultorId) {
    return _productos.where((p) => p.agricultorId == agricultorId).toList();
  }

  // Busca un producto por el id
  Producto? getProductoById(String id) {
    return _productos.firstWhereOrNull((p) => p.id == id);
  }

  bool updateProducto(String id,
      {String? nombre,
      String? unidadMedida,
      int? precioUnidad,
      int? cantidad,
      String? descripcion,
      String? categoria,
      String? imagen,
      bool? estado}) {
    final index = _productos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _productos[index] = _productos[index].copyWith(
        nombre: nombre,
        unidadMedida: unidadMedida,
        precioUnidad: precioUnidad,
        cantidad: cantidad,
        descripcion: descripcion,
        categoria: categoria,
        imagen: imagen,
        estado: estado,
      );
      print('-> ProductoService: Producto con ID $id actualizado.');
      return true;
    }
    print(
        '-> ProductoService: Error - Producto con ID $id no encontrado para actualizar.');
    return false;
  }

  // Eliminar producto
  bool deleteProducto(String id) {
    final initialLength = _productos.length;
    _productos.removeWhere((p) => p.id == id);
    if (_productos.length < initialLength) {
      print('-> ProductoService: Producto con ID $id eliminado.');
      return true;
    }
    print(
        '-> ProductoService: Error - Producto con ID $id no encontrado para eliminar.');
    return false;
  }
}
