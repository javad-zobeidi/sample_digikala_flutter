import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:digikala/architecture/view/product_view.dart';
import 'package:digikala/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'architecture/presenter/product_presenter.dart';
import 'cart_list.dart';
import 'repository/model/product.dart';

ProductPresenter _presenter;
Products _provider;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Products())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: MyHomePage(title: 'دیجی کالا')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ProductView {
  _MyHomePageState() {
    _presenter = ProductPresenter(this);
    _presenter.productbycatid(1);
    _presenter.productbycatid(2);
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Consumer<Products>(builder: (_, provider, __) => Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (contex) => Cart()))),
              Positioned(top: 5,child: Text(provider.basket.length.toString()),)
            ],
          ),)
        ],
      ),
      body: Consumer<Products>(
        builder: (_, provider, __) => ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("دسته بندی شماره 1"), Text("نمایش همه")],
            ),
            Container(
              height: 200,
              child: provider.productCatOne != null
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: provider.productCatOne.items.length,
                      itemBuilder: (context, index) =>
                          item(provider.productCatOne.items[index]),
                    )
                  : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("دسته بندی شماره 2"), Text("نمایش همه")],
            ),

            Container(
              height: 200,
              child: provider.productCatTwo != null ? ListView.builder(
                scrollDirection:Axis.horizontal,
                shrinkWrap: true,
                itemCount: provider.productCatTwo.items.length,
                itemBuilder: (context, index) => item(provider.productCatTwo.items[index]),
              ) : Container(),
            )

          ],
        ),
      ),
    );
  }

  @override
  void onProductListSuccess(response) async {
    print(response);
    var respons = jsonDecode(response.toString());

   if(respons["section"] == "1")
      _provider.setProductCatOne(Product.fromJson(respons));

   if(respons["section"] == "2")
      _provider.setProductCatTwo(Product.fromJson(respons));


  }

  Widget item(ProductItem product) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 150,
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(product.image)),
              border: Border.all(width: 1, color: Colors.black38),
            ),
          ),
          Positioned(
              right: 1,
              child: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () => _provider.setAddProduct(product))),
          product.discount > 0
              ? Positioned(
                  top: 5, left: 5, child: Text(" %${product.discount} تخفیف"))
              : Container(),
          Positioned(
              bottom: 1,
              child: Container(
                  padding: EdgeInsets.only(right: 3, left: 3),
                  height: 65,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8))),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(3)),
                      Center(
                        child: Text(
                          product.price.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              decoration: product.discount > 0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      product.discount > 0
                          ? Center(
                              child: Text(
                                _provider
                                    .calcDiscount(
                                        product.price, product.discount)
                                    .toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container(),
                      Center(
                          child: Text(
                        product.name,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  )))
        ],
      ),
    );
  }
}
