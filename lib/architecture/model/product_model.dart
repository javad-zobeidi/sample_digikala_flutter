import 'package:digikala/data/network/api_provider.dart';

class ProductModel {
  Future<dynamic> productbycatid(int catId) async {
    return ApiProvider().productbycatid(catId);
  }
}
