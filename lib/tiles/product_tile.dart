import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  const ProductTile({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: data),
          ),
        );
      },
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      data.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            data.title.toString(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${data.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      data.images![0],
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title.toString(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${data.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
