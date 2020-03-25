import 'dart:async';

import 'package:digikala/repository/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarinpal/zarinpal.dart';

import 'cart_card.dart';
import 'provider/products.dart';



  
class Cart extends StatelessWidget {

  Widget _buildProductItems(
      BuildContext context, int position, ProductItem product) {
    return CartCard(product);
  }

  Widget _buildProductList(List<ProductItem> products, double prce) {
    Widget productCard;
    if (products.length > 0) {
      productCard = SafeArea(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  _buildProductItems(
                context,
                index,
                products[index],
              ),


              itemCount: products.length,


            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {


                  PaymentRequest _paymentRequest = PaymentRequest()
                    ..setIsSandBox(true) // if your application is in developer mode, then set the sandBox as True otherwise set sandBox as false
                    ..setMerchantID("3e7108f0-4a7e-11e7-9354-005056a205be")
                    ..setAmount(prce)
                    ..setCallbackURL("https://codevolution.ir/digikala/api/v1/productbycatid/1") //The callback can be an android scheme or a website URL, you and can pass any data with The callback for both scheme and  URL
                    ..setDescription("خرید درون برنامه ای");



                  ZarinPal().startPayment(_paymentRequest,
                      (int status, String paymentGatewayUri) {
                    if (status == 100)
                      print(paymentGatewayUri); // launch URL in browser
                  });




                },
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(15),
                  width: 380,
                  child: Center(
                    child: Text(
                      "جمع کل  ${prce.toString()} پرداخت",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
      // productCard = Center(child: Text(products.length.toString()));
    } else {
      productCard = Center(child: Text('محصولی افزوده نشده'));
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سبد خرید"),
      ),
      body: Consumer<Products>(
        builder: (context, provider, child) =>
            _buildProductList(provider.getCartList, provider.getCartPrice),
      ),
    );
  }



}