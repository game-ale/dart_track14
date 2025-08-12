/// Repository Contract: Defines the operations related to Product entities.
/// Lives in the domain layer: lib/domain/repositories/product_repository.dart
/// Contains NO implementation details — only business-level operations.
/// Returns and accepts Entities (not data models, DTOs, or framework types).

import '../entities/product.dart';

abstract class ProductRepository {
  /// Fetch a single product by its unique ID.
  /// Throws [ProductNotFoundException] if the product doesn't exist.
  Future<Product> getProduct(String id);

  /// Fetch all products available in the system.
  /// Returns an empty list if no products exist.
  Future<List<Product>> getAllProducts();

  /// Search products by name or other criteria.
  /// [query] is the search term; can be partial or full.
  Future<List<Product>> searchProducts(String query);

  /// Add a new product to the system.
  /// Returns the created [Product] with its generated ID.
  Future<Product> addProduct(Product product);

  /// Update an existing product.
  /// Returns the updated [Product].
  /// Throws [ProductNotFoundException] if the product doesn't exist.
  Future<Product> updateProduct(Product product);

  /// Delete a product by ID.
  /// Returns true if deletion was successful, false otherwise.
  Future<bool> deleteProduct(String id);
}