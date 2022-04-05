import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/products_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          body: SafeArea(
            child: HomeTab(),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          body: ProductsTab(),
        )
      ],
    );
  }
}
