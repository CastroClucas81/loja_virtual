import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  //passando o product para o Product_ProductScreenState
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  //remover o uso do "widget no stf"
  final ProductData product;

  _ProductScreenState(this.product);
  int current = 0;
  String? size;

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title.toString()),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 1.0,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    },
                  ),
                  items: product.images!.map((e) {
                    return Image.network(
                      e,
                      fit: BoxFit.cover,
                    );
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: product.images!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                  ),
                  Text(
                    'R\$ ${product.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Tamanho",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 34.0,
                    child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5,
                        ),
                        children: product.sizes!.map((e) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                size = e;
                              });
                            },
                            child: Container(
                              width: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                border: Border.all(
                                  color: e == size ? primaryColor : Colors.grey,
                                  width: 3.0,
                                ),
                              ),
                              child: Text(e),
                            ),
                          );
                        }).toList()),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      onPressed: size != null ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text(
                        "Adicionar ao Carrinho",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Descrição",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    product.description.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
