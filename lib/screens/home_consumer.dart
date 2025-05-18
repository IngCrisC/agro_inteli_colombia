import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../../core/string.dart';

class HomeConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/Home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/cart');
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

                ProductosWidget(), //Clase para los slide

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
                ProductosWidget(),
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
          Padding(
              padding: EdgeInsets.only(
                left: 0,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 184, 178, 178),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    //Texto de la Barra de buscar
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Buscar producto...",
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
          Spacer(),
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
              color: const Color.fromARGB(255, 184, 178, 178),
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

class ProductosWidget extends StatelessWidget {
  final List<Map<String, String>> productos = [
    {
      "nombre": "Zanahoria",
      "imagen": "Zanahoria.jpg",
      "cantidad": "20 Cargas Disponibles",
      "precio": "\$110.000 Unid."
    },
    {
      "nombre": "Papa",
      "imagen": "Papa.jpg",
      "cantidad": "200 Bultos Disponibles",
      "precio": "\$90.000 Unid."
    },
    {
      "nombre": "Remolacha",
      "imagen": "Remolacha.jpg",
      "cantidad": "400 cargas disponibles",
      "precio": "\$70.000 Unid."
    },
    {
      "nombre": "Cebolla Roja",
      "imagen": "Cebollaroja.jpg",
      "cantidad": "150 cargas disponibles",
      "precio": "\$85.000 Unid."
    },
    {
      "nombre": "Yuca",
      "imagen": "Yuca.jpg",
      "cantidad": "100 bultos disponibles",
      "precio": "\$95.000 Unid."
    },
    {
      "nombre": "Rábano",
      "imagen": "Rabano.jpg",
      "cantidad": "50 cargas disponibles",
      "precio": "\$60.000 Unid."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: productos.map((producto) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 184, 178, 178),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/${producto['imagen']}",
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text(
                  producto['nombre']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  producto['cantidad']!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  producto['precio']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
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
