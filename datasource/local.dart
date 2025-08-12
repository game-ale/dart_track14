import 'package:hive/hive.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box box;

  ProductLocalDataSourceImpl({required this.box});

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final data = box.get('products', defaultValue: []) as List;
    return data.map((json) => ProductModel.fromJson(Map<String, dynamic>.from(json))).toList();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await box.put(
      'products',
      products.map((p) => p.toJson()).toList(),
    );
  }
}
