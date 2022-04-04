import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Olá",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Entre ou Cadastre-se >",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                DrawerTile(
                  icon: Icons.home,
                  text: "Início",
                ),
                DrawerTile(
                  icon: Icons.list,
                  text: "Produtos",
                ),
                DrawerTile(
                  icon: Icons.location_on,
                  text: "Lojas",
                ),
                DrawerTile(
                  icon: Icons.playlist_add_check,
                  text: "Meus Pedidos",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}