

import 'package:digikala/architecture/model/product_model.dart';
import 'package:digikala/architecture/view/product_view.dart';

class ProductPresenter{
  ProductView _view;
  ProductModel _model = ProductModel();

  ProductPresenter(ProductView view){
    _view = view;
  }


  void productbycatid(int catId) async {
    _model.productbycatid(catId).then((response) => _view.onProductListSuccess(response));
  }
}