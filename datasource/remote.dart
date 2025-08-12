import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Fetch all products from server
  Future<List<ProductModel>> getAllProducts();

  /// Fetch a single product by ID
  Future<ProductModel> getProductById(String id);

  /// Create a new product
  Future<ProductModel> createProduct(ProductModel product);

  /// Update an existing product
  Future<ProductModel> updateProduct(ProductModel product);

  /// Delete a product by ID
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get('/products');
    final List data = response.data as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await client.post(
      '/products',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await client.put(
      '/products/${product.id}',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await client.delete('/products/$id');
  }
}
