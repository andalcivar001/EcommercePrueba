import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListBloc.dart';
import 'package:flutter/material.dart';

class Productlistitem extends StatelessWidget {
  ProductListBloc? bloc;
  Product product;
  Productlistitem(this.bloc, this.product);

  @override
  Widget build(BuildContext context) {
    final imagen1 = product.imagen1 ?? '';
    final imagen2 = product.imagen2 ?? '';
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            product.descripcion,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Cod Alterno:',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    product.codAlterno ?? '',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Stock:',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    product.stock.toString(),
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          leading: imagen1.isNotEmpty
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF1E3C72), width: 2),
                  ),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      image: imagen1,
                      placeholder: 'assets/img/user_image.png',
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    ),
                  ),
                )
              : imagen2.isNotEmpty
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF1E3C72), width: 2),
                  ),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      image: imagen2,
                      placeholder: 'assets/img/user_image.png',
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 30,

                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.category,
                    size: 40,
                    color: Color(0xFF1E3C72),
                  ),
                ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'product/form',
                    arguments: product.id,
                  );
                },
                child: Icon(Icons.edit, size: 20, color: Colors.blue),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.delete, size: 20, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
