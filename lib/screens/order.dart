import 'package:agro_inteli_colombia/core/colors.dart';
import 'package:agro_inteli_colombia/core/string.dart';
import 'package:flutter/material.dart';

// Este widget muestra una línea con un título y un valor (como una fila)
class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // Sin margen interno
      dense: true, // Hace la fila más compacta
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value,
          textAlign: TextAlign.right), // Texto alineado a la derecha
    );
  }
}

// Este widget muestra la información de cada producto del pedido
class ProductoItem extends StatelessWidget {
  final String imageUrl;
  final String nombre;
  final String origen;
  final String calidad;
  final String precio;

  const ProductoItem({
    required this.imageUrl,
    required this.nombre,
    required this.origen,
    required this.calidad,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8), // Espacio arriba y abajo
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación desde arriba
        children: [
          // Imagen del producto
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados
            child: Image.network(imageUrl,
                width: 60, height: 60, fit: BoxFit.cover), // Imagen cuadrada
          ),
          SizedBox(width: 12), // Espacio entre imagen y texto
          // Parte de la descripción
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(origen),
                Text('Calidad: $calidad'),
              ],
            ),
          ),
          // Precio del producto
          Expanded(
            flex: 2,
            child: Text(precio, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Esta clase muestra la pantalla con los detalles del pedido
class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Parte de arriba de la app
      appBar: AppBar(
        title: Text(
          AppStrings.orderDetail, // Título de la pantalla
          style: TextStyle(color: AppColors.secondaryColor), // Color del texto
        ),
        centerTitle: true, // El texto del título va en el centro
        backgroundColor: Colors.white, // Fondo blanco
        elevation: 1, // Sombra leve abajo del AppBar
        iconTheme: IconThemeData(color: Colors.black), // Íconos en negro
      ),
      // Parte principal donde mostramos la info
      body: ListView(
        padding: EdgeInsets.all(16), // Margen alrededor del contenido
        children: [
          // Mostramos info básica del pedido
          InfoRow(title: AppStrings.customer, value: AppStrings.customer),
          InfoRow(title: AppStrings.delivery, value: AppStrings.deliveryPrice),
          InfoRow(title: AppStrings.payment, value: AppStrings.payOnDelivery),
          InfoRow(title: AppStrings.company, value: AppStrings.companyName),
          InfoRow(title: AppStrings.address, value: AppStrings.addressDetail),
          Divider(height: 32), // Línea divisora
          // Título de la parte de productos
          Text(
            AppStrings.products,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // Espacio entre el título y los datos
          // Encabezado de la tabla de productos
          Row(
            children: [
              Expanded(flex: 1, child: Text('')), // Espacio para la imagen
              Expanded(flex: 3, child: Text('Descripción')),
              Expanded(flex: 2, child: Text('Precio')),
            ],
          ),

          SizedBox(height: 8), // Espacio entre encabezado y productos
          // Producto 1
          ProductoItem(
            imageUrl:
                'https://cdn.pixabay.com/photo/2017/06/16/14/35/watermelon-2409368_1280.jpg',
            nombre: AppStrings.watermelon,
            origen: AppStrings.fromAnolaima,
            calidad: '2',
            precio: AppStrings.price1,
          ),
          ProductoItem(
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/08/11/21/26/pear-1586866_1280.jpg',
            nombre: AppStrings.pear,
            origen: AppStrings.fromJenesano,
            calidad: '2',
            precio: AppStrings.price2,
          ),

          SizedBox(height: 24), // Espacio antes del botón
          // Botón para confirmar el envío
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor, // Color del botón
              ),
              onPressed: () {
                // Aquí va lo que pasa cuando se presiona el botón
              },
              child: Text(AppStrings.confirmShipping,
                  style: TextStyle(fontSize: 16, color: AppColors.background)),
            ),
          )
        ],
      ),
    );
  }
}
