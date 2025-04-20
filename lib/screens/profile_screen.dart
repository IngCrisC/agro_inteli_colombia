import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/colors.dart';
import '../../core/string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.secondaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Image.asset(
              'assets/icons/agro-inteli-colombia.png',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.dataUser,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Correo: carlos@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Teléfono: 313505846',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Dirección: calle 45, Bogotá Cundinamarca',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              Routes.profile); //cambair al home
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppStrings.editProfile,
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              Routes.login); //cambair al home
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                              color: AppColors.secondaryColor, width: 3),
                        ),
                        child: Text(
                          AppStrings.changePassword,
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.shopping,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.products,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.price,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                ProductItem(
                  image: 'assets/icons/logo.jpeg',
                  title: 'Sandía',
                  description: 'De Anolaima\nCalidad: 2',
                  price: '\$200.000',
                ),
                ProductItem(
                  image: 'assets/icons/logo.jpeg',
                  title: 'Pera',
                  description: 'De Jenesano\nCalidad: 2',
                  price: '\$140.000',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;

  const ProductItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(description),
              ],
            ),
          ),
          Text(price,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
