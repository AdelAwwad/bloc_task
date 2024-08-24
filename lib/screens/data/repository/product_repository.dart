
import 'dart:convert';
import 'package:bloc_api/data/network_provider.dart';
import 'package:bloc_api/screens/data/Product_model.dart';
import 'package:http/http.dart';

class ProductRepository {

  Future<List<Product>> getProduct() async{
    Response response = await NetworkProvider.getRequest("https://dummyjson.com/products");
    if(response.statusCode ==200){
      ProductsModel ProductModel = ProductsModel.fromJson(jsonDecode(response.body));
      return ProductModel.products ;
    }else {
      throw 'error loading product';
    }

  }
}