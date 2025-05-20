import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../dominan/entities/producto.dart';
import '../services/producto_service.dart';
import '../services/usuario_service.dart';
import '../screens/product_detail_screen.dart';

class HomeConsumer extends StatelessWidget {
  final ProductoService productoService;
  final UsuariotService usuarioService;

  const HomeConsumer(
      {Key? key, required this.productoService, required this.usuarioService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, Routes.HomeC);
          } else if (index == 1) {
            Navigator.pushNamed(context, Routes.cartDetail);
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
                  productoService: productoService,
                  usuarioService: usuarioService,
                ),

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
                ProductosWidget(
                  productoService: productoService,
                  usuarioService: usuarioService,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Buscar producto...",
                              ),
                            ),
                          ),
                        ),
                        // Icono de búsqueda
                        Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          ),
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
  final ProductoService productoService;
  final UsuariotService usuarioService;

  const ProductosWidget(
      {Key? key, required this.productoService, required this.usuarioService})
      : super(key: key);

  @override
  State<ProductosWidget> createState() => _ProductosWidgetState();
}

class _ProductosWidgetState extends State<ProductosWidget> {
  List<Producto> _productos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  void _loadProductos() {
    final fetchedProductos = widget.productoService.getAllProductos();
    setState(() {
      _productos = fetchedProductos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_productos.isEmpty) {
      return const Center(child: Text('No hay productos disponibles.'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _productos.map((producto) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.productDetail,
                arguments: {
                  'product': producto,
                  'usuarioService': widget.usuarioService,
                },
              );
            },
            child: Container(
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
                    '${producto.cantidad} - ${producto.unidadMedida}s disponibles',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$ ' + '${producto.precioUnidad} unidad',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
