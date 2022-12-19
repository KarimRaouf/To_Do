import 'package:FlutterApplications/models/shop_app/favorites_model.dart';

class SearchModel {
  bool? status;
  DataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  int? currentPage;
  List<Product>? data;

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
