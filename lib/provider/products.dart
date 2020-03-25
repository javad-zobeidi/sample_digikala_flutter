import 'package:digikala/repository/model/product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {

  Product _product;
  Product _product2;
  Product _product3;




  List<ProductItem> _cartList = [];



  Product get productCatOne => _product;
  Product get productCatTwo => _product2;
  Product get productCatThree => _product3;



  List<ProductItem> get basket => _cartList;



  setProductCatOne(product) {
    _product = product;
    notifyListeners();
  }

   setProductCatTwo(product) {
    _product2 = product;
    print(_product2);
    notifyListeners();
  }

 setProductCatThree(product) {
    _product3 = product;
    notifyListeners();
  }

  setAddProduct(product) {
    _cartList.add(product);
    notifyListeners();
  }

 
  List<ProductItem> get getCartList {
    return List.from(_cartList);
  }


  double get getCartPrice {
    double price = 0;
    
    getCartList.forEach((ProductItem pro) {
      if(pro.discount > 0){
        price += calcDiscount(pro.price,pro.discount);
      }else
        price += pro.price;

    });
    return price;
  }



  dynamic calcDiscount(int price, int discount) {
    return price - ((discount / 100) * price);
  }

    
}
