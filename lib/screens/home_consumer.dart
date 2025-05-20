import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../../core/string.dart';
import '../services/producto_service.dart';
import '../dominan/entities/producto.dart';

class HomeConsumer extends StatelessWidget {
  final ProductoService productoService;
  const HomeConsumer({Key? key, required this.productoService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/HomeConsumidor');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/shoppingCart');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            //height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                //TITULO CATEGORIAS
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                //Se llama la clase del slide de las categorias
                CategoriasWidget(),

                //Productos
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Tuberculos y raices",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                ProductosWidget(
                    productoService: productoService), //Clase para los slide

                //Titulo de la siguiente fila de slides
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Hortalizas",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                //Se llama la clase de los slides
                ProductosWidget(productoService: productoService),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Header y cuadro de busqueda
class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/agro-inteli-colombia.png",
            width: 50,
            height: 50,
          ),
          Expanded(
            // Comentario: Envuelve el padding/columna de búsqueda en Expanded
            child: Padding(
                padding: EdgeInsets.only(
                  left: 0, // Ajusta si es necesario
                ),
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric( // Comentario: Margen horizontal puede ser redundante con el padding del padre
                      //   horizontal: 15,
                      // ),
                      margin: EdgeInsets.only(
                          left: 15, right: 15), // Comentario: Ajuste de margen
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      //Texto de la Barra de buscar
                      child: Row(
                        children: [
                          // Comentario: Expanded para que el TextFormField tome el espacio disponible en el Row
                          Expanded(
                            // Comentario: Envuelve TextFormField en Expanded
                            child: Container(
                              // Comentario: Mantenemos el Container si tiene propósitos de layout
                              // margin: EdgeInsets.only(left: 0), // Comentario: Este margen puede ser innecesario con Expanded
                              height: 50, // Altura del Container
                              // width: 100, // Comentario: Eliminamos width fijo para que Expanded funcione
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Buscar producto...",
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Badge(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Icon(
                Icons.exit_to_app_sharp,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Slide de categorias
class CategoriasWidget extends StatelessWidget {
  //Se crea una lista de mapas para los diferentes slide
  final List<Map<String, String>> categorias = [
    {"nombre": "Frutas", "imagen": "1.jpg"},
    {"nombre": "Verduras", "imagen": "2.jpg"},
    {"nombre": "Tubérculos", "imagen": "3.jpg"},
    {"nombre": "Granos", "imagen": "4.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categorias.map((categoria) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/${categoria['imagen']}",
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 8),
                Text(
                  categoria['nombre']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProductosWidget extends StatefulWidget {
  // Comentario: Campo para recibir el ProductoService
  final ProductoService productoService;

  // Comentario: Constructor que requiere el ProductoService
  const ProductosWidget({Key? key, required this.productoService})
      : super(key: key);

  @override
  State<ProductosWidget> createState() => _ProductosWidgetState();
}

class _ProductosWidgetState extends State<ProductosWidget> {
  // Comentario: Lista para almacenar los productos obtenidos del servicio
  List<Producto> _productos = [];
  // Comentario: Variable para indicar si se está cargando (opcional para UI)
  bool _isLoading = true;

  // Comentario: Método que se llama al inicializar el widget
  @override
  void initState() {
    super.initState();
    // Comentario: Llamar al método para cargar los productos
    _loadProductos();
  }

  // Comentario: Método para cargar los productos del servicio
  void _loadProductos() {
    // Comentario: Obtiene todos los productos del servicio
    final fetchedProductos = widget.productoService.getAllProductos();
    // Comentario: Actualiza el estado del widget con los productos obtenidos
    setState(() {
      _productos = fetchedProductos;
      _isLoading = false; // Comentario: La carga ha terminado
    });
  }

  @override
  Widget build(BuildContext context) {
    // Comentario: Muestra un indicador de carga mientras se obtienen los productos
    if (_isLoading) {
      return const Center(
          child:
              CircularProgressIndicator()); // Comentario: Muestra un spinner de carga
    }

    // Comentario: Si no hay productos, muestra un mensaje
    if (_productos.isEmpty) {
      return const Center(
          child: Text(
              'No hay productos disponibles.')); // Comentario: Mensaje si la lista está vacía
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _productos.map((producto) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  producto.imagen,
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text(
                  producto.nombre,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${producto.cantidad} - ${producto.unidadMedida}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${producto.precioUnidad}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('${producto.nombre} añadido al carrito')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  child: Text("Agregar al carrito"),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
