import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 32.0),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                  height: 170.0,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(
                          "Flutter's\nClothing",
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ol??, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!model.isLoggedIn()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    } else {
                                      model.signOut();
                                    }
                                  },
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou Cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                DrawerTile(
                  icon: Icons.home,
                  text: "In??cio",
                  pageController: pageController,
                  page: 0,
                ),
                DrawerTile(
                  icon: Icons.list,
                  text: "Produtos",
                  pageController: pageController,
                  page: 1,
                ),
                DrawerTile(
                  icon: Icons.location_on,
                  text: "Lojas",
                  pageController: pageController,
                  page: 2,
                ),
                DrawerTile(
                  icon: Icons.playlist_add_check,
                  text: "Meus Pedidos",
                  pageController: pageController,
                  page: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
